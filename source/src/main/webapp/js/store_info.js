'use strict'

fetch("StoreServlet?lat=35.0&lng=135.0&keyword=aaa&category=Cashonly")
    .then(res => res.json())
    .then(data => console.log(data));


//カテゴリーボタンON,OFF
document.querySelectorAll(".category_filter").forEach(btn => {
	btn.addEventListener("click",() => {
		btn.classList.toggle("active");
		filterStores();
	});
});

//選択されたカテゴリ選択
function getSelectedCategories(){
	return[...document.querySelectorAll(".category-btn.active")]
	.map(btn => btn.dataset.category);
}

//キーワード入力取得
function getKeyword(){
	return document.getElementById("keyword").value;
}

//サーブレットへ Ajaxで検索リクエストを送る
function fetchStores(){
	const categories = getSelectedCategories();
	const keyword = getKeyword();
	
	const params = new URLSearchParams();
	categories.forEach(c => params.append("category",c));
	params.append("keyword",keyword);
	
	return fetch("StoreServlet?" + params.toString())
		.then(res => res.json());
		
//取得した店舗データを JS 側で保持する
let store_list = [];

function loadStores(){
	fetchStores().then(data => {
		store_list = data;
		displayStores(store_list);
	});
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
    const container = document.getElementById("store-list");
    container.innerHTML = "";

    list.forEach(s => {
        const div = document.createElement("div");
        div.className = "store-item";
        div.innerHTML = `
            <h3>${s.name_ja}</h3>
            <p>${s.address_ja}</p>
            <p>カテゴリ: ${s.category}</p>
        `;
        container.appendChild(div);
    });
}


}