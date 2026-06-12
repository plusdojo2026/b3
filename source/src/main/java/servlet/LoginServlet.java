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

		if (loginId.isEmpty() || password.isEmpty()) {
			request.setAttribute("errorMsg", "ユーザーIDまたはパスワードを入力してください。");
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
			request.setAttribute("errorMsg", "ユーザーIDまたはパスワードが違います。");
			request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
		}
	}
}