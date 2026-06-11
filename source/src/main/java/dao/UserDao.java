package dao;

import dto.User;
import dto.Wallet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {

	public User findByLoginIdAndPassword(String loginId, String password) {
		User user = null;
		Connection conn = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
					"root", "password");

			String sql = "SELECT id, wallet_id, login_id, password, nickname, display_mode, night, language "
					+ "FROM users " + "WHERE login_id = ? AND password = ?";

			PreparedStatement pStmt = conn.prepareStatement(sql);

			pStmt.setString(1, loginId);
			pStmt.setString(2, password);

			ResultSet rs = pStmt.executeQuery();

			if (rs.next()) {
				user = new User(rs.getInt("id"), rs.getInt("wallet_id"), rs.getString("login_id"),
						rs.getString("password"), rs.getString("nickname"), rs.getString("display_mode"),
						rs.getBoolean("night"), rs.getString("language"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return user;
	}

	public boolean insertWithWallet(User user) {
		boolean result = false;
		Connection conn = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/b3?characterEncoding=utf8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B9",
					"root", "password");

			conn.setAutoCommit(false);

			Wallet wallet = new Wallet(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

			WalletDao walletDao = new WalletDao();
			int walletId = walletDao.insert(conn, wallet);

			insertUser(conn, user, walletId);

			conn.commit();

			result = true;

		} catch (Exception e) {
			e.printStackTrace();

			if (conn != null) {
				try {
					conn.rollback();
				} catch (Exception rollbackException) {
					rollbackException.printStackTrace();
				}
			}

		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return result;
	}

	private void insertUser(Connection conn, User user, int walletId) throws Exception {
		String sql = "INSERT INTO users " + "(wallet_id, login_id, password, nickname, display_mode, night, language) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

		PreparedStatement pStmt = conn.prepareStatement(sql);

		pStmt.setInt(1, walletId);
		pStmt.setString(2, user.getLoginId());
		pStmt.setString(3, user.getPassword());
		pStmt.setString(4, user.getNickname());
		pStmt.setString(5, user.getDisplayMode());
		pStmt.setBoolean(6, user.isNight());
		pStmt.setString(7, user.getLanguage());

		pStmt.executeUpdate();
	}
}