package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.List;

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

}