package dto;

public class Breakdown {
	private int id;
	private int paymentId;
	private int typeMoney;
	private int countMoney;

	public Breakdown(int id, int paymentId, int typeMoney, int countMoney) {
		this.id = id;
		this.paymentId = paymentId;
		this.typeMoney = typeMoney;
		this.countMoney = countMoney;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getpPaymentId() {
		return paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public int getTypeMoney() {
		return typeMoney;
	}

	public void setTypeMoney(int typeMoney) {
		this.typeMoney = typeMoney;
	}

	public int getCountMoney() {
		return countMoney;
	}

	public void setCountMoney(int countMoney) {
		this.countMoney = countMoney;
	}
}
