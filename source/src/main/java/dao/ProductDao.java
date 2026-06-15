package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDao {
	Connection conn = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    
    //1. お財布の中の小銭の合計金額をDBから計算して持ってくるメソッド
    public int totalCoins(int id) {
       int total = 0;
    
	try {
		// JDBCドライバを読み込む
		Class.forName("com.mysql.cj.jdbc.Driver");

		// データベースに接続する
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/b3?"
				+ "characterEncoding=utf8&useSSL=false&serverTimezone=GMT%2B9&rewriteBatchedStatements=true",
				"root", "password");

		// SQL文を準備する
		String sql = "SELECT (five_hundred_yen*500+ one_hundred_yen*100+ fifty_yen*50+ ten_yen*10+ five_yen*5+ one_yen*1) "
				+ "AS total FROM wallets where id=?";
		
		//SQL文をセットして実行する準備
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		
		// SQLを実行して、結果を矢印（rs）で受け取る
		rs = pstmt.executeQuery();

        // 結果を取り出す
        if (rs.next()) {
            total = rs.getInt("total"); // 
        }
	} catch (SQLException e) {
		e.printStackTrace();
		
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
		
	} finally {
		try {
		// データベースを切断
		if(rs != null) {
			rs.close();
		}if(pstmt != null){
			pstmt.close();
		}if (conn != null) {
			conn.close();
		}}catch (SQLException e) {
			e.printStackTrace();
		}
		}return total;
	}
}
	//2. 任意の金額または、小銭合計をぴったり使い切る組み合わせを表示するメソッド
	