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

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 新規登録画面を表示
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
	}

	// 新規登録フォームが送信されたときの処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 入力値を取得
		String loginId = request.getParameter("loginId");
		String nickname = request.getParameter("nickname");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");

		// null対策
		loginId = loginId == null ? "" : loginId.trim();
		nickname = nickname == null ? "" : nickname.trim();
		password = password == null ? "" : password.trim();
		passwordConfirm = passwordConfirm == null ? "" : passwordConfirm.trim();
		
		// 1. セッションから現在の言語を取得する
		String currentLang = (String) request.getSession().getAttribute("currentLang");

		// 2. 言語に応じたLocaleを設定する
		java.util.Locale locale = "en".equals(currentLang) ? java.util.Locale.ENGLISH : java.util.Locale.JAPANESE;

		// 3. プロパティファイル（messages.properties）を読み込む
		java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("messages", locale);

		// 未入力チェック
		if (loginId.isEmpty() || nickname.isEmpty() || password.isEmpty() || passwordConfirm.isEmpty()) {
			request.setAttribute("errorMsg", bundle.getString("error.required"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// パスワード確認
		if (!password.equals(passwordConfirm)) {
			request.setAttribute("errorMsg", bundle.getString("error.pwMismatch"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}
		// ユーザーID形式チェック
		if (!loginId.matches("^[A-Za-z0-9]{8,20}$")) {
			request.setAttribute("errorMsg", bundle.getString("error.loginIdFormat"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// ニックネーム長さチェック
		if (nickname.length() > 30) {
			request.setAttribute("errorMsg", bundle.getString("error.nicknameLength"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// パスワード形式チェック
		if (!password.matches("^(?=.*[A-Za-z])(?=.*[0-9])[!-~]{8,20}$")) {
			request.setAttribute("errorMsg", bundle.getString("error.passwordFormat"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// ログインID重複チェック
		UserDao dao = new UserDao();

		if (dao.existsByLoginId(loginId)) {
			request.setAttribute("errorMsg", bundle.getString("error.loginIdExists"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}
		User user = new User(0, 0, loginId, password, nickname, "green", false, "ja", 10000, 20);

		boolean result = dao.insertWithWallet(user);

		if (result) {
			User loginUser = dao.findByLoginIdAndPassword(loginId, password);

			if (loginUser == null) {
				response.sendRedirect(request.getContextPath() + "/LoginServlet");
				return;
			}

			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("showTutorial", true);

			response.sendRedirect(request.getContextPath() + "/HomeServlet");
			return;
		} else {
			request.setAttribute("errorMsg", bundle.getString("error.signupFailed"));
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
		}
	}

}