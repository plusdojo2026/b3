package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

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

}