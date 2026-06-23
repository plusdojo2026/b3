package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BreakdownDao;
import dao.PaymentDao;
import dao.WalletDao;
import dto.Breakdown;
import dto.Payment;
import dto.User;
import dto.Wallet;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 支出登録画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String amount = request.getParameter("amount");

		if (amount != null) {
			request.setAttribute("amount", amount);
		}

		request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
	}

	// 支出登録処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		String lang = (String) session.getAttribute("currentLang");

		Locale locale = "en".equals(lang) ? Locale.ENGLISH : Locale.JAPANESE;

		ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);

		String amountStr = request.getParameter("amount");
		String action = request.getParameter("action");
		String[] usableMoneyTypeStrs = request.getParameterValues("moneyType");

		// 入力値チェック
		if (amountStr == null || amountStr.length() == 0) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.amount.empty"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		if (!amountStr.matches("^[0-9]+$")) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.amount.numeric"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		// 入力値を数値に変換
		int amount = Integer.parseInt(amountStr);

		if (amount <= 0) {
			request.setAttribute("errorMsg",bundle.getString("payment.error.amount.min") );
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		if (amount >= 1000000) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.amount.max"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		WalletDao walletDao = new WalletDao();
		Wallet wallet = null;

		try {
			wallet = walletDao.selectById(loginUser.getWalletId());
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMsg",  bundle.getString("payment.error.wallet.fetch"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		// 財布情報チェック
		if (wallet == null) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.wallet.notfound"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		// 別の支払方法分岐
		if ("other".equals(action)) {
			request.setAttribute("manualMode", true);
			request.setAttribute("amount", amount);
			request.getRequestDispatcher("/WEB-INF/jsp/payment_suggestion.jsp").forward(request, response);
			return;
		}

		if ("confirm".equals(action)) {
			int[] confirmMoneyTypes = { 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 };
			int[] confirmPayCounts = new int[confirmMoneyTypes.length];

			for (int i = 0; i < confirmPayCounts.length; i++) {
				String payCountStr = request.getParameter("payCount" + i);

				if (payCountStr == null || payCountStr.length() == 0) {
					confirmPayCounts[i] = 0;
				} else if (!payCountStr.matches("^[0-9]+$")) {
					request.setAttribute("errorMsg", bundle.getString("payment.error.count.numeric"));
					request.setAttribute("manualMode", true);
					request.setAttribute("amount", amount);
					request.getRequestDispatcher("/WEB-INF/jsp/payment_suggestion.jsp").forward(request, response);
					return;
				} else {
					confirmPayCounts[i] = Integer.parseInt(payCountStr);
				}
			}

			int confirmPayAmount = 0;

			for (int i = 0; i < confirmMoneyTypes.length; i++) {
				confirmPayAmount += confirmMoneyTypes[i] * confirmPayCounts[i];
			}

			if (confirmPayAmount == 0) {
				request.setAttribute("errorMsg", bundle.getString("payment.error.count.min"));
				request.setAttribute("manualMode", true);
				request.setAttribute("amount", amount);
				request.setAttribute("moneyTypes", confirmMoneyTypes);
				request.setAttribute("payCounts", confirmPayCounts);
				request.getRequestDispatcher("/WEB-INF/jsp/payment_suggestion.jsp").forward(request, response);
				return;
			}
			if (confirmPayAmount < amount) {
				request.setAttribute("errorMsg", bundle.getString("payment.error.amount.shortage"));
				request.setAttribute("manualMode", true);
				request.setAttribute("amount", amount);
				request.setAttribute("moneyTypes", confirmMoneyTypes);
				request.setAttribute("payCounts", confirmPayCounts);
				request.getRequestDispatcher("/WEB-INF/jsp/payment_suggestion.jsp").forward(request, response);
				return;
			}
			int[] currentWalletCounts = { wallet.getTenThousandYen(), wallet.getFiveThousandYen(),
					wallet.getOneThousandYen(), wallet.getFiveHundredYen(), wallet.getOneHundredYen(),
					wallet.getFiftyYen(), wallet.getTenYen(), wallet.getFiveYen(), wallet.getOneYen() };

			for (int i = 0; i < confirmPayCounts.length; i++) {
				if (confirmPayCounts[i] > currentWalletCounts[i]) {
					request.setAttribute("errorMsg", bundle.getString("payment.error.count.over"));
					request.setAttribute("manualMode", true);
					request.setAttribute("amount", amount);
					request.setAttribute("moneyTypes", confirmMoneyTypes);
					request.setAttribute("payCounts", confirmPayCounts);
					request.getRequestDispatcher("/WEB-INF/jsp/payment_suggestion.jsp").forward(request, response);
					return;
				}
			}

			int confirmChange = confirmPayAmount - amount;

			Connection conn = null;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");

				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
						"root", "password");

				conn.setAutoCommit(false);

				PaymentDao paymentDao = new PaymentDao();
				Payment payment = new Payment(0, loginUser.getId(), amount);
				int paymentId = paymentDao.insert(conn, payment);

				BreakdownDao breakdownDao = new BreakdownDao();

				for (int i = 0; i < confirmMoneyTypes.length; i++) {
					if (confirmPayCounts[i] > 0) {
						Breakdown breakdown = new Breakdown(0, paymentId, confirmMoneyTypes[i], confirmPayCounts[i]);
						breakdownDao.insert(conn, breakdown);
					}
				}

				int[] changeCounts = new int[confirmMoneyTypes.length];
				int changeRemaining = confirmChange;

				for (int i = 0; i < confirmMoneyTypes.length; i++) {
					changeCounts[i] = changeRemaining / confirmMoneyTypes[i];
					changeRemaining = changeRemaining % confirmMoneyTypes[i];
				}

				wallet.setTenThousandYen(wallet.getTenThousandYen() - confirmPayCounts[0] + changeCounts[0]);
				wallet.setFiveThousandYen(wallet.getFiveThousandYen() - confirmPayCounts[1] + changeCounts[1]);
				wallet.setOneThousandYen(wallet.getOneThousandYen() - confirmPayCounts[2] + changeCounts[2]);
				wallet.setFiveHundredYen(wallet.getFiveHundredYen() - confirmPayCounts[3] + changeCounts[3]);
				wallet.setOneHundredYen(wallet.getOneHundredYen() - confirmPayCounts[4] + changeCounts[4]);
				wallet.setFiftyYen(wallet.getFiftyYen() - confirmPayCounts[5] + changeCounts[5]);
				wallet.setTenYen(wallet.getTenYen() - confirmPayCounts[6] + changeCounts[6]);
				wallet.setFiveYen(wallet.getFiveYen() - confirmPayCounts[7] + changeCounts[7]);
				wallet.setOneYen(wallet.getOneYen() - confirmPayCounts[8] + changeCounts[8]);

				String walletSql = "UPDATE wallets SET " + "ten_thousand_yen = ?, " + "five_thousand_yen = ?, "
						+ "one_thousand_yen = ?, " + "five_hundred_yen = ?, " + "one_hundred_yen = ?, "
						+ "fifty_yen = ?, " + "ten_yen = ?, " + "five_yen = ?, " + "one_yen = ? " + "WHERE id = ?";
				PreparedStatement walletStmt = conn.prepareStatement(walletSql);

				walletStmt.setInt(1, wallet.getTenThousandYen());
				walletStmt.setInt(2, wallet.getFiveThousandYen());
				walletStmt.setInt(3, wallet.getOneThousandYen());
				walletStmt.setInt(4, wallet.getFiveHundredYen());
				walletStmt.setInt(5, wallet.getOneHundredYen());
				walletStmt.setInt(6, wallet.getFiftyYen());
				walletStmt.setInt(7, wallet.getTenYen());
				walletStmt.setInt(8, wallet.getFiveYen());
				walletStmt.setInt(9, wallet.getOneYen());
				walletStmt.setInt(10, loginUser.getWalletId());

				walletStmt.executeUpdate();

				conn.commit();

				request.setAttribute("successMsg", bundle.getString("payment.success.register"));
				request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
				return;

			} catch (Exception e) {
				e.printStackTrace();

				if (conn != null) {
					try {
						conn.rollback();
					} catch (Exception rollbackException) {
						rollbackException.printStackTrace();
					}
				}

				request.setAttribute("errorMsg", bundle.getString("payment.error.register"));
				request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
				return;
			} finally {
				if (conn != null) {
					try {
						conn.close();
					} catch (Exception closeException) {
						closeException.printStackTrace();
					}
				}
			}
		}

		// 財布合計算出
		int walletTotal = wallet.getTenThousandYen() * 10000 + wallet.getFiveThousandYen() * 5000
				+ wallet.getOneThousandYen() * 1000 + wallet.getFiveHundredYen() * 500 + wallet.getOneHundredYen() * 100
				+ wallet.getFiftyYen() * 50 + wallet.getTenYen() * 10 + wallet.getFiveYen() * 5 + wallet.getOneYen();

		if (amount > walletTotal) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.wallet.total"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		// 金種配列作成
		int[] moneyTypes = { 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 };

		int[] walletCounts = { wallet.getTenThousandYen(), wallet.getFiveThousandYen(), wallet.getOneThousandYen(),
				wallet.getFiveHundredYen(), wallet.getOneHundredYen(), wallet.getFiftyYen(), wallet.getTenYen(),
				wallet.getFiveYen(), wallet.getOneYen() };
		// 使用可否
		boolean[] usableMoneyTypes = new boolean[moneyTypes.length];

		for (int i = 0; i < moneyTypes.length; i++) {
			usableMoneyTypes[i] = false;
		}

		if (usableMoneyTypeStrs != null) {
			for (String usableMoneyTypeStr : usableMoneyTypeStrs) {
				int usableMoneyType = Integer.parseInt(usableMoneyTypeStr);

				for (int i = 0; i < moneyTypes.length; i++) {
					if (moneyTypes[i] == usableMoneyType) {
						usableMoneyTypes[i] = true;
					}
				}
			}
		}
		for (int i = 0; i < walletCounts.length; i++) {
			if (!usableMoneyTypes[i]) {
				walletCounts[i] = 0;
			}
		}
		// 使用可能金種が0でないかチェック
		int usableWalletTotal = 0;

		for (int i = 0; i < moneyTypes.length; i++) {
			usableWalletTotal += moneyTypes[i] * walletCounts[i];
		}

		if (usableWalletTotal == 0) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.money.select"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		if (amount > usableWalletTotal) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.money.insufficient"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		// 最適組み合わせ配列作成
		int[] bestPayCounts = null;
		int bestChangeCoinCount = Integer.MAX_VALUE;
		int bestPayCoinCount = Integer.MAX_VALUE;
		int bestPayAmount = 0;

		int maxSearchAmount = Math.min(walletTotal, amount + 9999);

		boolean[] canPay = new boolean[maxSearchAmount + 1];
		int[][] payCountTable = new int[maxSearchAmount + 1][moneyTypes.length];

		canPay[0] = true;

		for (int i = 0; i < moneyTypes.length; i++) {
			for (int count = 0; count < walletCounts[i]; count++) {
				for (int price = maxSearchAmount - moneyTypes[i]; price >= 0; price--) {
					if (canPay[price] && !canPay[price + moneyTypes[i]]) {
						canPay[price + moneyTypes[i]] = true;

						for (int j = 0; j < moneyTypes.length; j++) {
							payCountTable[price + moneyTypes[i]][j] = payCountTable[price][j];
						}

						payCountTable[price + moneyTypes[i]][i]++;
					}
				}
			}
		}

		int[] changeMoneyTypes = { 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 };

		for (int payAmount = amount; payAmount <= maxSearchAmount; payAmount++) {
			if (!canPay[payAmount]) {
				continue;
			}

			int change = payAmount - amount;
			int changeRemaining = change;
			int changeCoinCount = 0;

			for (int i = 0; i < changeMoneyTypes.length; i++) {
				changeCoinCount += changeRemaining / changeMoneyTypes[i];
				changeRemaining = changeRemaining % changeMoneyTypes[i];
			}

			int payCoinCount = 0;

			for (int i = 0; i < moneyTypes.length; i++) {
				payCoinCount += payCountTable[payAmount][i];
			}

			if (changeCoinCount < bestChangeCoinCount
					|| (changeCoinCount == bestChangeCoinCount && payCoinCount < bestPayCoinCount)
					|| (changeCoinCount == bestChangeCoinCount && payCoinCount == bestPayCoinCount
							&& payAmount < bestPayAmount)) {

				bestChangeCoinCount = changeCoinCount;
				bestPayCoinCount = payCoinCount;
				bestPayAmount = payAmount;
				bestPayCounts = payCountTable[payAmount].clone();
			}
		}

		if (bestPayCounts == null) {
			request.setAttribute("errorMsg", bundle.getString("payment.error.combination.notfound"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		int change = bestPayAmount - amount;

		request.setAttribute("amount", amount);
		request.setAttribute("payAmount", bestPayAmount);
		request.setAttribute("change", change);
		request.setAttribute("moneyTypes", moneyTypes);
		request.setAttribute("payCounts", bestPayCounts);

		request.getRequestDispatcher("/WEB-INF/jsp/payment_suggestion.jsp").forward(request, response);
		return;
	}

}
