'use strict';

console.log("JSファイルが正常に読み込まれました ");


//ページ読み込み処理
document.addEventListener('DOMContentLoaded', () => {
	//データ読み込み
	displayStores(store_list);

	//カテゴリーボタンON,OFF
	document.querySelectorAll(".filter-btn").forEach(btn => {
		btn.addEventListener("click", () => {
			// クラスのON/OFF切り替え
			const isActive = btn.classList.toggle("active");
			
			// WAI-ARIA（アクセシビリティ属性）の状態も連動して切り替え
			btn.setAttribute("aria-pressed", isActive ? "true" : "false");
			
			// 絞り込み関数を実行
			category_filter();
		});
	});

	const keywordInput = document.getElementById('keyword');
	if (keywordInput) {
		let debounceTimer;
		keywordInput.addEventListener("input", () => {
			clearTimeout(debounceTimer);
			debounceTimer = setTimeout(() => loadStores(), 400);
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

	// 全データから、選択されたカテゴリーに一致するものだけを抽出
	const filteredList = store_list.filter(store => {
		// ボタンが1つも押されていない（全てOFF）場合は、全件表示
		if (selectedCategories.length === 0) {
			return true;
		}
		
		// 店のカテゴリーが、ONになっているカテゴリー配列に含まれているかチェック
		return selectedCategories.includes(store.category);
	});

	// ③ 絞り込んだ結果のデータで画面（HTML）を再描画
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

	list.forEach(s => {
		const div = document.createElement("div");
		div.className = "store-item";

		const distanceText = s.distance !== undefined
			? `<p>現在地からの距離: ${s.distance.toFixed(2)} km</p>`
			: '';
			
		const mapLink = (s.latitude && s.longitude)
		? `<p><a href="https://www.google.com/maps/search/?api=1&query=${s.latitude},${s.longitude}" target="_blank" rel="noopener noreferrer" class="map-btn">Googleマップで見る</a></p>`
		: '';

		div.innerHTML = `<h3>${s.name_ja}</h3>
						<p>${s.address_ja}</p> 
						<p>${s.category}</p> 
						<p>${s.cashless_type}</p> 
						${distanceText}
						${mapLink}`;
		container.appendChild(div);
	});
}

