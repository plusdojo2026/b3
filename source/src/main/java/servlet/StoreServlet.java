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

import com.google.gson.Gson;

import dao.StoreDao;
import dto.Store;

/**
 * Servlet implementation class StoreServlet
 */
@WebServlet("/StoreServlet")
public class StoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 検索
		String[] keyword = request.getParameterValues("keyword");
		// カテゴリーフィルタ
		String[] categories = request.getParameterValues("category");

		String name_ja = request.getParameter("name_ja");
		String name_en = request.getParameter("name_en");
		String address_ja = request.getParameter("address_ja");
		String address_en = request.getParameter("address_en");
		String cashlessType = request.getParameter("cashlessType");

		/*
		// デフォルト表示を現金のみonにする
		if (categories == null || categories.length == 0) {
			categories = new String[] { "cashOnly" };
		}
		*/
		/*
		 * // フロントが無いので仮の座標を直接入れる（東京駅） double userLat = 35.681236; double userLng =
		 * 139.767125;
		 */
		// 現在位置(初期値０)

		double userLat = 0;
		double userLng = 0;

		// それぞれの値がおかしいとき
		try {
			String latParam = request.getParameter("lat");
			String lngParam = request.getParameter("lng");

			if (latParam == null || lngParam == null) {
				userLat = 35.681236;
				userLng = 139.767125;
			} else {
				userLat = Double.parseDouble(latParam);
				userLng = Double.parseDouble(lngParam);
			}
		} catch (NumberFormatException e) {
			throw new ServletException("lat/lng が不正です");
		}

		StoreDao dao = new StoreDao();
		List<Store> storeList = dao.getStoresByCategories(name_ja, name_en, address_ja, address_en, cashlessType,
				categories, keyword);

		// 距離を計算。DTOへ
		for (Store s : storeList) {
			double dist = calcDistance(userLat, userLng, s.getLatitude(), s.getLongitude());
			s.setDistance(dist);
		}

		// 距離の昇順にソート
		storeList.sort(Comparator.comparingDouble(Store::getDistance));

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// Gsonを使ってJSONに変換
		Gson gson = new Gson();
		String jsonOutput = gson.toJson(storeList);

		// 送信
		PrintWriter out = response.getWriter();
		out.print(jsonOutput);
		out.flush();

//	        response.setContentType("application/json; charset=UTF-8");
//	        PrintWriter out = response.getWriter();
//	        out.print(toJson(storeList));
//	        out.flush();
	}

	// 距離計算の中身 ハヴァサイン公式

	private double calcDistance(double lat1, double lng1, double lat2, double lng2) {
		// 地球の赤道半径 (km)
		double EARTH_RADIUS = 6371.0;

		// dLat:2点間の緯度の差 dLng：2点間の経度の差 ラジアンに変換
		double dLat = Math.toRadians(lat2 - lat1);
		double dLng = Math.toRadians(lng2 - lng1);

		// 緯度をラジアンに変換(cos計算で使う)
		double lat1R = Math.toRadians(lat1);
		double lat2R = Math.toRadians(lat2);

		// 緯度差・経度差の半分のサイン
		double sinHalfLat = Math.sin(dLat / 2);
		double sinHalfLng = Math.sin(dLng / 2);

		// a( 2点間の角距離(角度で表した距離)の中間値)の計算
		double a = sinHalfLat * sinHalfLat + Math.cos(lat1R) * Math.cos(lat2R) * sinHalfLng * sinHalfLng;

		// ⅽ(中心から見た 2点間の中心角(ラジアン))
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

		// 2点間の地表距離を返す
		return EARTH_RADIUS * c;

	}

	// DTO→JSON変換
	/*
	 * private String toJson(List<Store> list) { StringBuilder sb = new
	 * StringBuilder(); sb.append("[");
	 * 
	 * for (int i = 0; i < list.size(); i++) { Store s = list.get(i); sb.append("{")
	 * .append("\"id\":").append(s.getId()).append(",")
	 * .append("\"name_ja\":\"").append(s.getName_ja()).append("\",")
	 * .append("\"name_en\":\"").append(s.getName_en()).append("\",")
	 * .append("\"address_ja\":\"").append(s.getAddress_ja()).append("\",")
	 * .append("\"address_en\":\"").append(s.getAddress_en()).append("\",")
	 * .append("\"latitude\":").append(s.getLatitude()).append(",")
	 * .append("\"longitude\":").append(s.getLongitude()).append(",")
	 * .append("\"category\":\"").append(s.getCategory()).append("\",")
	 * .append("\"cashless_type\":\"").append(s.getCashless_type()).append("\"")
	 * .append("}");
	 * 
	 * if (i < list.size() - 1) sb.append(","); }
	 * 
	 * sb.append("]"); System.out.println(sb.toString()); return sb.toString(); }
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		// request.getRequestDispatcher("/WEB-INF/jsp/store_info.jsp").forward(request,
		// response);

	}

}
