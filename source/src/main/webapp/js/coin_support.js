/**
 * 
 */
// coin_support.js のテストコード
console.log("JSファイルが正常に読み込まれました ");

// JSPから持ってきた全商品データが見えるかチェック
if (allProducts !== null) {
	console.log("【成功】JSPからデータが届いています！データ件数:", allProducts.length, "件");
	console.log("中身の確認（最初の1件）:", allProducts[0]);
} else {
	console.error("【警告】allProducts が見つかりません。");
}

// JSPでつくったulを持ってくる
const recListUl = document.getElementById('recItemsList');//その他のおすすめ商品
const matchComboUl = document.getElementById('matchComboList');//ぴったりの組み合わせ商品

let targetAmount = 0;

//どちらのボタンが押されたか判断
if (submitType === "manual") {
	// 「金額を入力して探す」の時は、Javaが覚えておいてくれた数字を使う
	targetAmount = Number(manualAmount);
} else if (submitType === "wallet") {
	// 「小銭を使い切る」の時は、Servletから届いたtotalCoinsの値を使う
	targetAmount = Number(totalCoins);
}

// その他のおすすめ商品の「￥〇〇以下」を書き換える
const recAmount = document.getElementById('recAmount');
//「画面に書き換える場所が準備」されていて、かつ「ユーザーが任意の金額を検索した」とき、金額をセットする
if (recAmount && targetAmount > 0) {
	recAmount.textContent = `￥${targetAmount}以下`;
}
//-------------------------------------------
// 1. ぴったり小銭消費
//-------------------------------------------
//全ての組み合わせを収納するリスト
const allMatchedPatterns = [];

//商品数1つから4つまでの組み合わせで考えられるものすべて計算
// submitTypeが、manualかwalletのときだけ、中身の計算を実行
if (submitType === "manual" || submitType === "wallet") {

	//1つの商品でぴったりなもの
	for (let i = 0; i < allProducts.length; i++) {
		if (allProducts[i].price === targetAmount) {
			allMatchedPatterns.push([allProducts[i]]);
		}
	}
	// 2つの商品の合計でぴったりなもの
	for (let i = 0; i < allProducts.length; i++) {
		for (let j = i + 1; j < allProducts.length; j++) {
			if (allProducts[i].price + allProducts[j].price === targetAmount) {
				allMatchedPatterns.push([allProducts[i], allProducts[j]]);
			}
		}
	}

	// 3つの商品の合計でぴったりなもの
	for (let i = 0; i < allProducts.length; i++) {
		for (let j = i + 1; j < allProducts.length; j++) {
			for (let k = j + 1; k < allProducts.length; k++) {
				if (allProducts[i].price + allProducts[j].price + allProducts[k].price === targetAmount) {
					allMatchedPatterns.push([allProducts[i], allProducts[j], allProducts[k]]);
			}
		}
	}
}
	// 4つの商品の合計でぴったりなもの
	for (let i = 0; i < allProducts.length; i++) {
		for (let j = i + 1; j < allProducts.length; j++) {
			for (let k = j + 1; k < allProducts.length; k++) {
				for (let m = k + 1; m < allProducts.length; m++) {
					const total = allProducts[i].price + allProducts[j].price + allProducts[k].price + allProducts[m].price;
					if (total === targetAmount) {
						allMatchedPatterns.push([allProducts[i], allProducts[j], allProducts[k], allProducts[m]]);
					}
				}
			}
		}
	}
}
//集まった全パターンをシャッフル
for (let i = allMatchedPatterns.length - 1; i > 0; i--) {
	const r = Math.floor(Math.random() * (i + 1));
	const tmp = allMatchedPatterns[i];
	allMatchedPatterns[i] = allMatchedPatterns[r];
	allMatchedPatterns[r] = tmp;
}

//シャッフルした結果から最大3つだけをmatchComboUlに貼り付ける
if (allMatchedPatterns.length === 0) {
	const li = document.createElement('li');
	li.textContent = " ぴったりになる組み合わせはありませんでした";
	matchComboUl.appendChild(li);
} else {
	for (let i = 0; i < Math.min(3, allMatchedPatterns.length); i++) {
		const li = document.createElement('li');
		
		// 1. 見出しを作る
		const spanTitle = document.createElement('span');
		spanTitle.textContent = `【パターン${i + 1}】`;
		li.appendChild(spanTitle);

		// 2. そのパターンに含まれる商品のリストを取り出す
		const patternItems = allMatchedPatterns[i];
		
		// 3. 表示の段階で、含まれる商品の数だけループして画像と文字を出す
		patternItems.forEach((item, index) => {
			
			// 画像タグを作って、URL（image_url）をセット
			const img = document.createElement('img');
			img.src = "images/product/" + item.image_url + ".jpg";
			img.className = "prod-img";
		li.appendChild(img); // 画像を画面に追加

			// テキストを組み立てる
			let itemText = `[${item.store_name_ja}] ${item.name_ja} ￥${item.price}`;
			
			// 複数ある場合は間に「 ＋ 」、最後なら「 ＝ ￥合計」をつける
			if (index < patternItems.length - 1) {
				itemText += " ＋ ";
			} else {
				itemText += ` ＝ ￥${targetAmount}`;
			}
			li.append(itemText);
		});
		
		matchComboUl.appendChild(li);
	}
}

//------------------------------------------------
// 2. その他のおすすめ商品（金額以下の商品の表示）	
//---------------------------------------------------
// 現在選ばれているカテゴリーを覚えておく変数（初期状態はJSPに合わせたallItems）
let currentCategory = "allItems";

// 現在画面に何件表示されているかを管理するカウンター
let currentDisplayCount = 30;

// 並び替えや絞り込みを行った後の、最新の商品リストを一時保存する箱
let currentSortedProducts = [];

// 表示をアップデートする関数
function updateRecItems() {

	// 「その他のおすすめ」リストを空にする
	recListUl.innerHTML = "";

	// 1. カテゴリーで絞り込む
	let filteredProducts = allProducts;

	// 「すべて」でないなら、一致するカテゴリーだけを表示
	if (currentCategory !== "allItems") {
		filteredProducts = allProducts.filter(item => item.category === currentCategory);
	}

	// 2. 金額順に並び替える（ソート）
	const sortOrder = document.getElementById('sortOrder').value;

	// 大元の箱に保存して使い回せるようにする
	currentSortedProducts = [...filteredProducts];

	if (sortOrder === "priceAsc") {
		currentSortedProducts.sort((a, b) => a.price - b.price); // 安い順
	} else if (sortOrder === "priceDesc") {
		currentSortedProducts.sort((a, b) => b.price - a.price); // 高い順
	}

	// 絞り込みや並び替えが起きたら、表示件数を最初の30件にリセットする
	currentDisplayCount = 30;

	// 実際に画面を描画する関数を呼び出す
	renderProducts();
}
	// 画面に表示する
	function renderProducts() {
		// 「その他のおすすめ」リストを空にする
		recListUl.innerHTML = "";

		// 30件か、絞り込んだ全データ数の、どちらか小さい方を上限にする
		const limit = Math.min(currentDisplayCount, currentSortedProducts.length);

		// 0件目から現在の制限件数（30件、60件…）までをループして画面に出す
		for (let i = 0; i < limit; i++) {
			const item = currentSortedProducts[i];
			const li = document.createElement('li');
		
		//画像タグを新しくつくる
		const img =document.createElement('img');
		img.src = "images/product/" + item.image_url +".jpg";
		img.className = "prod-img";
		
		//リストにテキストをセット	
		//li.textContent = `${item.image_url} ${item.store_name_ja} ${item.name_ja} ￥${item.price}`;
		li.appendChild(img);
		li.append(`${item.store_name_ja} ${item.name_ja} ￥${item.price}`);
		
		// 完成したliを「その他のおすすめ」のulタグの中に追加
		recListUl.appendChild(li);
	}

	// ボタンの表示制御
	// これ以上読み込む商品がないなら、さらに読み込むボタンを非表示にする
	const loadMoreBtn = document.getElementById('btnLoadMore');
	if (currentDisplayCount >= currentSortedProducts.length) {
		loadMoreBtn.style.display = "none"; // 全件出し切ったら隠す
	} else {
		loadMoreBtn.style.display = "block"; // まだ残りがあれば出す
	}
}

//------------------------------------
// 3. カテゴリボタンを押したら絞り込みする処理
//------------------------------------
function setupCategoryFilter() {
	// 全てのカテゴリボタンを取得
	const buttons = document.querySelectorAll(".category-btn");

	// ボタンごとにクリック処理を設定
	buttons.forEach(function(btn) {
		btn.addEventListener("click", function() {
			// 全てのボタンからactiveを消す
			buttons.forEach(function(b) { b.classList.remove("active"); });
			
			// 押されたボタンだけにactiveをつける
			btn.classList.add("active");
			
			// 押されたボタンのカテゴリ名を変数に入れる
			currentCategory = btn.dataset.category;

			// 絞り込み表示を即座に更新
			updateRecItems();
		});
	});
}
// 最初は「すべて」のボタンにactiveをつける
const defaultBtn = document.querySelector(".category-btn[data-category='allItems']");
if (defaultBtn) { defaultBtn.classList.add("active"); }

// A. ソートのドロップダウンが変わったときに実行
document.getElementById('sortOrder').addEventListener('change', updateRecItems);

// B. メンバーのカテゴリボタン設定を起動
setupCategoryFilter();

// C. 「さらに読み込む」ボタンが押されたときのセンサー
document.getElementById('btnLoadMore').addEventListener('click', function() {
	// ボタンが押されたら、表示件数をさらに30件増やす
	currentDisplayCount += 30;
	// 増やした件数でもう一度画面を描き直す
	renderProducts();
});
// D. 画面が開いた時、初期表示する
updateRecItems();



