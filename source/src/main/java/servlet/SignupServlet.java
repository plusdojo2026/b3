package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

		// 未入力チェック
		if (loginId.isEmpty() || nickname.isEmpty() || password.isEmpty() || passwordConfirm.isEmpty()) {
			request.setAttribute("errorMsg", "未入力の項目があります。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// パスワード確認
		if (!password.equals(passwordConfirm)) {
			request.setAttribute("errorMsg", "パスワードが一致しません。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}
		// ユーザーID形式チェック
		if (!loginId.matches("^[A-Za-z0-9]{8,20}$")) {
			request.setAttribute("errorMsg", "ユーザーIDは8〜20文字の半角英数字で入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// ニックネーム長さチェック
		if (nickname.length() > 30) {
			request.setAttribute("errorMsg", "ニックネームは30文字以内で入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// パスワード形式チェック
		if (!password.matches("^(?=.*[A-Za-z])(?=.*[0-9])[!-~]{8,20}$")) {
			request.setAttribute("errorMsg", "パスワードは8〜20文字で、半角英字と数字を両方含めてください。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}

		// ログインID重複チェック
		UserDao dao = new UserDao();

		if (dao.existsByLoginId(loginId)) {
			request.setAttribute("errorMsg", "このユーザーIDは既に使われています。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
			return;
		}
		User user = new User(0, 0, loginId, password, nickname, "green", false, "ja");

		boolean result = dao.insertWithWallet(user);

		if (result) {
			// ここに、チュートリアル機能をのちに記述
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
		} else {
			request.setAttribute("errorMsg", "登録に失敗しました。");
			request.getRequestDispatcher("/WEB-INF/jsp/signup.jsp").forward(request, response);
		}
	}
}