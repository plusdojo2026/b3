<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>施設情報 - こぜピタ</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/store_info.css">

<script>
const store_list = JSON.parse(String.raw`${storeListJson}`);
</script>

<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/store_info.js" defer></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/favicon/favicon.png">
</head>
</head>
<body>

	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title">施設情報</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->

		<main>
			<!-- 検索機能 -->

			<div class="search_map" id="search_map">
				<input type="text" id="keyword" placeholder="施設名、住所">
				<button type="button" class="search_btn" aria-label="検索">
					<img
						src="${pageContext.request.contextPath}/images/nav/store_search.png"
						alt="検索">
				</button>
			</div>

			<!-- カテゴリー -->
			<div class="category_filter">
				<button type="button" class="filter-btn active"
					data-category="cashonly" aria-pressed="true">現金のみ</button>
				<button type="button" class="filter-btn"
					data-category="cashlessonly" aria-pressed="false">
					キャッシュレスのみ</button>
				<button type="button" class="filter-btn" data-category="both"
					aria-pressed="false">両対応</button>
				<button type="button" class="filter-btn" data-category="ATM"
					aria-pressed="false">ATM</button>
				<button type="button" class="filter-btn" data-category="exchange"
					aria-pressed="false">外貨両替機</button>
			</div>


			<!-- 施設のリスト(内容はjsで) -->
			<div id="store_list"></div>
		</main>


		<!-- フッターここから -->
		<footer class="bottom-menu">
			<a href="${pageContext.request.contextPath}/CoinSupportServlet"
				class="nav-item">仮</a> <a
				href="${pageContext.request.contextPath}/StoreServlet"
				class="nav-item">仮</a>
			<div class="nav-space"></div>
			<a href="${pageContext.request.contextPath}/ColumnServlet"
				class="nav-item">仮</a> <a
				href="${pageContext.request.contextPath}/MyPageServlet"
				class="nav-item">仮</a> <a
				href="${pageContext.request.contextPath}/PaymentServlet"
				class="nav-center">仮</a>
		</footer>
		<!-- フッターここまで -->
	</div>


</body>
</html>