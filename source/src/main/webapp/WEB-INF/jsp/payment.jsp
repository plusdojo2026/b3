<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>支出登録 - こぜピタ</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/payment.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/payment.js" defer></script>
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
			<div class="page-title">支出登録</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<!-- メインここから -->
		<main class="main">
			<div class="payment-nav">合計金額を入力してください</div>

			<form method="POST"
				action="${pageContext.request.contextPath}/PaymentServlet"
				id="payment-form">
				<label class="payments"> <input type="text" name="amount"
					class="amount-input" id="amountInput" maxlength="8">
				</label>
				<div class="money_isUse">使用できない紙幣・硬貨のチェックを外してください​</div>
				<div class="form-button">
					<input type="submit" name="submit" class="payment-button"
						id="paymentBtn" value="支払い">
				</div>
			</form>
			<div class="payment-nav-buttons">
			<input type="submit" class="payment-btn" value="戻る">
			<input type="submit" class="payment-btn" value="支出ログ"></div>
		</main>
		<!-- メインここまで -->
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
