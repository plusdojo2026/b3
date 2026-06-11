package dto;

public class Wallet {
	private int id;
	private int tenThousandYen;
	private int fiveThousandYen;
	private int oneThousandYen;
	private int fiveHundredYen;
	private int oneHundredYen;
	private int fiftyYen;
	private int tenYen;
	private int fiveYen;
	private int oneYen;

	public Wallet(int id, int tenThousandYen, int fiveThousandYen, int oneThousandYen, int fiveHundredYen,
			int oneHundredYen, int fiftyYen, int tenYen, int fiveYen, int oneYen) {
		this.id = id;
		this.tenThousandYen = tenThousandYen;
		this.fiveThousandYen = fiveThousandYen;
		this.oneThousandYen = oneThousandYen;
		this.fiveHundredYen = fiveHundredYen;
		this.oneHundredYen = oneHundredYen;
		this.fiftyYen = fiftyYen;
		this.tenYen = tenYen;
		this.fiveYen = fiveYen;
		this.oneYen = oneYen;
	}

	// ゲッターとセッター
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTenThousandYen() {
		return tenThousandYen;
	}

	public void setTenThousandYen(int tenThousandYen) {
		this.tenThousandYen = tenThousandYen;
	}

	public int getFiveThousandYen() {
		return fiveThousandYen;
	}

	public void setFiveThousandYen(int fiveThousandYen) {
		this.fiveThousandYen = fiveThousandYen;
	}

	public int getOneThousandYen() {
		return oneThousandYen;
	}

	public void setOneThousandYen(int oneThousandYen) {
		this.oneThousandYen = oneThousandYen;
	}

	public int getFiveHundredYen() {
		return fiveHundredYen;
	}

	public void setFiveHundredYen(int fiveHundredYen) {
		this.fiveHundredYen = fiveHundredYen;
	}

	public int getOneHundredYen() {
		return oneHundredYen;
	}

	public void setOneHundredYen(int oneHundredYen) {
		this.oneHundredYen = oneHundredYen;
	}

	public int getFiftyYen() {
		return fiftyYen;
	}

	public void setFiftyYen(int fiftyYen) {
		this.fiftyYen = fiftyYen;
	}

	public int getTenYen() {
		return tenYen;
	}

	public void setTenYen(int tenYen) {
		this.tenYen = tenYen;
	}

	public int getFiveYen() {
		return fiveYen;
	}

	public void setFiveYen(int fiveYen) {
		this.fiveYen = fiveYen;
	}

	public int getOneYen() {
		return oneYen;
	}

	public void setOneYen(int oneYen) {
		this.oneYen = oneYen;
	}
}