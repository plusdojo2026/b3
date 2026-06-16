package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import dto.Breakdown;

public class BreakdownDao {

	public void insert(Connection conn, Breakdown breakdown) throws Exception {
		String sql = "INSERT INTO breakdowns (payment_id, type_money, count_money) VALUES (?, ?, ?)";
		PreparedStatement pStmt = conn.prepareStatement(sql);

		pStmt.setInt(1, breakdown.getPaymentId());
		pStmt.setInt(2, breakdown.getTypeMoney());
		pStmt.setInt(3, breakdown.getCountMoney());

		pStmt.executeUpdate();
	}

}