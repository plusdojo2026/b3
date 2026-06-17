package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Store;

public class StoreDao {
	
	public List<Store> getStoresByCategories(String nameJa,String nameEn,String addressJa,String addressEn,String cashlessType,String[] categories, String[] keywords) {
		
		Connection conn = null;
		List<Store> cardList = new ArrayList<Store>();
		
		try {
			// JDBCドライバを読み込む
			Class.forName("com.mysql.cj.jdbc.Driver");

			// データベースに接続する
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/b3?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

			// SQL文を準備する
			String sql = "SELECT id,name_ja,name_en,address_ja,address_en,latitude,longitude,category,cashless_type "
			        + "FROM stores "
			        + "WHERE "
			        + "name_ja LIKE ? AND "
			        + "name_en LIKE ? AND "
			        + "address_ja LIKE ? AND "
			        + "address_en LIKE ? AND "
			        + "cashless_type LIKE ? ";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			
			// name_ja
			if (nameJa != null && !nameJa.isEmpty()) {
			    pStmt.setString(1, "%" + nameJa + "%");
			} else {
			    pStmt.setString(1, "%");
			}

			// name_en
			if (nameEn != null && !nameEn.isEmpty()) {
			    pStmt.setString(2, "%" + nameEn + "%");
			} else {
			    pStmt.setString(2, "%");
			}

			// address_ja
			if (addressJa != null && !addressJa.isEmpty()) {
			    pStmt.setString(3, "%" + addressJa + "%");
			} else {
			    pStmt.setString(3, "%");
			}

			// address_en
			if (addressEn != null && !addressEn.isEmpty()) {
			    pStmt.setString(4, "%" + addressEn + "%");
			} else {
			    pStmt.setString(4, "%");
			}

			// cashless_type
			if (cashlessType != null && !cashlessType.isEmpty()) {
			    pStmt.setString(5, "%" + cashlessType + "%");
			} else {
			    pStmt.setString(5, "%");
			}
		
			
			// SQL文を実行し、結果表を取得する
			System.out.println("SQL実行前");
			ResultSet rs = pStmt.executeQuery();
			System.out.println("SQL実行後");
			
			
			int count = 0;
			while (rs.next()) {
			    System.out.println("while内: " + count);
			    count++;
			    
			
                Store s = new Store();
                s.setId(rs.getInt("id"));
                s.setName_ja(rs.getString("name_ja"));
                s.setName_en(rs.getString("name_en"));
                s.setAddress_ja(rs.getString("address_ja"));
                s.setAddress_en(rs.getString("address_en"));
                s.setLatitude(rs.getDouble("latitude"));
                s.setLongitude(rs.getDouble("longitude"));
                s.setCategory(rs.getString("category"));
                s.setCashless_type(rs.getString("cashless_type"));

                cardList.add(s);	        
			}
			System.out.println("取得件数: " + count);
		}catch (SQLException e) {
			System.out.println("SQLエラー: " + e.getMessage());
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} finally {
				// データベースを切断
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			
			}
		// 結果を返す
				return cardList;
	}
}

		