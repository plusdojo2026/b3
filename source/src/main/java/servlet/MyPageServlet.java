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

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MyPageServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
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

		// セッションにcurrentLangが一回も入っていなければ、デフォルトとしてjaを入れる
		if (session.getAttribute("currentLang") == null) {
			session.setAttribute("currentLang", "ja");
		}

		request.setAttribute("user", loginUser);
		// マイページにフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// doGet(request, response);

		HttpSession session = request.getSession();

		// セッションから現在のログインユーザー情報を取得する
		User loginUser = (User) session.getAttribute("loginUser");

		String action = request.getParameter("action");

		if ("alert".equals(action)) {
			String alertAmountStr = request.getParameter("alertAmount");
			String alertCountStr = request.getParameter("alertCount");

			if (alertAmountStr == null || alertAmountStr.length() == 0 || alertCountStr == null
					|| alertCountStr.length() == 0) {
				request.setAttribute("errorMsg", "アラート設定を入力してください。");
				request.setAttribute("user", loginUser);
				request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
				return;
			}

			if (!alertAmountStr.matches("^[0-9]+$") || !alertCountStr.matches("^[0-9]+$")) {
				request.setAttribute("errorMsg", "アラート設定は半角数字で入力してください。");
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

				response.sendRedirect("MyPageServlet");
				return;
			}

			request.setAttribute("errorMsg", "アラート設定の更新に失敗しました。");
			request.setAttribute("user", loginUser);
			request.getRequestDispatcher("/WEB-INF/jsp/mypage.jsp").forward(request, response);
			return;

		}

		// リクエストパラメータを取得
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");
		String displaymode = request.getParameter("displaymode");
		String night = request.getParameter("night");
		String language = request.getParameter("language");

		// ==========================================
		// プロパティファイル用のセッション保存を追加
		// ==========================================
		java.util.Locale locale;
		if ("en".equals(language)) {
			locale = new java.util.Locale("en"); // 英語
		} else {
			locale = new java.util.Locale("ja"); // 日本語
		}

		// JSTLのタグ（fmt:message）が自動でこの言語を認識できるようにセッションに保存
		javax.servlet.jsp.jstl.core.Config.set(request.getSession(), javax.servlet.jsp.jstl.core.Config.FMT_LOCALE,
				locale);

		// 後でJavaScript（coin_support.jsなど）で「今どっちの言語？」と判定するために文字でも保存しておくと
		request.getSession().setAttribute("currentLang", "en".equals(language) ? "en" : "ja");

		// JSPの ${user} にデータを引き継ぐためにリクエストにセットする
		request.setAttribute("user", loginUser);

		// リダイレクト
		response.sendRedirect("MyPageServlet");
	}

}
