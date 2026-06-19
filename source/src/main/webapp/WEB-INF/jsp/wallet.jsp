<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>予算・登録編集 - こぜピタ</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/home_wallet.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/home.js" defer></script>
<script src="${pageContext.request.contextPath}/js/wallet.js" defer></script>
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
			<div class="page-title">予算登録・編集</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<main class="wallet-page">
			<section class="total-amount">
				<div class="current-budget">現在の予算</div>
				<div class="amount">
					<!-- 合計金額を入れる -->
					&yen;${totalAmount}
				</div>
			</section>

			<div class=wallet-possession>所持金額を入力してください(枚数)</div>

			<form method="post" action="/b3/WalletServlet">

				<div class="money-list">
					<!--お金の種類ごとの入力欄-->
					<!-- 10000円 -->
				
					<div class="money-type">
						<img src="/b3/images/money/tenThousandYen.png"> × <input
							type="number" name="tenThousandYen" id="tenThousandYen" min="0"
							value="${wallet.tenThousandYen}">
					</div>
					<!-- 5000円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiveThousandYen.png"> × <input
							type="number" name="fiveThousandYen" id="fiveThousandYen" min="0"
							value="${wallet.fiveThousandYen}">
					</div>
					<!-- 1000円 -->
					<div class="money-type">
						<img src="/b3/images/money/oneThousandYen.png"> × <input
							type="number" name="oneThousandYen" id="oneThousandYen" min="0"
							value="${wallet.oneThousandYen}">
					</div>
					
					<!-- 空白 -->
					<div class="money-type empty"></div>
					<!-- 500円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiveHundredYen.png"> × <input
							type="number" name="fiveHundredYen" id="fiveHundredYen" min="0"
							value="${wallet.fiveHundredYen}">
					</div>
					<!-- 100円 -->
					<div class="money-type">
						<img src="/b3/images/money/oneHundredYen.png"> × <input
							type="number" name="oneHundredYen" id="oneHundredYen" min="0"
							value="${wallet.oneHundredYen}">
					</div>
					<!-- 50円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiftyYen.png"> × <input
							type="number" name="fiftyYen" id="fiftyYen" min="0"
							value="${wallet.fiftyYen}">
					</div>
					<!-- 10円 -->
					<div class="money-type">
						<img src="/b3/images/money/tenYen.png"> × <input
							type="number" name="tenYen" id="tenYen" min="0"
							value="${wallet.tenYen}">
					</div>
					<!-- 5円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiveYen.png"> × <input
							type="number" name="fiveYen" id="fiveYen" min="0"
							value="${wallet.fiveYen}">
					</div>
					<!-- 1円 -->
					<div class="money-type">
						<img src="/b3/images/money/oneYen.png"> × <input
							type="number" name="oneYen" id="oneYen" min="0"
							value="${wallet.oneYen}">
					</div>
				</div>
				<p id="msg"></p>
				<div class="button-regist">
					<button type="submit" name="submit" id="editBtn" value="更新">登録</button>
				</div>
				<p id="output"></p>

			</form>

		</main>
		<!-- フッターここから -->
		<footer class="bottom-menu">

			<a href="${pageContext.request.contextPath}/CoinSupportServlet"
				class="nav-item"> <img class="nav-img normal-img"
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
</body>
</html>