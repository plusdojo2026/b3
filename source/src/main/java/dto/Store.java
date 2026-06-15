package dto;

import java.io.Serializable;

public class Store implements Serializable{
	private int id;
    private String name_ja;
    private String name_en;
    private String address_ja;
    private String address_en;
    private double latitude;
    private double longitude;
    private String category;
    private String cashless_type;
    
    private double distance;
    
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName_ja() {
		return name_ja;
	}
	public void setName_ja(String name_ja) {
		this.name_ja = name_ja;
	}
	public String getName_en() {
		return name_en;
	}
	public void setName_en(String name_en) {
		this.name_en = name_en;
	}
	public String getAddress_ja() {
		return address_ja;
	}
	public void setAddress_ja(String address_ja) {
		this.address_ja = address_ja;
	}
	public String getAddress_en() {
		return address_en;
	}
	public void setAddress_en(String address_en) {
		this.address_en = address_en;
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
	public String getCashless_type() {
		return cashless_type;
	}
	public void setCashless_type(String cashless_type) {
		this.cashless_type = cashless_type;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public Store() {
	    this.id = 0;
	    this.name_ja = "";
	    this.name_en = "";
	    this.address_ja = "";
	    this.address_en = "";
	    this.latitude = 0.0;
	    this.longitude = 0.0;
	    this.category = "";
	    this.cashless_type = "";
	}
	public Store(int id, String nameJa, String nameEn, String addressJa, String addressEn,
            double latitude, double longitude, String category, String cashlessType) {
   this.id = id;
   this.name_ja = nameJa;
   this.name_en = nameEn;
   this.address_ja = addressJa;
   this.address_en = addressEn;
   this.latitude = latitude;
   this.longitude = longitude;
   this.category = category;
   this.cashless_type = cashlessType;
}
}
