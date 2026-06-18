package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ColumnDao;
import dto.Column;
import dto.User;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// ホーム画面を表示する
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
            return;
        }
		
		 // ランダムコラムを取得して JSP に渡す
        ColumnDao dao = new ColumnDao();
        Column randomColumn = dao.findRandom();
        request.setAttribute("randomColumn", randomColumn);

		request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
	}
}