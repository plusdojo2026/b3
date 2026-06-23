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

		Boolean showTutorial = (Boolean) session.getAttribute("showTutorial");
		String tutorialParam = request.getParameter("tutorial");

		if ("1".equals(tutorialParam)) {
			request.setAttribute("showTutorial", true);
		} else if (showTutorial != null && showTutorial) {
			request.setAttribute("showTutorial", true);
			session.removeAttribute("showTutorial");
		}

		// ランダムコラムを取得して JSP に渡す
		String lang = request.getParameter("lang");

		if (lang != null) {
		    session.setAttribute("currentLang", lang); 
		} else {
		    lang = (String) session.getAttribute("currentLang");
		    if (lang == null) {
		        lang = "ja";
		        session.setAttribute("currentLang", lang);
		    }
		}

		// DBからランダムコラムを取得
		ColumnDao dao = new ColumnDao();
		Column randomColumn = dao.findRandom();

		// セッションの言語に合わせてタイトルを選ぶ
		String columnTitle = "";
		if (randomColumn != null) {
		    if ("en".equals(lang)) {
		        columnTitle = randomColumn.getTitle_en(); // 英語
		    } else {
		        columnTitle = randomColumn.getTitle_ja(); // 日本語
		    }
		}

		// JSPへ渡す
		request.setAttribute("columnTitle", columnTitle);;

		// 合計金額を算出する。

		WalletDao walletDao = new WalletDao(); // Walletデータを操作する
		Wallet wallet = walletDao.selectById(id);
		int totalAmount = wallet.getTenThousandYen() * 10000 + wallet.getFiveThousandYen() * 5000
				+ wallet.getOneThousandYen() * 1000 + wallet.getFiveHundredYen() * 500 + wallet.getOneHundredYen() * 100
				+ wallet.getFiftyYen() * 50 + wallet.getTenYen() * 10 + wallet.getFiveYen() * 5 + wallet.getOneYen();

		request.setAttribute("wallet", wallet);
		request.setAttribute("totalAmount", totalAmount);

		// 合計枚数を算出する。
		int totalCount = wallet.getFiveHundredYen() + wallet.getOneHundredYen() + wallet.getFiftyYen()
				+ wallet.getTenYen() + wallet.getFiveYen() + wallet.getOneYen();

		request.setAttribute("totalCount", totalCount);

		request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
	}
}