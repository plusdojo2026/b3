<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ぴったり小銭消費ガイド- こぜピタ</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/home_wallet.css">
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/coin_support.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/home.js" defer></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/favicon/favicon.png">
</head>
<body>
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title">ぴったり小銭消費ガイド</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->

		<main>
			<%--任意の金額入力フォーム（金額を入力して探す）（上限は￥2,000） --%>
			<div class="search-box">
			<form action="${pageContext.request.contextPath}/CoinSupportServlet"
				method="GET">
				<h3>金額を入力して探す<span>（上限は￥2,000）</span></h3>
				<div class="search-inputs">
				<input type="number" inputmode="numeric" id="amountInput"
					name="amountInput" min="0" max="2000" placeholder="￥500-" required>

				<%--検索ボタン --%>
				<button type="submit" id="btnSearchAmount" name="submitType"
					value="manual">検索</button>
				</div>
			</form>
			</div>
			
			<%--財布の小銭から探す（上限は￥2,000） --%>
			<div class="walletsForm">
			<form action="${pageContext.request.contextPath}/CoinSupportServlet"
				method="GET">
				<h3>財布の小銭から探す<span>（上限は￥2,000）</span></h3>

				<%--現在の財布の小銭合計額をwalletsテーブルから取得 --%>
				<p>現在の財布の小銭合計<span>￥${totalCoins}</span></p>
					
				<%--この小銭を使いきる商品をみるボタン --%>
				<button type="submit" id="btnUseAllCoins" name="submitType"
					value="wallet">この小銭を使い切る商品をみる</button>
			</form>
			</div>
			
			
			<%--ぴったり使い切る組み合わせ （リストで表示）（最大4つまで（SQLで操作）））--%>
			<div class="matchComboArea">
				<h3>ぴったり使い切る組み合わせ</h3>
				<ul class="matchList" id="matchComboList">
				</ul>
			</div>

			<%--その他のおすすめ商品（現在の小銭合計をwalletsテーブルから取得） --%>
			<div class="recItemsArea">
				<h3>その他のおすすめ商品<span id="recAmount">￥${totalCoins}以下</span></h3>
					
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
			<div class="category-list">
				<button type="button" class="category-btn" data-category="allItems">すべて</button>
				<button type="button" class="category-btn" data-category="food">食べ物</button>
				<button type="button" class="category-btn" data-category="drink">飲み物</button>
				<button type="button" class="category-btn" data-category="other">その他</button>
			</div>

			<%--小銭合計以下のおすすめ商品（リストで表示）（最大30件まで）（さらに読み込むボタン(JSで操作））--%>
			<div class="recItemsArea">
				<ul class="recList" id="recItemsList">

				</ul>

				<div class="more-btn">
					<button type="button" id="btnLoadMore">さらに読み込む</button>
				</div>
			</div>

		</main>

		<!-- フッターここから -->
		<footer class="bottom-menu">

			<a href="${pageContext.request.contextPath}/CoinSupportServlet"
				class="nav-item active"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_normal.png"
				alt="ぴったり小銭消費ガイド"> <img class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_hover.png"
				alt="ぴったり小銭消費ガイド">
			</a> <a href="${pageContext.request.contextPath}/StoreServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/store_info_normal.png"
				alt="施設情報"> <img class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/store_info_hover.png"
				alt="施設情報">
			</a>

			<div class="nav-space"></div>

			<a href="${pageContext.request.contextPath}/ColumnServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/column_normal.png"
				alt="コラム"> <img class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/column_hover.png"
				alt="コラム">
			</a> <a href="${pageContext.request.contextPath}/MyPageServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_normal.png"
				alt="マイページ"> <img class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_hover.png"
				alt="マイページ">
			</a> <a href="${pageContext.request.contextPath}/PaymentServlet"
				class="nav-center"> <img class="nav-img center-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/payment_normal.png"
				alt="支出登録"> <img class="nav-img center-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/payment_hover.png"
				alt="支出登録">
			</a>

		</footer>
		<!-- フッターここまで -->
	</div>

	<script>
		'use strict';
		//JSPを仲介して、Servletから届いたデータを、JavaScriptが読める配列データに翻訳
		const allProducts = ${recItemsJson};

		//Servletから「どちらのボタンが押されたか」の目印をもらう
		const submitType = "${submitType}";

		//Servletから小銭の合計をもらう
		const totalCoins = ${totalCoins};

		//入力フォームに入力された金額をもらう
		const manualAmount = "${amountInput}";
	</script>
	<script src="${pageContext.request.contextPath}/js/coin_support.js"
		defer></script>
</body>
</html>