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

/**
 * Servlet implementation class MyPageServlet
 */
@WebServlet("/MyPageServlet")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyPageServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ユーザーごとのidを取得
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			// ログイン画面に送還する処理
			response.sendRedirect("LoginServlet");
			return;
		}

		// セッションにcurrentLangが一回も入っていなければ、デフォルトとしてjaを入れる
		if (session.getAttribute("currentLang") == null) {
			session.setAttribute("currentLang", "ja");
		}

		request.setAttribute("user", loginUser);

		// アラート成功メッセージがあれば表示して、表示後に消す
		String alertSuccessMsg = (String) session.getAttribute("alertSuccessMsgKey");
		if (alertSuccessMsg != null) {
			request.setAttribute("alertSuccessMsgKey", alertSuccessMsg);
			session.removeAttribute("alertSuccessMsgKey");
		}

		// マイページにフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();

		// セッションから現在のログインユーザー情報を取得する
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.sendRedirect("LoginServlet");
			return;
		}

		String action = request.getParameter("action");

		if ("alert".equals(action)) {
			String alertAmountStr = request.getParameter("alertAmount");
			String alertCountStr = request.getParameter("alertCount");

			alertAmountStr = alertAmountStr == null ? "" : alertAmountStr.trim();
			alertCountStr = alertCountStr == null ? "" : alertCountStr.trim();

			if (alertAmountStr.isEmpty() || alertCountStr.isEmpty()) {
				request.setAttribute("alertErrorMsgKey", "error.alert.input.required");
				request.setAttribute("user", loginUser);
				request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
				return;
			}

			if (!alertAmountStr.matches("^[0-9]+$") || !alertCountStr.matches("^[0-9]+$")) {
				request.setAttribute("alertErrorMsgKey", "error.alert.input.invalid_number");
				request.setAttribute("user", loginUser);
				request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
				return;
			}

			int alertAmount = Integer.parseInt(alertAmountStr);
			int alertCount = Integer.parseInt(alertCountStr);

			UserDao userDao = new UserDao();
			boolean result = userDao.updateAlertSetting(loginUser.getId(), alertAmount, alertCount);

			if (result) {
				loginUser.setAlertAmount(alertAmount);
				loginUser.setAlertCount(alertCount);
				session.setAttribute("loginUser", loginUser);

				request.setAttribute("alertSuccessMsgKey", "success.alert.update");
				request.setAttribute("user", loginUser);
				request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
				return;
			}

			request.setAttribute("alertErrorMsgKey", "error.alert.update_failed");
			request.setAttribute("user", loginUser);
			request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
			return;
		}

		doGet(request, response);
	}
}