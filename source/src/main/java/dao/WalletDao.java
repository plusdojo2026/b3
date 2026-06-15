package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import dto.Wallet;

public class WalletDao {

	public int insert(Connection conn, Wallet wallet) throws Exception {
		try {
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
		} catch (Exception e) {
			e.printStackTrace();
			return -1; // ここ修正
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

	public int update(Connection conn, Wallet wallet) throws Exception {
		try {
			String sql = "UPDATE wallets set" + "ten_thousand_yen = ?" + "five_thousand_yen = ?"
					+ "one_thousand_yen = ?" + "five_hundred_yen = ?" + "one_hundred_yen = ?" + "fifty_yen = ?"
					+ "ten_yen = ?" + "five_yen = ?" + "one_yen = ?" + "WHERE id = ?";

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
			return -1; // ここ修正
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
