<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setBundle basename="messages" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
Integer amount =  (Integer) request.getAttribute("totalCoins");

String amountText = String.format("%,d", amount);
%>
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
<body data-lang="${sessionScope.currentLang}">
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title"><fmt:message key="coin.title" /></div>
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
				<h3><fmt:message key="coin.optional" /><span><fmt:message key="coin.maximum" /></span></h3>
				<div class="search-inputs">
				<input type="number" inputmode="numeric" id="amountInput"
					name="amountInput" min="0" max="2000" placeholder="￥500-" required>

				<%--検索ボタン --%>
				<button type="submit" id="btnSearchAmount" name="submitType"
					value="manual"><fmt:message key="coin.search" /></button>
				</div>
			</form>
			</div>
			
			<%--財布の小銭から探す（上限は￥2,000） --%>
			<div class="walletsForm">
			<form action="${pageContext.request.contextPath}/CoinSupportServlet"
				method="GET">
				<h3><fmt:message key="coin.wallet" /><span><fmt:message key="coin.maximum" /></span></h3>

				<%--現在の財布の小銭合計額をwalletsテーブルから取得 --%>
				<p><fmt:message key="coin.totalCoin" /><span>￥<%=amountText%></span></p>
					
				<%--この小銭を使いきる商品をみるボタン --%>
				<button type="submit" id="btnUseAllCoins" name="submitType"
					value="wallet"><fmt:message key="coin.productsSerch" /></button>
			</form>
			</div>
			
			
			<%--ぴったり使い切る組み合わせ （リストで表示）（最大4つまで（SQLで操作）））--%>
			<div class="matchComboArea">
				<h3><fmt:message key="coin.pittari" /></h3>
				<ul class="matchList" id="matchComboList">
				</ul>
			</div>

			<%--その他のおすすめ商品（現在の小銭合計をwalletsテーブルから取得） --%>
			<div class="recItemsArea">
				<h3><fmt:message key="coin.recItems" /><span id="recAmount">￥${totalCoins}<fmt:message key="coin.ika" /></span></h3>
					
				<%--ソートを選択できるドロップダウン --%>
				<div class="sort-area">
					<%--<label for="sortOrder">並び替え：</label> --%>
					<select id="sortOrder" name="sortOrder">
						<option value="recommend"><fmt:message key="coin.rec" /></option>
						<option value="priceAsc"><fmt:message key="coin.low" /></option>
						<option value="priceDesc"><fmt:message key="coin.high" /></option>
					</select>
				</div>
			</div>
			<%--カテゴリーを選択できるフィルターボタン （ServletかJSで連携）--%>
			<div class="category-list">
				<button type="button" class="category-btn" data-category="allItems"><fmt:message key="coin.all" /></button>
				<button type="button" class="category-btn" data-category="food"><fmt:message key="coin.food" /></button>
				<button type="button" class="category-btn" data-category="drink"><fmt:message key="coin.drink" /></button>
				<button type="button" class="category-btn" data-category="other"><fmt:message key="coin.other" /></button>
			</div>

			<%--小銭合計以下のおすすめ商品（リストで表示）（最大30件まで）（さらに読み込むボタン(JSで操作））--%>
			<div class="recItemsArea">
				<ul class="recList" id="recItemsList">

				</ul>

				<div class="more-btn">
					<button type="button" id="btnLoadMore"><fmt:message key="coin.more" /></button>
				</div>
			</div>

		</main>

		<!-- フッターここから -->
		<footer class="bottom-menu">

			<!-- ぴったり小銭消費ガイド -->
			<a href="${pageContext.request.contextPath}/CoinSupportServlet"
				class="nav-item active"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.coin_support' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.coin_support' />">
			<!-- 施設情報 -->
			</a> <a href="${pageContext.request.contextPath}/StoreServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/store_info_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.store_info' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/store_info_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.store_info' />">
			</a>

			<div class="nav-space"></div>
			
			<!-- コラム -->
			<a href="${pageContext.request.contextPath}/ColumnServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/column_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.column' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/column_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.column' />">
			<!-- マイページ -->
			</a> <a href="${pageContext.request.contextPath}/MyPageServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />">
			<!-- 支出登録 -->
			</a> <a href="${pageContext.request.contextPath}/PaymentServlet"
				class="nav-center"> <img class="nav-img center-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/payment_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.payment' />"> <img
				class="nav-img center-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/payment_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.payment' />">
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