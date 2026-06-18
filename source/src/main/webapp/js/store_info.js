'use strict';

console.log("JSファイルが正常に読み込まれました ");


//ページ読み込み処理
document.addEventListener('DOMContentLoaded', () => {
	//データ読み込み
	category_filter();

	//カテゴリーボタンON,OFF
	document.querySelectorAll(".filter-btn").forEach(btn => {
		btn.addEventListener("click", () => {
			// クラスのON/OFF切り替え
			const isActive = btn.classList.toggle("active");

			// 状態も連動して切り替え
			btn.setAttribute("aria-pressed", isActive ? "true" : "false");

			// 絞り込み関数を実行
			category_filter();
		});
	});

	//リアルタイム検索
	const keywordInput = document.getElementById('keyword');
	if (keywordInput) {
		let debounceTimer;
		keywordInput.addEventListener("input", () => {
			clearTimeout(debounceTimer);
			debounceTimer = setTimeout(() => category_filter(), 400); // ここを変更
		});
	}

	//検索ボタンが押されたとき
	const searchBtn = document.querySelector(".search_btn");
	if (searchBtn) {
		searchBtn.addEventListener("click", () => {
			category_filter();
		});
	}
});



//選択されたカテゴリ選択
function getSelectedCategories() {
	return [...document.querySelectorAll(".filter-btn.active")]
		.map(btn => btn.dataset.category);
}

function category_filter() {
	// 上の関数を呼び出して、ONのカテゴリー配列（例: ["Cashonly", "ATM"]）を取得
	const selectedCategories = getSelectedCategories();

	// 入力されたキーワードを取得
	const keyword = getKeyword();

	// 全データから、選択されたカテゴリーに一致するものだけを抽出
	const filteredList = store_list.filter(store => {

		// カテゴリ判定
		let matchCategory = true;
		if (selectedCategories.length > 0) {
			// 店舗のカテゴリ文字列
			const storeCategory = store.category || ""; 
			
			// 選択されているボタンのどれか1つでも、店舗のカテゴリ文字列に含まれているか判定
			matchCategory = selectedCategories.some(cat => storeCategory.includes(cat));
		}

		// キーワード判定 (施設名、住所にキーワードが含まれているか)
		let matchKeyword = true;
		if (keyword !== "") {
			const name = store.name_ja || "";
			const address = store.address_ja || "";
			// 施設名か住所のどちらかにキーワードが含まれているか
			matchKeyword = name.includes(keyword) || address.includes(keyword);
		}

		// 両方の条件（カテゴリ AND キーワード）が一致した時だけtrueを返す
		return matchCategory && matchKeyword;
	});

	// 絞り込んだ結果のデータで画面（HTML）を再描画
	displayStores(filteredList);
}

//キーワード入力取得
function getKeyword() {
	const el = document.getElementById("keyword");

	//スペースを除去
	return el ? el.value.trim() : "";
}



function displayStores(list) {
	const container = document.getElementById("store_list");
	container.innerHTML = "";
	
	//件数がゼロのときの表示
	if (list.length === 0) {
		container.innerHTML = "<p>該当する施設が見つかりませんでした。</p>";
		return;
	}
	
	// カテゴリーの日本語マッピング
	const categoryMapping = {
		'cashonly': '現金のみ',
		'cashlessonly': 'キャッシュレスのみ',
		'both': '両対応',
		'exchange': '外貨両替機'
	};
	
	// キャッシュレス種類
	const cashlessTypeMapping = {
    'credit': 'クレジットカード',
    'ic': '交通系IC',
    'qr': 'QRコード決済'
};

function convertCashlessType(typeString) {
    return typeString
        .split(',')               
        .map(t => t.trim())       
        .map(t => cashlessTypeMapping[t] || t) 
        .join(' / ');             
}

	list.forEach(s => {
		const div = document.createElement("div");
		div.className = "store-item";

		const distanceText = s.distance !== undefined
			? `<p>現在地からの距離: ${s.distance.toFixed(2)} km</p>`
			: '';

		const mapLink = (s.latitude && s.longitude)
			? `<p><a href="https://www.google.com/maps/search/?api=1&query=${s.latitude},${s.longitude}" target="_blank" rel="noopener noreferrer" class="map-btn">Googleマップで見る</a></p>`
			: '';

		const storeCategory = s.category || "";
		const cashlessTypeText = (storeCategory.includes("both") || storeCategory.includes("cashlessonly"))
			? `<p>${convertCashlessType(s.cashless_type)}</p>`
			: '';
		//日本語マッピングにあれば変換(category)
		const categoryJa = categoryMapping[storeCategory] || storeCategory;
		
		
		
		div.innerHTML = `<h3>${s.name_ja}</h3>
						<p>${s.address_ja}</p> 
						<p>${categoryJa}</p> 
						<p>${cashlessTypeText}</p> 
						${distanceText}
						${mapLink}`;
		container.appendChild(div);
	});
}

