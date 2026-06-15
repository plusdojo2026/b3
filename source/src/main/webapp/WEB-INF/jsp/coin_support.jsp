<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ぴったり価格ガイド</title>
<link rel="stylesheet" href="/b3/css/common.css">
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp" />
	<main>
	<%--任意の金額入力フォーム（金額を入力して探す）（上限は￥2,000） --%>
	<form action="CoinSupportServlet" method="GET">
	<h3>金額を入力して探す<span>（上限は￥2,000）</span></h3>
	<input type="number"  inputmode="numeric" id="amountInput" name="amountInput" 
	 min="0" max="2000" placeholder="￥500-">
	
	<%--検索ボタン --%>
	<button type="submit" id="btnSearchAmount" name="submitType" value="manual">検索</button>
	</form>
	<%--財布の小銭から探す（上限は￥2,000） --%>
	<form action="CoinSupportServlet" method="GET">
	<h3>財布の小銭から探す<span>（上限は￥2,000）</span></h3>
	
	<%--現在の財布の小銭合計額をwalletsテーブルから取得 --%>
	<p>現在の財布の小銭合計<span>￥${totalCoins}</span></p>
	
	
	<%--この小銭を使いきる商品をみるボタン --%>
	<button type="submit" id="btnUseAllCoins" name="submitType" value="wallet">この小銭を使い切る商品をみる</button>
	</form>
	<%--ぴったり使い切る組み合わせ （リストで表示）（最大4つまで（SQLで操作）））--%>
	<div class="matchComboArea">
	<h3>ぴったり使い切る組み合わせ</h3>
	
	<ul class="matchList">
	<c:forEach var="item" items="${matchComboList}">
	<li>${item.storeId} 
	${item.nameJa} 
	${item.price}円</li>
    </c:forEach>
    </ul>
</div>
	
	<%--その他のおすすめ商品（現在の小銭合計をwalletsテーブルから取得） --%>
	<div class="recItemsArea">
	<h3>その他のおすすめ商品<span>￥${totalCoins}以下</span></h3>
	
	
	<%--ソートを選択できるドロップダウン --%>
	<div class="sort-area">
    <%--<label for="sortOrder">並び替え：</label> --%>
    <select id="sortOrder" name="sortOrder">
        <option value="recommend">おすすめ順</option>
        <option value="priceAsc">金額が安い順</option>
        <option value="priceDesc">金額が高い順</option>
    </select>
</div>
</div>	
	<%--カテゴリーを選択できるフィルターボタン （ServletかJSで連携）--%>
	<div class="filter-area">
    
    <label class="filter-btn">
        <input type="checkbox" name="category" value="allItems" checked>
        <span>すべて</span>
    </label>

    <label class="filter-btn">
        <input type="checkbox" name="category" value="food">
        <span>食べ物</span>
    </label>

    <label class="filter-btn">
        <input type="checkbox" name="category" value="drink">
        <span>飲み物</span>
    </label>

    <label class="filter-btn">
        <input type="checkbox" name="category" value="other">
        <span>その他</span>
    </label>
</div>
	
	<%--小銭合計以下のおすすめ商品（リストで表示）（最大30件まで）（さらに読み込むボタン(JSで操作））--%>
	<div class="recItemsArea">
	<ul class="recList" id="recIemsList">
    <c:forEach var="item" items="${recItemsList}">
        <li>${item.storeName} 
        ${item.nameJa} 
        ${item.price}円</li>
    </c:forEach>
</ul>
    
    <div class="more-btn">
        <button type="button" id="btnLoadMore">さらに読み込む</button>
    </div>
</div>
	
	</main>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
</body>
</html>