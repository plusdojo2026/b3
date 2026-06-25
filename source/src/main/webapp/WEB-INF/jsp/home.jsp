<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><fmt:message key="home.tab.title" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/home_wallet.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/introjs.min.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/home.js" defer></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/favicon/favicon.png">
<script>
	const contextPath = "${pageContext.request.contextPath}";
</script>


</head>


<body>
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title">
				<fmt:message key="home.title" />
			</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->

		<!-- メインここから -->
		<div class="alert-area is-hidden" id="alertArea"
			data-msg-no-budget="<fmt:message key='home.ninja.no_budget' />"
			data-msg-too-many-coins="<fmt:message key='home.ninja.too_many_coins' />"
			data-msg-low-budget="<fmt:message key='home.ninja.low_budget' />">

			<img
				src="${pageContext.request.contextPath}/images/character/cozeninja.png"
				class="home-cozeninja">

			<div class="message1" id="message1">
				<fmt:message key="home.ninja.low_budget" />
			</div>
		</div>

		<div id="total-amount">${totalAmount}</div>
		<div id="coin-amount">${totalCount}</div>
		<div id="alert-amount">${sessionScope.loginUser.alertAmount}</div>
		<div id="alert-count">${sessionScope.loginUser.alertCount}</div>
		<div id="show-tutorial">${showTutorial}</div>

		<section class="money-display">
			<div class="home-wallet-view" id="tutorial-wallet">
				<div class="character-pos">
					<img
						src="${pageContext.request.contextPath}/images/character/pitao.png"
						class="home-pitao">
				</div>

				<!--ブラインドボタン-->
				<div class="home-money-amount">
					<button type="button" class="home-eye-btn" id="eyeBtn">
						<img
							src="${pageContext.request.contextPath}/images/home_eye/blind-eye.png"
							alt="表示" class="eye-icon">
					</button>
					<span id="home-wallet-amount"> &yen;<fmt:formatNumber
							value="${totalAmount}" pattern="#,##0" />
					</span>
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
					class="toWallet" id="tutorial-wallet-edit"><fmt:message
						key="home.wallet-edit" /></a>
			</div>
		</section>

		<!-- 簡易決済支援 -->
		<section class="home-coin-support">
			<form method="GET"
				action="${pageContext.request.contextPath}/PaymentServlet"
				id="payment-form">
				<div class="support-title">
					<fmt:message key="home.payment" />
				</div>
				<div class="toPaymentArea">
					<input type="text" maxlength="8" name="amount"
						class="toPayment-input" inputmode="numeric"> <input type="submit"
						value="<fmt:message key="home.toPayment-input" />"
						class="toPayment-button">
				</div>
			</form>
		</section>

		<!-- コラム枠 -->
		<div class="home-column section-bottom">
			<div class="support-title">
				<fmt:message key="home.column" />
			</div>

			<div class="home-column-content"
				onclick="location.href='${pageContext.request.contextPath}/ColumnServlet'">

				<%-- キャラ画像（まだ無いのでコメントアウト） --%>
				<%-- <img src="${pageContext.request.contextPath}/images/character/pitao.png" class="column-character"> --%>

				<div class="column-balloon">
					<c:out value="${columnTitle}" />
				</div>
			</div>
		</div>
		<!-- メインここまで -->

		<!-- フッターここから -->
		<footer class="bottom-menu">

			<!-- ぴったり小銭消費ガイド -->
			<a href="${pageContext.request.contextPath}/CoinSupportServlet"
				class="nav-item" id="tutorial-nav-coin"> <img
				class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.coin_support' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/coin_support_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.coin_support' />">
			</a>

			<!-- 施設情報 -->
			<a href="${pageContext.request.contextPath}/StoreServlet"
				class="nav-item" id="tutorial-nav-store"> <img
				class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/store_info_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.store_info' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/store_info_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.store_info' />">
			</a>

			<div class="nav-space"></div>

			<!-- コラム -->
			<a href="${pageContext.request.contextPath}/ColumnServlet"
				class="nav-item" id="tutorial-nav-column"> <img
				class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/column_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.column' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/column_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.column' />">
			</a>

			<!-- マイページ -->
			<a href="${pageContext.request.contextPath}/MyPageServlet"
				class="nav-item" id="tutorial-nav-mypage"> <img
				class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />">
			</a>

			<!-- 支出登録 -->
			<a href="${pageContext.request.contextPath}/PaymentServlet"
				class="nav-center" id="tutorial-nav-payment"> <img
				class="nav-img center-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/payment_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.payment' />"> <img
				class="nav-img center-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/payment_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.payment' />">
			</a>

		</footer>
		<!-- フッターここまで -->
	</div>

	<script src="${pageContext.request.contextPath}/js/intro.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/tutorial.js"></script>
</body>
</html>