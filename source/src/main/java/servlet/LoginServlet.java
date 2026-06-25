package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import dto.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ログイン画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
		//デフォルトは日本語
		HttpSession session = request.getSession();
		String currentLang=(String) session.getAttribute("currentLang");
		
		if (currentLang == null || currentLang.isEmpty()) {
			
			session.setAttribute("currentLang", "ja");
			
			// JSTLのスイッチも、サーバーの設定を無視して日本語に固定する
			java.util.Locale locale = new java.util.Locale("ja");
			javax.servlet.jsp.jstl.core.Config.set(session, javax.servlet.jsp.jstl.core.Config.FMT_LOCALE, locale);
		}
				
		request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
	}

	// ログイン処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");

		loginId = loginId == null ? "" : loginId.trim();
		password = password == null ? "" : password.trim();

		// 1. セッションから現在の言語を取得する
		String currentLang = (String) request.getSession().getAttribute("currentLang");

		// 2. 言語に応じたLocaleを設定する
		java.util.Locale locale = "en".equals(currentLang) ? java.util.Locale.ENGLISH : java.util.Locale.JAPANESE;

		// 3. プロパティファイル（messages.properties）を読み込む
		java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("messages", locale);
		
		
		if (loginId.isEmpty() || password.isEmpty()) {
			request.setAttribute("errorMsg", bundle.getString("login.error.required"));
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
			return;
		}

		UserDao dao = new UserDao();
		User user = dao.findByLoginIdAndPassword(loginId, password);

		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);

			response.sendRedirect(request.getContextPath() + "/HomeServlet");

		} else {
			request.setAttribute("errorMsg", bundle.getString("login.error.mismatch"));
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
		}
	}
}