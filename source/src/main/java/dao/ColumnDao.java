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
			Class.forName("com.mysql.cj.jdbc.Driver");

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
			col.setTitle_ja(rs.getString("title_ja"));
				
			}
			
			
		}
	}
	
}
