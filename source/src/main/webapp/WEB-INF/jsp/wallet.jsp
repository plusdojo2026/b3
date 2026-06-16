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
				<div>現在の予算</div>
				<div>
					<!-- 合計金額を入れる -->
					${totalAmount}
				</div>
			</section>

			<div>所持金額を入力してください(枚数)</div>

			<form method="post" action="/b3/WalletServlet">

				<div class="money-list">
					<!--お金の種類ごとの入力欄-->
					<!-- 10000円 -->
					<div class="money-type">
						<img src="/b3/images/money/tenThousandYen.png"> × <input
							type="number" name="tenThousandYen" min="0" value="${wallet.tenThousandYen}">
					</div>
					<!-- 5000円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiveThousandYen.png"> × <input
							type="number" name="fiveThousandYen" min="0" value="${wallet.fiveThousandYen}">
					</div>
					<!-- 1000円 -->
					<div class="money-type">
						<img src="/b3/images/money/oneThousandYen.png"> × <input
							type="number" name="oneThousandYen" min="0" value="${wallet.oneThousandYen}">
					</div>
					<!-- 500円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiveHundredYen.png"> × <input
							type="number" name="fiveHundredYen" min="0" value="${wallet.fiveHundredYen}">
					</div>
					<!-- 100円 -->
					<div class="money-type">
						<img src="/b3/images/money/oneHundredYen.png"> × <input
							type="number" name="oneHundredYen" min="0" value="${wallet.oneHundredYen}">
					</div>
					<!-- 50円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiftyYen.png"> × <input
							type="number" name="fiftyYen" min="0" value="${wallet.fiftyYen}">
					</div>
					<!-- 10円 -->
					<div class="money-type">
						<img src="/b3/images/money/tenYen.png"> × <input
							type="number" name="tenYen" min="0" value="${wallet.tenYen}">
					</div>
					<!-- 5円 -->
					<div class="money-type">
						<img src="/b3/images/money/fiveYen.png"> × <input
							type="number" name="fiveYen" min="0" value="${wallet.fiveYen}">
					</div>
					<!-- 1円 -->
					<div class="money-type">
						<img src="/b3/images/money/oneYen.png"> × <input
							type="number" name="oneYen" min="0" value="${wallet.oneYen}">
					</div>
				</div>

				<div class="button-regist">
					<button type="submit" name="submit" value="更新">登録</button>
				</div>

			</form>

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