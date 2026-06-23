package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LangageServlet
 */
@WebServlet("/LangageServlet")
public class LangageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LangageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		// 1. 画面から送られてきた言語を取得
        String lang = request.getParameter("lang");
        
        // 2. どこの画面からボタンが押されたかを取得
        String fromPage = request.getParameter("from");

        // 3. セッションに言語を保存
        if (lang != null && (lang.equals("ja") || lang.equals("en"))) {
            request.getSession().setAttribute("currentLang", lang);
        }

        // 4. 元いた画面にそのまま送り返す（空っぽならホーム画面へ）
        if (fromPage != null && !fromPage.isEmpty()) {
            response.sendRedirect(request.getContextPath() + fromPage);
        } else {
            response.sendRedirect(request.getContextPath() + "/LoginServlet");
        }
    }
}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
