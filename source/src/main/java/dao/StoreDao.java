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
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/webapp2?"
					+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
					"root", "password");

			// SQL文を準備する
			String sql = "SELECT id,name_ja,name_en,address_ja,address_en,latitude,longitude,category,cashlessType "
			        + "FROM store WHERE "
			        + "BINARY name_ja LIKE BINARY ? AND "
			        + "BINARY name_en LIKE BINARY ? AND "
			        + "BINARY address_ja LIKE BINARY ? AND "
			        + "BINARY address_en LIKE BINARY ? AND "
			        + "BINARY cashlessType LIKE BINARY ? ";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			

			pStmt.setString(1, "%" + nameJa + "%");
			pStmt.setString(2, "%" + nameEn + "%");
			pStmt.setString(3, "%" + addressJa + "%");
			pStmt.setString(4, "%" + addressEn + "%");
			pStmt.setString(5, "%" + cashlessType + "%");
			
			// SQL文を実行し、結果表を取得する
			ResultSet rs = pStmt.executeQuery();
			
	        while (rs.next()) {
                Store s = new Store();
                s.setId(rs.getInt("id"));
                s.setNameJa(rs.getString("name_ja"));
                s.setNameEn(rs.getString("name_en"));
                s.setAddressJa(rs.getString("address_ja"));
                s.setAddressEn(rs.getString("address_en"));
                s.setLatitude(rs.getDouble("latitude"));
                s.setLongitude(rs.getDouble("longitude"));
                s.setCategory(rs.getString("category"));
                s.setCashlessType(rs.getString("cashlessType"));

                cardList.add(s);	        
			}
		}catch (SQLException e) {
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

		