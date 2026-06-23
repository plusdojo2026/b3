package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PaymentDao;
import dto.User;

@WebServlet("/PaymentLogServlet")
public class PaymentLogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ログ画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		// 言語
		String lang = (String) request.getSession().getAttribute("currentLang");

		Locale locale = "en".equals(lang) ? Locale.ENGLISH : Locale.JAPANESE;

		ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);

		if (loginUser == null) {
			response.sendRedirect(request.getContextPath() + "/LoginServlet");
			return;
		}

		try {
			PaymentDao paymentDao = new PaymentDao();
			List<Map<String, Object>> paymentLogList = paymentDao.findLogByUserId(loginUser.getId());

			request.setAttribute("paymentLogList", paymentLogList);
			request.getRequestDispatcher("/WEB-INF/jsp/payment_log.jsp").forward(request, response);
			return;

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMsg", bundle.getString("payment.log.error.fetch"));
			request.getRequestDispatcher("/WEB-INF/jsp/payment_log.jsp").forward(request, response);
			return;
		}
	}
}