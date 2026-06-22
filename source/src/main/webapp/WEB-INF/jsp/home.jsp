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
		<!-- メインここから -->
		<div id="total-amount">${totalAmount}</div>
		<div id="coin-amount">${totalCount}</div>
		<div class="message1" id="message1">予算が少なくなってきたでござる</div>
		<img 
			src="${pageContext.request.contextPath}/images/character/cozeninja.png" 
			class="home-cozeninja">

		<section class="money-display">
			<div class="home-wallet-view">
				<div class="character-pos">
					<img
						src="${pageContext.request.contextPath}/images/character/pitao.png"
						class="home-pitao">
				</div>
				<div class="home-money-amount">
					<button type="button" class="home-eye-btn" id="eyeBtn">目</button>
					<span id="home-wallet-amount">&yen;${totalAmount}</span>
				</div>
				<div class="home-money-list" id="wallet-money-list">
					<!--お金の種類ごとの表示-->
					<!-- 10000円 -->
					<label class="money-option"> <input type="text"
						name="home-money-type" value="10000" checked> <img
						src="${pageContext.request.contextPath}/images/money/tenThousandYen.png"
						alt="10000円" class="home-money-images"> <span
						class="money-count">${wallet.tenThousandYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="5000" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiveThousandYen.png"
						alt="5000円" class="home-money-images"> <span
						class="money-count">${wallet.fiveThousandYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="1000" checked> <img
						src="${pageContext.request.contextPath}/images/money/oneThousandYen.png"
						alt="1000円" class="home-money-images"> <span
						class="money-count">${wallet.oneThousandYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="500" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiveHundredYen.png"
						alt="500円" class="home-money-images"> <span
						class="money-count">${wallet.fiveHundredYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="100" checked> <img
						src="${pageContext.request.contextPath}/images/money/oneHundredYen.png"
						alt="100円" class="home-money-images"> <span
						class="money-count">${wallet.oneHundredYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="50" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiftyYen.png"
						alt="50円" class="home-money-images"> <span
						class="money-count">${wallet.fiftyYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="10" checked> <img
						src="${pageContext.request.contextPath}/images/money/tenYen.png"
						alt="10円" class="home-money-images"> <span
						class="money-count">${wallet.tenYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="5" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiveYen.png"
						alt="5円" class="home-money-images"> <span
						class="money-count">${wallet.fiveYen}</span>
					</label> <label class="money-option"> <input type="text"
						name="home-money-type" value="1" checked> <img
						src="${pageContext.request.contextPath}/images/money/oneYen.png"
						alt="1円" class="home-money-images"> <span
						class="money-count">${wallet.oneYen}</span>
					</label>
				</div>
				<a href="${pageContext.request.contextPath}/WalletServlet"
					class="toWallet">現金の追加・編集</a>
			</div>
		</section>

		<!-- 簡易決済支援 -->

		<section class="home-coin-support">
			<form method="GET"
				action="${pageContext.request.contextPath}/PaymentServlet"
				id="payment-form">
				<div class="support-title">決済支援</div>
				<div class="toPaymentArea">
					<input type="text" maxlength="8" name="amount"
						class="toPayment-input"> <input type="submit" value="支払い→"
						class="toPayment-button">
				</div>
			</form>


		</section>

		<!-- コラム枠 -->
		<div class="home-column section-bottom">
			<div class="support-title">コラム</div>

			<div class="home-column-content"
				onclick="location.href='${pageContext.request.contextPath}/ColumnServlet'">

				<%-- キャラ画像（まだ無いのでコメントアウト） --%>
				<%-- <img src="${pageContext.request.contextPath}/images/character/pitao.png" class="column-character"> --%>

				<div class="column-balloon">${randomColumn.title_ja}</div>
			</div>
		</div>
		<!-- メインここまで -->
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