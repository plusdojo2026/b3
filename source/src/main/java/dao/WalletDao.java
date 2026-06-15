package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dto.Wallet;

public class WalletDao {

	public int insert(Connection conn, Wallet wallet) throws Exception {
		Class.forName("com.mysql.cj.jdbc.Driver");

		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
				"root", "password");

		String sql = "INSERT INTO wallets " + "(ten_thousand_yen, five_thousand_yen, one_thousand_yen, "
				+ "five_hundred_yen, one_hundred_yen, fifty_yen, " + "ten_yen, five_yen, one_yen) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

		pStmt.setInt(1, wallet.getTenThousandYen());
		pStmt.setInt(2, wallet.getFiveThousandYen());
		pStmt.setInt(3, wallet.getOneThousandYen());
		pStmt.setInt(4, wallet.getFiveHundredYen());
		pStmt.setInt(5, wallet.getOneHundredYen());
		pStmt.setInt(6, wallet.getFiftyYen());
		pStmt.setInt(7, wallet.getTenYen());
		pStmt.setInt(8, wallet.getFiveYen());
		pStmt.setInt(9, wallet.getOneYen());

		pStmt.executeUpdate();

		ResultSet rs = pStmt.getGeneratedKeys();

		if (rs.next()) {
			return rs.getInt(1);
		}
		throw new Exception("wallet_idの取得に失敗しました");
	}

	public int update(Wallet wallet) throws Exception {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
					"root", "password");

			String sql = "UPDATE wallets SET " + "ten_thousand_yen = ?," + "five_thousand_yen = ?,"
					+ "one_thousand_yen = ?," + "five_hundred_yen = ?," + "one_hundred_yen = ?," + "fifty_yen = ?,"
					+ "ten_yen = ?," + "five_yen = ?," + "one_yen = ? " + "WHERE id = ?";

			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setInt(1, wallet.getTenThousandYen());
			pStmt.setInt(2, wallet.getFiveThousandYen());
			pStmt.setInt(3, wallet.getOneThousandYen());
			pStmt.setInt(4, wallet.getFiveHundredYen());
			pStmt.setInt(5, wallet.getOneHundredYen());
			pStmt.setInt(6, wallet.getFiftyYen());
			pStmt.setInt(7, wallet.getTenYen());
			pStmt.setInt(8, wallet.getFiveYen());
			pStmt.setInt(9, wallet.getOneYen());

			pStmt.setInt(10, wallet.getId());

			return pStmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
			}

		}
	}

	public Wallet selectById(int id) throws Exception {
		Connection conn = null;
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
					"root", "password");

			String sql = "SELECT * FROM wallets WHERE id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setInt(1, id);
			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				return new Wallet(rs.getInt("id"), rs.getInt("ten_thousand_yen"), rs.getInt("five_thousand_yen"),
						rs.getInt("one_thousand_yen"), rs.getInt("five_hundred_yen"), rs.getInt("one_hundred_yen"),
						rs.getInt("fifty_yen"), rs.getInt("ten_yen"), rs.getInt("five_yen"), rs.getInt("one_yen"));
			}
			return null;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
			}

		}

	}
}
