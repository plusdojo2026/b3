package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.Payment;

public class PaymentDao {

	public int insert(Connection conn, Payment payment) throws Exception {
		int paymentId = 0;

		String sql = "INSERT INTO payments (user_id, amount) VALUES (?, ?)";
		PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

		pStmt.setInt(1, payment.getUserId());
		pStmt.setInt(2, payment.getAmount());

		pStmt.executeUpdate();

		ResultSet rs = pStmt.getGeneratedKeys();

		if (rs.next()) {
			paymentId = rs.getInt(1);
		}

		return paymentId;
	}

	public List<Payment> findByUserId(int userId) throws Exception {
		List<Payment> paymentList = new ArrayList<>();

		Class.forName("com.mysql.cj.jdbc.Driver");

		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
				"root", "password");
		
        // ネットワーク接続用
        //conn = DriverManager.getConnection(
        		//"jdbc:mysql://localhost:3306/b3?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Tokyo&connectTimeout=30000",
        		//"b3", "FYwYHFcfmMuGAnNZ");

		String sql = "SELECT id, user_id, amount FROM payments WHERE user_id = ? ORDER BY id DESC";
		PreparedStatement pStmt = conn.prepareStatement(sql);

		pStmt.setInt(1, userId);

		ResultSet rs = pStmt.executeQuery();

		while (rs.next()) {
			Payment payment = new Payment(rs.getInt("id"), rs.getInt("user_id"), rs.getInt("amount"));

			paymentList.add(payment);
		}

		rs.close();
		pStmt.close();
		conn.close();

		return paymentList;
	}

	public List<Map<String, Object>> findLogByUserId(int userId) throws Exception {
		List<Map<String, Object>> paymentLogList = new ArrayList<>();

		Class.forName("com.mysql.cj.jdbc.Driver");

		Connection conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
				"root", "password");

		String sql = "SELECT " + "p.id, " + "p.amount, "
				+ "COALESCE(SUM(b.type_money * b.count_money), 0) AS pay_amount, "
				+ "COALESCE(SUM(b.type_money * b.count_money), 0) - p.amount AS change_amount " + "FROM payments p "
				+ "LEFT JOIN breakdowns b ON p.id = b.payment_id " + "WHERE p.user_id = ? " + "GROUP BY p.id, p.amount "
				+ "ORDER BY p.id DESC";

		PreparedStatement pStmt = conn.prepareStatement(sql);
		pStmt.setInt(1, userId);
		ResultSet rs = pStmt.executeQuery();

		while (rs.next()) {
			Map<String, Object> paymentLog = new HashMap<>();

			paymentLog.put("id", rs.getInt("id"));
			paymentLog.put("amount", rs.getInt("amount"));
			paymentLog.put("payAmount", rs.getInt("pay_amount"));
			paymentLog.put("changeAmount", rs.getInt("change_amount"));

			paymentLogList.add(paymentLog);

		}

		rs.close();
		pStmt.close();
		conn.close();
		return paymentLogList;
	}

}