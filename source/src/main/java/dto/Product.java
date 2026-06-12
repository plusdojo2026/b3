package dto;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Product implements Serializable{
	//フィールド
	private int id;  //
	private int store_id;
	private String name_ja;
	private String name_en;
	private int price;
	private String category;
	private LocalDateTime created_at;
    private LocalDateTime updated_at;
	
    //コンストラクタ
	public Product(int id, int store_id, String name_ja, String name_en, int price, String category,
			LocalDateTime created_at, LocalDateTime updated_at) {
		super();
		this.id = id;
		this.store_id = store_id;
		this.name_ja = name_ja;
		this.name_en = name_en;
		this.price = price;
		this.category = category;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}
	
	//引数のないコンストラクタ
	public Product() {
		super();
		// TODO 自動生成されたコンストラクター・スタブ
	}
	
	//ゲッタとセッタ
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStore_id() {
		return store_id;
	}
	public void setStore_id(int store_id) {
		this.store_id = store_id;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}
	public LocalDateTime getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(LocalDateTime updated_at) {
		this.updated_at = updated_at;
	}
	
}
