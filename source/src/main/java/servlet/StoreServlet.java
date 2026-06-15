package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Comparator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StoreServlet
 */
@WebServlet("/StoreServlet")
public class StoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
			//検索
			String[] keyword = request.getParameterValues("keyword")
			//カテゴリーフィルタ
			String[] categories = request.getParameterValues("category");
	        
	        //デフォルト表示を現金のみonにする
	        if (categories == null || categories.length == 0) {
	            categories = new String[]{"Cashonly"};
	        }

	        //現在位置
	        double userLat = Double.parseDouble(request.getParameter("lat"));
	        double userLng = Double.parseDouble(request.getParameter("lng"));

	        StoreDao dao = new StoreDao();
	        List<Store> storeList = dao.getStoresByCategories(categories,keyword);

	        //距離を計算。DTOへ
	        for (Store s : storeList) {
	            double dist = calcDistance(userLat, userLng, s.getLatitude(), s.getLongitude());
	            s.setDistance(dist);
	        }

	        // 距離の昇順にソート
	        storeList.sort(Comparator.comparingDouble(StoreDTO::getDistance));

	        // JSONで返す
	        response.setContentType("application/json; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.print(toJson(storeList));
	        out.flush();
	    }

	    // 距離計算の中身 ハヴァサイン公式
	    private double calcDistance(double lat1, double lng1, double lat2, double lng2) {
	        double R = 6371; 
	        double dLat = Math.toRadians(lat2 - lat1);
	        double dLng = Math.toRadians(lng2 - lng1);
	        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
	                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
	                   Math.sin(dLng/2) * Math.sin(dLng/2);
	        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
	        return R * c; 
	    }
	 // DTO→JSON変換
		private String toJson(List<Store> list) {
	        StringBuilder sb = new StringBuilder();
	        sb.append("[");

	        for (int i = 0; i < list.size(); i++) {
	            StoreDTO s = list.get(i);
	            sb.append("{")
	              .append("\"id\":").append(s.getId()).append(",")
	              .append("\"name_ja\":\"").append(s.getNameJa()).append("\",")
	              .append("\"name_en\":\"").append(s.getNameEn()).append("\",")
	              .append("\"address_ja\":\"").append(s.getAddressJa()).append("\",")
	              .append("\"address_en\":\"").append(s.getAddressEn()).append("\",")
	              .append("\"latitude\":").append(s.getLatitude()).append(",")
	              .append("\"longitude\":").append(s.getLongitude()).append(",")
	              .append("\"category\":\"").append(s.getCategory()).append("\",")
	              .append("\"cashless_type\":\"").append(s.getCashlessType()).append("\"")
	              .append("}");

	            if (i < list.size() - 1) sb.append(",");
	        }

	        sb.append("]");
	        return sb.toString();
	    }
		
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
