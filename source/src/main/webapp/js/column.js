'use strict';

// ページが読み込まれたら実行
window.onload = function() {
	setupAccordion();
	setupCategoryFilter();
	setupSearchFilter();
	checkNoResult();
};

// 1. タイトルを押したら本文を開閉する処理
function setupAccordion() {
	const titles = document.querySelectorAll(".column-title");
	
	// １つずつ処理を設定
	titles.forEach(function (title){
		
		// タイトルがクリックされた時の動作
		title.addEventListener("click", function(){
			
			// クリックされたタイトルが属するコラム全体を取得
			const item = title.closest(".column-item");
			
			// コラム全体部分を取得
			const full = item.querySelector(".column-full");
			
			// ▼マークのアイコン部分を取得
			const icon = title.querySelector(".toggle-icon");
			
			// 現在開いているかどうかを判定
			const isOpen = full.style.display === "block";
			
			// 開いていれば閉じる、閉じていれば開く
			full.style.display = isOpen ? "none" : "block";
			
			// 開いたらshort部分を消す、閉じたらshortを戻す
			const short = item.querySelector(".column-short");
			short.style.display = isOpen ? "block" : "none";
			
			// アイコンを ▼（閉じている） / ▲（開いている） に切り替え
			icon.textContent = isOpen ? "▼" : "▲";
		});
	});
}


// 2. 検索処理
function filterBySearch() {

	const items = document.querySelectorAll(".column-item");
	const searchInput = document.querySelector("input[name='keyword']");

	const keyword = searchInput.value.trim();

	// 現在選択中のカテゴリ取得
	const activeBtn = document.querySelector(".category-btn.active");
	const currentCategory = activeBtn
		? activeBtn.dataset.category
		: "全て";

	items.forEach(function(item) {

		const text = item.innerText;
		const itemCategory = item.dataset.category;

		// カテゴリ一致判定
		const matchCategory =
			(currentCategory === "全て" ||
			 currentCategory === itemCategory);

		// キーワード一致判定
		const matchKeyword =
			(keyword === "" ||
			 text.includes(keyword));

		// 両方一致した場合のみ表示
		item.style.display =
			(matchCategory && matchKeyword)
				? "block"
				: "none";
	});

	checkNoResult();
}



// 3. カテゴリボタンを押したら絞り込みする処理
function setupCategoryFilter() {
	
	// 全てのカテゴリボタンを取得
	const buttons = document.querySelectorAll(".category-btn");
	
	// ボタンごとにクリック処理を設定
	buttons.forEach(function (btn) {
		
		btn.addEventListener("click", function() {
			
			// activeの付け替え
			buttons.forEach(function(b){
				b.classList.remove("active");
			});
			btn.classList.add("active");
			
			// カテゴリ処理の際に検索ワードも取得する。
			filterBySearch();
		});
	});
};



// 4. 検索処理
function setupSearchFilter() {
	const searchInput =
		document.querySelector("input[name='keyword']");

	const searchBtn =
		document.querySelector(".search-box button");

	// 検索ボタン
	searchBtn.addEventListener("click", function(e) {

		e.preventDefault();
		filterBySearch();
	});

	// Enterキー検索
	searchInput.addEventListener("keyup", function(e) {

		if (e.key === "Enter") {
			e.preventDefault();
			filterBySearch();
		}
});		
}


// 5. 表示されているコラムが０件の際に表示するメッセージ

function checkNoResult() {
	
	// 全てのコラムを取得
	const item = document.querySelectorAll(".column-item");
	
	// 「display が none ではない」＝表示されているコラムだけを抽出
	const visible = Array.from(item).filter(function(i) {
		return i.style.display !== "none";
	});
	
	// 「該当するコラムが見つかりません」メッセージの要素を取得
	const msg = document.getElementById("noResultMessage");
	
	// 表示されているコラムが 0 件ならメッセージを表示、それ以外は非表示
	msg.style.display = visible.length === 0 ? "block" : "none"; 
}
