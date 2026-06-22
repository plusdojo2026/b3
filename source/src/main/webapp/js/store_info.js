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

	//検索ボタンが押されたとき検索
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

			// スペース区切りで複数ワードに分割
			const words = keyword.split(/\s+/);

			// 全てのワードが name または address に含まれているか（AND検索）
			matchKeyword = words.every(w =>
				name.includes(w) || address.includes(w)
			);
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


//施設情報を表示する
function displayStores(list) {
	const container = document.getElementById("store_list");
	container.innerHTML = "";
	
	// JSPからjaまたはenを読み取る
    const currentLang = document.body.dataset.lang || "ja"; // デフォルト 'ja'
	
	
	// 言語によって文字を切り替えるための翻訳データ（多言語辞書）
    const i18n = {
        noStoresFound: {
            ja: "該当する施設が見つかりませんでした。",
            en: "No matching facilities found."
        },
        distanceText: {
            ja: "現在地からの距離: {0} km",
            en: "Distance from current location: {0} km"
        },
        viewOnGoogleMaps: {
            ja: "Googleマップで見る",
            en: "View on Google Maps"
        },
        // カテゴリーのマッピング
        category: {
            'cashonly':     { ja: '現金のみ', en: 'Cash Only' },
            'cashlessonly': { ja: 'キャッシュレスのみ', en: 'Cashless Only' },
            'both':         { ja: '両対応', en: 'Both Acceptable' },
            'exchange':     { ja: '外貨両替機', en: 'Currency Exchange' }
        },
        // キャッシュレス種類のマッピング
        cashlessType: {
            'credit': { ja: 'クレジットカード', en: 'Credit Card' },
            'ic':     { ja: '交通系IC', en: 'Transit IC' },
            'qr':     { ja: 'QRコード決済', en: 'QR Code' }
        }
    };

	//件数がゼロのときの表示
	if (list.length === 0) {
		container.innerHTML = "<p>${i18n.noStoresFound[currentLang]}</p>";
		return;
	}

	
	// カテゴリーのカラム→日本語へ変換マッピング
	/*const categoryMapping = {
		'cashonly': '現金のみ',
		'cashlessonly': 'キャッシュレスのみ',
		'both': '両対応',
		'exchange': '外貨両替機'
	};*/

	//カテゴリー種類が複数あっても表示する
	function convertCategory(typeString) {
		return typeString
			.split(',')
			.map(t => t.trim())
			.map(t => {
                const match = i18n.category[t];
                return match ? match[currentLang] : t;
            })
			.join(' / ');
	}

	// キャッシュレス種類の
	/*const cashlessTypeMapping = {
		'credit': 'クレジットカード',
		'ic': '交通系IC',
		'qr': 'QRコード決済'
	};*/

	//キャッシュレス種類が複数あっても指定言語で表示する
	function convertCashlessType(typeString) {
		return typeString
			.split(',')
			.map(t => t.trim())
			.map(t => {
                const match = i18n.cashlessType[t];
                return match ? match[currentLang] : t;
            })
			.join(' / ');
	}

	list.forEach(s => {
		const div = document.createElement("div");
		div.className = "store-item";

		const distanceText = s.distance !== undefined
			? `<p>${i18n.noStoresFound[currentLang]}</p>`
			: '';

		const mapLink = (s.latitude && s.longitude)
			? `<p><a href="https://www.google.com/maps/search/?api=1&query=${s.latitude},${s.longitude}" target="_blank" rel="noopener noreferrer" class="map-btn">${i18n.viewOnGoogleMaps[currentLang]}</a></p>`
			: '';

		const storeCategory = s.category || "";

		//日本語マッピング変換(category)
		const categoryText = convertCategory(storeCategory);

		//both,cashlessのときcashlessTypeを表示
		const cashlessTypeText =
			(storeCategory.includes("both") || storeCategory.includes("cashlessonly"))
				? `<p>${convertCashlessType(s.cashless_type)}</p>`
				: '';
				
		// 店舗名や住所、DB等から多言語で取得できている場合は切り替える
        const storeName = (currentLang === 'en' && s.name_en) ? s.name_en : s.name_ja;
        const storeAddress = (currentLang === 'en' && s.address_en) ? s.address_en : s.address_ja;

		div.innerHTML = `<h3>${storeName}</h3>
                        <p>${storeAddress}</p> 
                        <p>${categoryText}</p> 
                        <p>${cashlessTypeText}</p> 
                        ${distanceText}
                        ${mapLink}`;
		container.appendChild(div);
	});
}

