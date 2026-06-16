package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import dao.WalletDao;
import dao.PaymentDao;
import dao.BreakdownDao;
import dto.User;
import dto.Wallet;
import dto.Payment;
import dto.Breakdown;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 支出登録画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
	}

	// 支出登録処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String amountStr = request.getParameter("amount");

		// 入力値チェック
		if (amountStr == null || amountStr.length() == 0) {
			request.setAttribute("errorMsg", "金額を入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		if (!amountStr.matches("^[0-9]+$")) {
			request.setAttribute("errorMsg", "金額は半角数字で入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		// 入力値を数値に変換
		int amount = Integer.parseInt(amountStr);

		if (amount <= 0) {
			request.setAttribute("errorMsg", "1円以上の金額を入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		if (amount >= 1000000) {
			request.setAttribute("errorMsg", "100万円未満の金額を入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}
		HttpSession session = request.getSession();
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
			request.setAttribute("errorMsg", "財布情報の取得に失敗しました。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		if (wallet == null) {
			request.setAttribute("errorMsg", "財布情報が見つかりませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		// 財布合計算出
		int walletTotal = wallet.getTenThousandYen() * 10000 + wallet.getFiveThousandYen() * 5000
				+ wallet.getOneThousandYen() * 1000 + wallet.getFiveHundredYen() * 500 + wallet.getOneHundredYen() * 100
				+ wallet.getFiftyYen() * 50 + wallet.getTenYen() * 10 + wallet.getFiveYen() * 5 + wallet.getOneYen();

		if (amount > walletTotal) {
			request.setAttribute("errorMsg", "財布の合計金額を超えています。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		// 金種配列作成
		int[] moneyTypes = { 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 };

		int[] walletCounts = { wallet.getTenThousandYen(), wallet.getFiveThousandYen(), wallet.getOneThousandYen(),
				wallet.getFiveHundredYen(), wallet.getOneHundredYen(), wallet.getFiftyYen(), wallet.getTenYen(),
				wallet.getFiveYen(), wallet.getOneYen() };

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
			request.setAttribute("errorMsg", "支払える組み合わせが見つかりませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/payment.jsp").forward(request, response);
			return;
		}

		int change = bestPayAmount - amount;

		request.setAttribute("amount", amount);
		request.setAttribute("payAmount", bestPayAmount);
		request.setAttribute("change", change);
		request.setAttribute("moneyTypes", moneyTypes);
		request.setAttribute("payCounts", bestPayCounts);

		request.getRequestDispatcher("/WEB-INF/jsp/payment_confirm.jsp.jsp").forward(request, response);
		return;
	}

}
