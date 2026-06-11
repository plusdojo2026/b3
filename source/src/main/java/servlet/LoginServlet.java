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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 入力された値を取得
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");

		// null対策 + 前後の空白削除
		loginId = loginId == null ? "" : loginId.trim();
		password = password == null ? "" : password.trim();

		if (loginId.isEmpty() || password.isEmpty()) {
			response.sendRedirect("login.jsp?error=1");
			return;
		}

		UserDao dao = new UserDao();
		User user = dao.findByLoginIdAndPassword(loginId, password);

		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);

			response.sendRedirect("home.jsp");

		} else {
			response.sendRedirect("login.jsp?error=1");
		}
	}
}