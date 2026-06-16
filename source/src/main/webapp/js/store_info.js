'use strict';

//店舗データ保持
let store_list = [];

//ページ読み込み処理
document.addEventListener('DOMContentLoaded', () => {
	//データ読み込み
	loadStores();

	//カテゴリーボタンON,OFF
	document.querySelectorAll(".filter-btn").forEach(btn => {
		btn.addEventListener("click", () => {
			btn.classList.toggle("active");
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

//キーワード入力取得
function getKeyword() {
	const el = document.getElementById("keyword");

	//スペースを除去
	return el ? el.value.trim() : "";
}

//位置情報追加を待ってから動くようにする
function getCurrentPosition() {
	return new Promise((resolve, reject) => {
		if (!navigator.geolocation) {
			reject(new Error("位置情報がサポートされていません"));
			return;
		}
		navigator.geolocation.getCurrentPosition(
			position => resolve({
				lat: position.coords.latitude,
				lng: position.coords.longitude
			}),
			error => reject(error),
			{ enableHighAccuracy: true, timeout: 5000 }
		);
	});
}

//サーブレットへ Ajaxで検索リクエストを送る
async function fetchStores() {
	const params = new URLSearchParams();

	const categories = getSelectedCategories();
	categories.forEach(c => params.append("category", c));

	const keyword = getKeyword();
	if (keyword) {
		const keywords = keyword.split(/[\s　]+/).filter(k => k.length > 0);
		keywords.forEach(k => params.append("keyword", k));
	}

	try {
		const position = await getCurrentPosition();
		params.append("lat", position.lat);
		params.append("lng", position.lng);
	} catch (err) {
		console.warn("現在地取得失敗:", err);
		params.append("lat", "35.681236");
		params.append("lng", "139.767125");
	}

	const response = await fetch("StoreServlet?" + params.toString());
	return response.json();
}

function loadStores() {
	fetchStores()
		.then(data => {
			store_list = data;
			displayStores(store_list);
		})
		.catch(err => console.error("データ取得失敗:", err));
}

//カテゴリーで表示・非表示
function category_filter() {
	const selected = getSelectedCategories();

	const filtered = store_list.filter(store =>
		selected.includes(store.category)
	);

	displayStores(filtered);
}

//店舗リストに表示

function displayStores(list) {
	const container = document.getElementById("store_list");
	container.innerHTML = "";

	list.forEach(s => {
		const div = document.createElement("div");
		div.className = "store-item";

		const distanceText = s.distance !== undefined
			? `<p>現在地からの距離: ${s.distance.toFixed(2)} km</p>`
			: '';

		div.innerHTML = `<h3>${s.name_ja}</h3>
                 <p>${s.address_ja}</p>
                 <p>${s.category}</p>
                 ${distanceText}`;
		container.appendChild(div);
	});
}