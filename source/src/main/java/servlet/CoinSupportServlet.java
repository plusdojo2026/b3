package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProductDao;
import dto.User;

/**
 * Servlet implementation class CoinSupportServlet
 */
@WebServlet("/CoinSupportServlet")
public class CoinSupportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CoinSupportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
	ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//ユーザーごとのidを取得
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
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
//	JSPから送られてきたデータ（金額、ソート、カテゴリー）を受け取る
	String amountInput = request.getParameter("amountInput");
	String sortOrder = request.getParameter("sortOrder");
	String[] categories = request.getParameterValues("category");
	String submitType = request.getParameter("submitType");
	
//	ボタンが押されたかをチェックする目印(押されていないときは、商品リストを表示しないようにするため）
	boolean searchSign = false;
	
//	ボタンの種類によって、検索に使う金額（targetPrice）を決める
	int targetPrice = 0;
	
//	財布の小銭合計額
	ProductDao productDao = new ProductDao();
	int totalCoins = productDao.totalCoins(id);
    
//  ボタンが押されたときの条件分岐
    if ("manual".equals(submitType)) {
        // 「金額を入力して探す」の検索ボタンが押されたとき
        // JS側で空っぽチェックをするので、ここは数字に変換するだけ
        targetPrice = Integer.parseInt(amountInput);
        searchSign= true;

    } else if ("wallet".equals(submitType)) {
        // 「この小銭を使い切る」ボタンが押されたとき
        targetPrice = totalCoins;
        searchSign= true;
    }
    
//	DAOを呼び出す
    if (searchSign) {
    	if (searchSign) {
    		// DAOのメソッドを1回だけ呼び出して、金額以下の全商品を仕入れる
//    		java.util.List<Product> recItemsList = productDao.getRecommendProducts(targetPrice);
    		
    		// 【超重要】仕入れたリストを、Gsonを使って一瞬でJSON（文字）に変換する
//    		String recItemsJson = new com.google.gson.Gson().toJson(recItemsList);
    		
    		// JSP（JavaScript）にお土産としてJSONを渡す
//    		request.setAttribute("recItemsJson", recItemsJson);
    } else {
        // まだ何もボタンを押していない（初期表示）ときは、空っぽのリストをJSPに送る
        request.setAttribute("matchComboList", new java.util.ArrayList<>());
        request.setAttribute("recItemsList", new java.util.ArrayList<>());
    }

    
//	DBからデータを取ってくる
	request.setAttribute("totalCoins", totalCoins);
//	request.setAttribute("matchComboList", matchComboList);
//    request.setAttribute("recItemsList", recItemsList);
	
//	JSPを表示する
	request.getRequestDispatcher("/WEB-INF/jsp/coin_support.jsp").forward(request, response);
	}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
