package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at:").append(request.getContextPath());←なにこれ

		// 予算登録ページにフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/wallet.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);←なにこれ
		// リクエストパラメータを取得する。
		String tenThousandYen = request.getParameter("tenThousandYen");
		String fiveThousandYen = request.getParameter("fiveThousandYen");
		String oneThousandYen = request.getParameter("oneThousandYen");
		String fiveHundredYen = request.getParameter("fiveHundredYen");
		String oneHundredYen = request.getParameter("oneHundredYen");
		String fiftyYen = request.getParameter("fiftyYen");
		String tenYen = request.getParameter("tenYen");
		String fiveYen = request.getParameter("fiveYen");
		String oneYen = request.getParameter("oneYen");

		// 合計金額を計算する
		int totalAmount = Integer.parseInt(tenThousandYen) * 10000 + Integer.parseInt(fiveThousandYen) * 5000
				+ Integer.parseInt(oneThousandYen) * 1000 + Integer.parseInt(fiveHundredYen) * 500
				+ Integer.parseInt(oneHundredYen) * 100 + Integer.parseInt(fiftyYen) * 50
				+ Integer.parseInt(tenYen) * 10 + Integer.parseInt(fiveYen) * 5 + Integer.parseInt(oneYen) * 1;

		// 合計金額の値をjspに渡す
		request.setAttribute("totalAmount", totalAmount);
		request.getRequestDispatcher("/WEB-INF/jsp/wallet.jsp").forward(request, response);

	}

}
