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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
//入力値を取得
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("password_confirm");
		String nickname = request.getParameter("nickname");

		if (loginId == null || loginId.isEmpty() || password == null || password.isEmpty() || passwordConfirm == null
				|| passwordConfirm.isEmpty() || nickname == null || nickname.isEmpty()) {
			response.sendRedirect("signup.jsp");
			return;
		}

		if (!password.equals(passwordConfirm)) {
			response.sendRedirect("signup.jsp");
			return;
		}

		User user = new User(0, 0, loginId, password, nickname, "green", false, "ja");

		UserDao dao = new UserDao();
		boolean result = dao.insertWithWallet(user);

		if (result) {
//			ここに、チュートリアル機能をのちに記述
			response.sendRedirect("home.jsp");
		} else {
			response.sendRedirect("signup.jsp");
		}
	}
}