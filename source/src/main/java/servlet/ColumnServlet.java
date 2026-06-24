package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ColumnDao;
import dto.Column;
import dto.User;

/**
 * Servlet implementation class ColumnServlet
 */
@WebServlet("/ColumnServlet")
public class ColumnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ColumnServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
	
		// 言語設定
		String lang = request.getParameter("lang");
		if (lang == null) {
			lang = "ja";
		}
		request.setAttribute("lang", lang);
		
		// DB取得
		ColumnDao dao = new ColumnDao();
		List<Column> list = dao.findAll();
		
		// JSPに渡す
		request.setAttribute("list", list);
		
		// JSPへフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/column.jsp");
		dispatcher.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}
