package dto;

import java.io.Serializable;

public class Column implements Serializable {
	
	private int id; // ID
	private String title_ja; // 日本語タイトル
	private String title_en; // 英語タイトル
	private String column_ja; // 日本語コラム
	private String column_en; // 英語コラム
	private String category; // カテゴリ
	
	public Column() {}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle_ja() {
		return title_ja;
	}
	public void setTitle_ja(String title_ja) {
		this.title_ja = title_ja;
	}
	public String getTitle_en() {
		return title_en;
	}
	public void setTitle_en(String title_en) {
		this.title_en = title_en;
	}
	public String getColumn_ja() {
		return column_ja;
	}
	public void setColumn_ja(String column_ja) {
		this.column_ja = column_ja;
	}
	public String getColumn_en() {
		return column_en;
	}
	public void setColumn_en(String column_en) {
		this.column_en = column_en;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
}
