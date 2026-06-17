/**
 * 
 */
 // coin_support.js のテストコード
console.log("JSファイルが正常に読み込まれました ");

// JSPから持ってきた全商品データが見えるかチェック
if ( allProducts !== null) {
    console.log("【成功】JSPからデータが届いています！データ件数:", allProducts.length, "件");
    console.log("中身の確認（最初の1件）:", allProducts[0]);
} else {
    console.error("【警告】allProducts が見つかりません。");
}

//JSPでつくったulを持ってくる
const recListUl = document.getElementById('recItemsList');//その他のおすすめ商品
const matchComboUl = document.getElementById('matchComboList');//ぴったりの組み合わせ商品

let targetAmount = 0;

//どちらのボタンが押されたか判断
if (submitType === "manual") {
    // 「金額を入力して探す」の時は、Javaが覚えておいてくれた数字を使う
    targetAmount=Number(manualAmount);
} else if (submitType === "wallet") {
    // 「小銭を使い切る」の時は、Servletから届いたtotalCoinsの値を使う
    targetAmount = Number(totalCoins);
}

//①ぴったり小銭消費
//全ての組み合わせを収納するリスト
const allMatchedPatterns = [];

//商品数1つから4つまでの組み合わせで考えられるものすべて計算

// 初期状態はループをスキップする
// submitTypeが、manualかwalletのときだけ、中身の計算を実行
if (submitType === "manual" || submitType === "wallet") {
	
//1つの商品でぴったりなもの
for (let i = 0; i < allProducts.length; i++) {
    if (allProducts[i].price === targetAmount) {
        allMatchedPatterns.push(`${allProducts[i].store_name_ja} ${allProducts[i].name_ja} ￥${allProducts[i].price}`);
    }
}
// 2つの商品の合計でぴったりなもの
for (let i = 0; i < allProducts.length; i++) {
    for (let j = i + 1; j < allProducts.length; j++) {
        if (allProducts[i].price + allProducts[j].price === targetAmount) {
            allMatchedPatterns.push(`[${allProducts[i].store_name_ja}] ${allProducts[i].name_ja} ￥${allProducts[i].price}
            ＋ [${allProducts[j].store_name_ja}] ${allProducts[j].name_ja} ￥${allProducts[j].price}＝ ￥${targetAmount}`);
        }
    }
}

// 3つの商品の合計でぴったりなもの
for (let i = 0; i < allProducts.length; i++) {
    for (let j = i + 1; j < allProducts.length; j++) {
        for (let k = j + 1; k < allProducts.length; k++) {
            if (allProducts[i].price + allProducts[j].price + allProducts[k].price === targetAmount) {
                allMatchedPatterns.push(`[${allProducts[i].store_name_ja}] ${allProducts[i].name_ja}￥${allProducts[i].price} 
                ＋ [${allProducts[j].store_name_ja}] ${allProducts[j].name_ja} ￥${allProducts[j].price}
                ＋ [${allProducts[k].store_name_ja}] ${allProducts[k].name_ja} ￥${allProducts[k].price}＝ ￥${targetAmount}`);
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
                    allMatchedPatterns.push(`[${allProducts[i].store_name_ja}] ${allProducts[i].name_ja} ￥${allProducts[i].price}
                    ＋ [${allProducts[j].store_name_ja}] ${allProducts[j].name_ja} ￥${allProducts[j].price}
                    ＋ [${allProducts[k].store_name_ja}] ${allProducts[k].name_ja} ￥${allProducts[k].price}
                    ＋ [${allProducts[m].store_name_ja}] ${allProducts[m].name_ja} ￥${allProducts[m].price}＝ ￥${targetAmount}`);
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
        li.textContent = `【パターン${i + 1}】${allMatchedPatterns[i]}`;
        matchComboUl.appendChild(li);
    }
}
	
	
//②その他のおすすめ商品（金額以下の商品の表示）	
//データを一件ずつ処理する
allProducts.forEach(item => {

//要素をJavaScript上に新規作成し、定数に入れる
const li = document.createElement('li');

// 言語設定（language）が英語なら、店舗名と商品名を英語に切り替える
//const storeName   = (language === 'en') ? item.store_name_en : item.store_name_ja;
//const productName = (language === 'en') ? item.name_en       : item.name_ja;

//定数liの中身を書き換える
li.textContent = `${item.store_name_ja} ${item.name_ja} ￥${item.price}`;

//完成した <li> を、JSPの <ul> の中に貼り付ける
    recListUl.appendChild(li);
    });
    


 