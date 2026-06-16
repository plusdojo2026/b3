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
const recListUl = document.getElementById('recItemsList');

