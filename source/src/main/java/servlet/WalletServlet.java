package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WalletDao;
import dto.User;
import dto.Wallet;

/**
 * Servlet implementation class WalletServlet
 */

@WebServlet("/WalletServlet")
public class WalletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public WalletServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:").append(request.getContextPath());

		WalletDao walletDao = new WalletDao(); // Walletデータを操作する

		// ユーザーごとのidを取得
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		int id = 0;
		if (loginUser != null) {
			id = loginUser.getId();
		} else {
			// ログイン画面に送還する処理
			response.sendRedirect("LoginServlet");
			return;
		}
		try {
			Wallet wallet = walletDao.selectById(id); // 今は仮でid=1 (WalletId)に変更する


			// 合計金額の計算
			int totalAmount = wallet.getTenThousandYen() * 10000 + wallet.getFiveThousandYen() * 5000
					+ wallet.getOneThousandYen() * 1000 + wallet.getFiveHundredYen() * 500
					+ wallet.getOneHundredYen() * 100 + wallet.getFiftyYen() * 50 + wallet.getTenYen() * 10
					+ wallet.getFiveYen() * 5 + wallet.getOneYen();

			request.setAttribute("wallet", wallet);
			request.setAttribute("totalAmount", totalAmount);

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 予算登録ページにフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/wallet.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		int id = user.getWalletId();

		// リクエストパラメータを取得する。

		int tenThousandYen = Integer.parseInt(request.getParameter("tenThousandYen"));
		int fiveThousandYen = Integer.parseInt(request.getParameter("fiveThousandYen"));
		int oneThousandYen = Integer.parseInt(request.getParameter("oneThousandYen"));
		int fiveHundredYen = Integer.parseInt(request.getParameter("fiveHundredYen"));
		int oneHundredYen = Integer.parseInt(request.getParameter("oneHundredYen"));
		int fiftyYen = Integer.parseInt(request.getParameter("fiftyYen"));
		int tenYen = Integer.parseInt(request.getParameter("tenYen"));
		int fiveYen = Integer.parseInt(request.getParameter("fiveYen"));
		int oneYen = Integer.parseInt(request.getParameter("oneYen"));

		// 合計金額を計算する
		int totalAmount = tenThousandYen * 10000 + fiveThousandYen * 5000 + oneThousandYen * 1000 + fiveHundredYen * 500
				+ oneHundredYen * 100 + fiftyYen * 50 + tenYen * 10 + fiveYen * 5 + oneYen;

		// 入力した枚数を更新する。
		WalletDao wDao = new WalletDao();
		String submit = request.getParameter("submit"); // jspの登録ボタンからの値を受け取る
		// 更新ボタンが押された時の処理
		if ("更新".equals(submit)) {
			if (wDao.update(new Wallet(id, tenThousandYen, fiveThousandYen, oneThousandYen, fiveHundredYen,
					oneHundredYen, fiftyYen, tenYen, fiveYen, oneYen))) {
				response.sendRedirect("WalletServlet"); // WalletServletにリダイレクトする
				return;
			} else {
				response.sendRedirect("WalletServlet");
				return;
			}
		}

		// 合計金額の値をjspに渡す
		request.setAttribute("totalAmount", totalAmount);
		request.getRequestDispatcher("/WEB-INF/jsp/wallet.jsp").forward(request, response);
		

	}

}
