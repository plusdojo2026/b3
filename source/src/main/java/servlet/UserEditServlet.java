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
			request.setAttribute("errorMsg", "未入力の項目があります。");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		// 現在のパスワード確認
		if (!isPassword.equals(loginUser.getPassword())) {
			request.setAttribute("errorMsg", "現在のパスワードが正しくありません。");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		// ユーザーID形式チェック
		if (!loginId.matches("^[A-Za-z0-9]{8,20}$")) {
			request.setAttribute("errorMsg", "ユーザーIDは8〜20文字の半角英数字で入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		// ニックネーム長さチェック
		if (nickname.length() > 30) {
			request.setAttribute("errorMsg", "ニックネームは30文字以内で入力してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		UserDao dao = new UserDao();

		// ログインID重複チェック
		// 自分の現在のIDと同じならOK
		if (!loginId.equals(loginUser.getLoginId()) && dao.existsByLoginId(loginId)) {
			request.setAttribute("errorMsg", "このユーザーIDは既に使われています。");
			request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
			return;
		}

		boolean changePassword = false;
		String updatePassword = loginUser.getPassword();

		// 新しいパスワードが入力されている場合だけ、パスワード変更扱い
		if (!password.isEmpty() || !passwordConfirm.isEmpty()) {
			changePassword = true;

			if (password.isEmpty() || passwordConfirm.isEmpty()) {
				request.setAttribute("errorMsg", "新しいパスワードと確認用パスワードを両方入力してください。");
				request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
				return;
			}

			if (!password.equals(passwordConfirm)) {
				request.setAttribute("errorMsg", "パスワードが一致しません。");
				request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
				return;
			}

			// パスワード形式チェック
			if (!password.matches("^(?=.*[A-Za-z])(?=.*[0-9])[!-~]{8,20}$")) {
				request.setAttribute("errorMsg", "パスワードは8〜20文字で、半角英字と数字を両方含めてください。");
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
				request.setAttribute("successMsg", "プロフィールとパスワードを更新しました。");
			} else {
				request.setAttribute("successMsg", "プロフィールを更新しました。");
			}

		} else {
			request.setAttribute("errorMsg", "プロフィールの更新に失敗しました。");
		}

		request.getRequestDispatcher("/WEB-INF/jsp/profile_edit.jsp").forward(request, response);
	}

}