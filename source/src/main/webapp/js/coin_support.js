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

//JSPでつくったulを持ってくる(任意の金額または現在の財布の小銭以下の商品を表示)
const recListUl = document.getElementById('recItemsList');

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
    
 