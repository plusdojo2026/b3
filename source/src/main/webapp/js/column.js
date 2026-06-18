'use strict';

// ページが読み込まれたら実行
window.onload = function() {
	setupAccordion();
	setupCategoryFilter();
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


// 2. カテゴリボタンを押したら絞り込みする処理
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
			
			// 押されたボタンのカテゴリ名を取得
			const category = btn.dataset.category;
			
			// 全てのコラムを取得
			const items = document.querySelectorAll(".column-item");
			
			// コラムを１つずつチェック
			items.forEach(function (item) {
				
				// コラムが持つカテゴリを取得
				const itemCategory = item.dataset.category;
				
				// 全てなら全部を表示、それ以外なら一致するカテゴリだけ表示する
				item.style.display = 
					(category === "全て" || category === itemCategory)
						? "block" : "none";
			});
			
			// 絞り込み後に結果が０件であるというメッセージを表示するかチェック
			checkNoResult();
		});
	});
};

// 3. 表示されているコラムが０件の際に表示するメッセージ

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

// 4. カテゴリ絞り込みと検索が共存して使えるように
document.addEventListener("DOMContentLoaded", () => {
	
	// 全てのコラム要素を取得（検索対象）
	const items = document.querySelectorAll(".column-item");
	
	// 検索フォームの入力欄
	const searchInput = document.querySelector("input[name='keyword']");
	
	// 検索ボタン
	const searchBtn = document.querySelector(".search-box button");
	
	// 画面遷移なしで検索処理　
	// 入力されたキーワードがタイトルか本文にあるコラムだけを表示する
	function filterBySearch() {
		const keyword = searchInput.value.trim(); //入力された文字列
	
	// 現在選択されているカテゴリを取得
	const activeBtn = document.querySelector(".category-btn.active");
	const currentCategory = activeBtn ? activeBtn.dataset.category : "全て";
	
	items.forEach(item => {
		const text = item.innerText; // コラム全体のテキスト
		const itemCategory = item.dataset.category; // コラムのカテゴリ
		
		// カテゴリ数判定
		const matchCategory = (currentCategory === "全て" || currentCategory ===  itemCategory);
		
		// キーワード一致判定
		const matchKeyword = (keyword === "" || text.includes(keyword));
		
		// 両方一致した時だけ表示
		item.style.display = (matchCategory && matchKeyword) ? "block" : "none";
	});
		
	checkNoResult();	
}		
		
	// preventDefaultで画面遷移を止めてjsの検索だけ実行する
	searchBtn.addEventListener("click", (e) => {
		e.preventDefault();
		filterBySearch();
	});
	
	// Enterキーでも検索できるように
	searchInput.addEventListener("keyup", e => {
		if (e.key === "Enter") {
			e.preventDefault();
			filterBySearch();
		}
	});
});

