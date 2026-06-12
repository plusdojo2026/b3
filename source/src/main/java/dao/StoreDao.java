package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import servlet.StoreDTO;

public class StoreDao {

	public List<StoreDTO>getStoresByCategoriesAndKeyword(String[] categories, String keyword){
		Connection conn = null;
		List<StoreDTO> list = new ArrayList<>();

				 
		//カテゴリーが複数選ばれても動くように
			for(int i = 0; i < categories.length; i++) {
				sql.append("?");
				if(if < categories.length - 1)sql.append(",");
			}
		
		//検索キーワードを空白で分ける
		List<String> words = new ArrayList<>();
		if(keyword != null && !keyword.isEmpty()) {
			for(String w : keyword.split("[\\\\s　")) {
				if(!w.isEmpty()) words.add(w);
			}
		}
		
		for (int i = 0; i < words.size(); i++) {
		    sql.append(" AND (");
		    sql.append("name_ja LIKE ? OR name_en LIKE ? OR ");
		    sql.append("address_ja LIKE ? OR address_en LIKE ?");
		    sql.append(")");
		}

	}
}
