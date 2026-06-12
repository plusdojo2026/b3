package dto;

import java.io.Serializable;

public class Store implements Serializable{
	private int id;
    private String nameJa;
    private String nameEn;
    private String addressJa;
    private String addressEn;
    private double latitude;
    private double longitude;
    private String category;
    private String cashlessType;
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNameJa() {
		return nameJa;
	}
	public void setNameJa(String nameJa) {
		this.nameJa = nameJa;
	}
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
	public String getAddressJa() {
		return addressJa;
	}
	public void setAddressJa(String addressJa) {
		this.addressJa = addressJa;
	}
	public String getAddressEn() {
		return addressEn;
	}
	public void setAddressEn(String addressEn) {
		this.addressEn = addressEn;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCashlessType() {
		return cashlessType;
	}
	public void setCashlessType(String cashlessType) {
		this.cashlessType = cashlessType;
	}
	
	public Store() {
	    this.id = 0;
	    this.nameJa = "";
	    this.nameEn = "";
	    this.addressJa = "";
	    this.addressEn = "";
	    this.latitude = 0.0;
	    this.longitude = 0.0;
	    this.category = "";
	    this.cashlessType = "";
	}
	public Store(int id, String nameJa, String nameEn, String addressJa, String addressEn,
            double latitude, double longitude, String category, String cashlessType) {
   this.id = id;
   this.nameJa = nameJa;
   this.nameEn = nameEn;
   this.addressJa = addressJa;
   this.addressEn = addressEn;
   this.latitude = latitude;
   this.longitude = longitude;
   this.category = category;
   this.cashlessType = cashlessType;
}
}
