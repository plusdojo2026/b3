package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ColumnDao;
import dao.WalletDao;
import dto.Column;
import dto.User;
import dto.Wallet;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ホーム画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		int id = 0;

		if (loginUser == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		} else {
			id = loginUser.getId();
		}

		// ランダムコラムを取得して JSP に渡す
		ColumnDao dao = new ColumnDao();
		Column randomColumn = dao.findRandom();
		request.setAttribute("randomColumn", randomColumn);

		// 合計金額を算出する。

		WalletDao walletDao = new WalletDao(); // Walletデータを操作する
		Wallet wallet = walletDao.selectById(id);
		int totalAmount = wallet.getTenThousandYen() * 10000 + wallet.getFiveThousandYen() * 5000
				+ wallet.getOneThousandYen() * 1000 + wallet.getFiveHundredYen() * 500 + wallet.getOneHundredYen() * 100
				+ wallet.getFiftyYen() * 50 + wallet.getTenYen() * 10 + wallet.getFiveYen() * 5 + wallet.getOneYen();

		request.setAttribute("wallet", wallet);
		request.setAttribute("totalAmount", totalAmount);

		request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
	}
}