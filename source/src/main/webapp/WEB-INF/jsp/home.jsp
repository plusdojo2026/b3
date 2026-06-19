<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ホーム - こぜピタ</title>
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
			<div class="page-title">メインメニュー</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->

		<section class="money-display">
			<div class="money-amount">
				<!-- 合計金額を入れる -->
				&yen;${totalAmount}
			</div>
			<div class="money-list">
				<!--お金の種類ごとの表示-->
				<!-- 10000円 -->

				<div class="money-type">
					<img src="/b3/images/money/tenThousandYen.png"> ×
					${wallet.tenThousandYen}
				</div>
				<!-- 5000円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiveThousandYen.png"> ×
					${wallet.fiveThousandYen}
				</div>
				<!-- 1000円 -->
				<div class="money-type">
					<img src="/b3/images/money/oneThousandYen.png"> ×
					${wallet.oneThousandYen}
				</div>

				<!-- 空白 -->
				<div class="money-type empty"></div>
				<!-- 500円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiveHundredYen.png"> ×
					${wallet.fiveHundredYen}
				</div>
				<!-- 100円 -->
				<div class="money-type">
					<img src="/b3/images/money/oneHundredYen.png"> ×
					${wallet.oneHundredYen}
				</div>
				<!-- 50円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiftyYen.png"> ×
					${wallet.fiftyYen}
				</div>
				<!-- 10円 -->
				<div class="money-type">
					<img src="/b3/images/money/tenYen.png"> × ${wallet.tenYen}
				</div>
				<!-- 5円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiveYen.png"> × ${wallet.fiveYen}
				</div>
				<!-- 1円 -->
				<div class="money-type">
					<img src="/b3/images/money/oneYen.png"> × ${wallet.oneYen}
				</div>
			</div>
			<a href="${pageContext.request.contextPath}/WalletServlet">予算登録・編集へ</a>
		</section>
		
		<!-- 簡易決済支援 -->
		
		<section class=coin-support>
		<div class="support-title">決済支援</div>
		<input type="text" maxlength="8" >
		<input type="submit" value="送信">
		</section>

		<!-- コラム枠 -->
		<div class="column-box"
			onclick="location.href='${pageContext.request.contextPath}/ColumnServlet'">
			<div class="column-title">コラム</div>

			<div class="column-content">

				<%-- キャラ画像（まだ無いのでコメントアウト） --%>
				<%-- <img src="${pageContext.request.contextPath}/images/character/pitao.png" class="column-character"> --%>

				<div class="column-balloon">${randomColumn.title_ja}って知ってる？</div>
			</div>
		</div>

		<!-- 下部ナビここから -->
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
		<!-- 下部ナビここまで -->
	</div>
</body>
</html>