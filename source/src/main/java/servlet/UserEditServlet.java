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


@WebServlet("/UserEditServlet")
public class UserEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 編集画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

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

		request.setAttribute("user", loginUser);
		// マイページにフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
	}

	// ユーザー情報編集処理
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		String nickname = request.getParameter("nickname");
		String loginId = request.getParameter("loginId");
		String isPassword = request.getParameter("isPassword");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");

		nickname = nickname == null ? "" : nickname.trim();
		loginId = loginId == null ? "" : loginId.trim();
		isPassword = isPassword == null ? "" : isPassword.trim();
		password = password == null ? "" : password.trim();
		passwordConfirm = passwordConfirm == null ? "" : passwordConfirm.trim();

		// 基本項目だけ必須
		if (nickname.isEmpty() || loginId.isEmpty() || isPassword.isEmpty()) {
			request.setAttribute("errorMsgKey", "error.profile_edit.required");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		// 現在のパスワード確認
		if (!isPassword.equals(loginUser.getPassword())) {
			request.setAttribute("errorMsgKey", "error.profile_edit.password.current_incorrect");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		// ユーザーID形式チェック
		if (!loginId.matches("^[A-Za-z0-9]{8,20}$")) {
			request.setAttribute("errorMsgKey", "error.profile_edit.login_id.invalid_format");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		// ニックネーム長さチェック
		if (nickname.length() > 30) {
			request.setAttribute("errorMsgKey", "error.profile_edit.nickname.too_long");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		UserDao dao = new UserDao();

		// ログインID重複チェック
		// 自分の現在のIDと同じならOK
		if (!loginId.equals(loginUser.getLoginId()) && dao.existsByLoginId(loginId)) {
			request.setAttribute("errorMsgKey", "error.profile_edit.login_id.duplicate");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		boolean changePassword = false;
		String updatePassword = loginUser.getPassword();

		// 新しいパスワードが入力されている場合だけ、パスワード変更扱い
		if (!password.isEmpty() || !passwordConfirm.isEmpty()) {
			changePassword = true;

			if (password.isEmpty() || passwordConfirm.isEmpty()) {
				request.setAttribute("errorMsgKey", "error.profile_edit.password.new_required");
				request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
				return;
			}

			if (!password.equals(passwordConfirm)) {
				request.setAttribute("errorMsgKey", "error.profile_edit.password.mismatch");
				request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
				return;
			}

			// パスワード形式チェック
			if (!password.matches("^(?=.*[A-Za-z])(?=.*[0-9])[!-~]{8,20}$")) {
				request.setAttribute("errorMsgKey", "error.profile_edit.password.invalid_format");
				request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
				return;
			}

			updatePassword = password;
		}

		boolean result = dao.updateUser(loginUser.getId(), nickname, loginId, updatePassword);

		if (result) {
			loginUser.setNickname(nickname);
			loginUser.setLoginId(loginId);
			loginUser.setPassword(updatePassword);

			session.setAttribute("loginUser", loginUser);

			if (changePassword) {
				request.setAttribute("successMsgKey", "success.profile_edit.update_with_password");
			} else {
				request.setAttribute("successMsgKey", "success.profile_edit.update");
			}

		} else {
			request.setAttribute("errorMsgKey", "error.profile_edit.update_failed");
		}

		request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
	}

}