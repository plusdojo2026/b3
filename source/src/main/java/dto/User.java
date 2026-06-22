package dto;

public class User {
	private int id;
	private int walletId;
	private String loginId;
	private String password;
	private String nickname;
	private String displayMode;
	private boolean night;
	private String language;
	private int alertAmount;
	private int alertCount;

	public User(int id, int walletId, String loginId, String password, String nickname, String displayMode,
			boolean night, String language, int alertAmount, int alertCount) {
		this.id = id;
		this.walletId = walletId;
		this.loginId = loginId;
		this.password = password;
		this.nickname = nickname;
		this.displayMode = displayMode;
		this.night = night;
		this.language = language;
		this.alertAmount = alertAmount;
		this.alertCount = alertCount;
	}

//	ゲッターとセッター
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getWalletId() {
		return walletId;
	}

	public void setWalletId(int walletId) {
		this.walletId = walletId;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getDisplayMode() {
		return displayMode;
	}

	public void setDisplayMode(String displayMode) {
		this.displayMode = displayMode;
	}

	public boolean isNight() {
		return night;
	}

	public void setNight(boolean night) {
		this.night = night;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public int getAlertAmount() {
		return alertAmount;
	}

	public void setAlertAmount(int alertAmount) {
		this.alertAmount = alertAmount;
	}

	public int getAlertCount() {
		return alertCount;
	}

	public void setAlertCount(int alertCount) {
		this.alertCount = alertCount;
	}
}