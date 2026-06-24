<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><fmt:message key="store_info.tab" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/store_info.css">

<script>
const store_list = JSON.parse(String.raw`${storeListJson}`);
const contextPath = "<%= request.getContextPath() %>";
</script>

<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/store_info.js" defer></script>
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
			<div class="page-title">
				<fmt:message key="store_info.title" />
			</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->

		<main>
			<!-- 検索機能 -->

			<div class="search_map" id="search_map">
				<input type="text" id="keyword"
					placeholder="<fmt:message key="store_info.search" />">
				<button type="button" class="search_btn" aria-label="検索">
					<img
						src="${pageContext.request.contextPath}/images/store_icon/store_search.png"
						alt="検索">
				</button>
			</div>

			<!-- カテゴリー -->
			<div class="category_filter">
				<!-- 現金のみ -->
				<button type="button" class="filter-btn active"
					data-category="cashonly" aria-pressed="true">
					<fmt:message key="store_info.c.cashonly" />
				</button>
				<!-- キャッシュレスのみ -->
				<button type="button" class="filter-btn"
					data-category="cashlessonly" aria-pressed="false">
					<fmt:message key="store_info.c.cashlessonly" />
				</button>
				<!-- 両対応 -->
				<button type="button" class="filter-btn" data-category="both"
					aria-pressed="false">
					<fmt:message key="store_info.c.both" />
				</button>
				<!-- ATM -->
				<button type="button" class="filter-btn" data-category="ATM"
					aria-pressed="false">ATM</button>
				<!-- 外貨両替機 -->
				<button type="button" class="filter-btn" data-category="exchange"
					aria-pressed="false">
					<fmt:message key="store_info.c.exchange" />
				</button>
			</div>


			<!-- 施設のリスト(内容はjsで) -->
			<div id="store_list" class="store_list"></div>
		</main>


		<!-- フッターここから -->
		<footer class="bottom-menu">
			<!-- ぴったり小銭消費ガイド -->
			<a href="${pageContext.request.contextPath}/CoinSupportServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.coin_support' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.coin_support' />">
			<!-- 施設情報 -->
			</a> <a href="${pageContext.request.contextPath}/StoreServlet"
				class="nav-item active"> <img class="nav-img normal-img"
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


</body>
</html>