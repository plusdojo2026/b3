package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Column;

public class ColumnDao {

	// 全件取得
	public List<Column> findAll() {
		Connection conn = null;
		List<Column> list = new ArrayList<>();
		
		// JDBCドライバを読み込む
		try {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}

			// データベースに接続する
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
					"root", "password");
			
			// SELECT文を準備する
			String sql = "SELECT * FROM columns ORDER BY id DESC";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			
			// SELECT文を実行し、結果を取得
			ResultSet rs = pStmt.executeQuery();
			
			// 結果を1行ずつ取り出す
			while (rs.next()) {
				Column col = new Column();
			
			// DBの値をColumnに入れる
			col.setId(rs.getInt("id")); 
			col.setTitle_ja(rs.getString("title_ja"));
			col.setTitle_en(rs.getString("title_en"));
			col.setColumn_ja(rs.getString("column_ja"));
			col.setColumn_en(rs.getString("column_en"));
			col.setCategory(rs.getString("category"));
			
			// listに追加
			list.add(col);
			}
			} catch (SQLException e) {
				e.printStackTrace();
				list = null;
				
			} finally {
				// データベース切断
				if (conn != null) {
					try {
						conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}		
		}	
			
		return list;
	}
	
}
