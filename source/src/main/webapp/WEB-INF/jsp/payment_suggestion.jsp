<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />
<%
String errorMsg = (String) request.getAttribute("errorMsg");
Integer amount = (Integer) request.getAttribute("amount");
Integer payAmount = (Integer) request.getAttribute("payAmount");
Integer change = (Integer) request.getAttribute("change");
int[] moneyTypes = (int[]) request.getAttribute("moneyTypes");
int[] payCounts = (int[]) request.getAttribute("payCounts");
Boolean manualMode = (Boolean) request.getAttribute("manualMode");

if (manualMode == null) {
	manualMode = false;
}

if (amount == null) {
	amount = 0;
}

if (moneyTypes == null) {
	moneyTypes = new int[]{10000, 5000, 1000, 500, 100, 50, 10, 5, 1};
}

String amountText = String.format("%,d", amount);
String payAmountText = payAmount != null ? String.format("%,d", payAmount) : "";
String changeText = change != null ? String.format("%,d", change) : "";

String[] moneyImagePaths = {"tenThousandYen.png", "fiveThousandYen.png", "oneThousandYen.png", "fiveHundredYen.png",
		"oneHundredYen.png", "fiftyYen.png", "tenYen.png", "fiveYen.png", "oneYen.png"};
%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><fmt:message key="payment.tab" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/payment.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/payment.js" defer></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/favicon/favicon.png">
</head>
<body data-lang="${sessionScope.currentLang}">
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo">
			</a>
			<div class="page-title">
				<fmt:message key="payment.title" />
			</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome">
			</a>
		</header>
		<!-- ヘッダーここまで -->

		<!-- メインここから -->
		<main class="main">
			<section class="suggestion-area">
				<div class="amount-message">
					<div class="amount-label">
						<fmt:message key="payment.suggestion.amount" />
					</div>
					<div class="amount-large">
						￥
						<%=amountText%>
					</div>
					<div class="amount-text">
						<fmt:message key="payment.suggestion.amount.end" />
					</div>
				</div>

				<%
				if (manualMode) {
				%>
				<div class="suggestion-card">
					<div class="suggestion-title">
						<fmt:message key="payment.suggestion.other" />
					</div>

					<form method="POST"
						action="${pageContext.request.contextPath}/PaymentServlet"
						onsubmit="return checkManualPayment();">
						<input type="hidden" name="amount" value="<%=amount%>"> <input
							type="hidden" name="action" value="confirm">

						<div class="money-suggestion-list">
							<%
							for (int i = 0; i < moneyTypes.length; i++) {
								int displayPayCount = 0;
								if (payCounts != null && payCounts.length > i) {
									displayPayCount = payCounts[i];
								}
							%>
							<div class="money-suggestion-row">
								<img
									src="${pageContext.request.contextPath}/images/money/<%=moneyImagePaths[i]%>"
									alt="<%=moneyTypes[i]%>円" class="money-image"> <span
									class="money-dots">・・・</span> <span class="money-count">
									× <input type="number" name="payCount<%=i%>"
									value="<%=displayPayCount%>" min="0" class="manual-pay-count">
								</span>
							</div>
							<%
							}
							%>
						</div>

						<div class="manual-buttons">
							<input type="button" class="manual-btn"
								value="<fmt:message key='payment.suggestion.back' />"
								onclick="history.back()"> <input type="submit"
								class="manual-btn"
								value="<fmt:message key='payment.suggestion.confirm' />">
						</div>

						<div class="manual-message-area">
							<%
							if (errorMsg != null) {
							%>
							<span class="error-message"><%=errorMsg%></span>
							<%
							}
							%>
						</div>
					</form>
				</div>
				<%
				} else {
				%>
				<div class="suggestion-card">
					<div class="suggestion-title">
						<fmt:message key="payment.suggestion.title" />
					</div>

					<div class="money-suggestion-list">
						<%
						for (int i = 0; i < moneyTypes.length; i++) {
							if (payCounts[i] > 0) {
						%>
						<div class="money-suggestion-row">
							<img
								src="${pageContext.request.contextPath}/images/money/<%=moneyImagePaths[i]%>"
								alt="<%=moneyTypes[i]%>円" class="money-image"> <span
								class="money-dots">・・・</span> <span class="money-count">
								× <%=payCounts[i]%>
							</span>
						</div>
						<%
						}
						}
						%>
					</div>
				</div>

				<div class="total-pay-amount">
					<fmt:message key="payment.suggestion.total" />
					：¥<%=payAmountText%>
				</div>

				<div class="suggestion-buttons">
					<form method="POST"
						action="${pageContext.request.contextPath}/PaymentServlet">
						<input type="hidden" name="amount" value="<%=amount%>"> <input
							type="hidden" name="action" value="other"> <input
							type="submit" class="payment-btn"
							value="<fmt:message key='payment.suggestion.other' />">
					</form>

					<form action="${pageContext.request.contextPath}/PaymentServlet"
						method="post">
						<input type="hidden" name="amount" value="<%=amount%>"> <input
							type="hidden" name="payAmount" value="<%=payAmount%>"> <input
							type="hidden" name="change" value="<%=change%>"> <input
							type="hidden" name="action" value="confirm">

						<%
						for (int i = 0; i < moneyTypes.length; i++) {
						%>
						<input type="hidden" name="payCount<%=i%>"
							value="<%=payCounts[i]%>" inputmode="numeric">
						<%
						}
						%>

						<input type="submit" class="payment-button"
							value="<fmt:message key='payment.suggestion.confirm' />">
					</form>
				</div>
				<%
				}
				%>
			</section>
		</main>
		<!-- メインここまで -->

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
			</a>

			<!-- 施設情報 -->
			<a href="${pageContext.request.contextPath}/StoreServlet"
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
			</a>

			<!-- マイページ -->
			<a href="${pageContext.request.contextPath}/MyPageServlet"
				class="nav-item"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />">
			</a>

			<!-- 支出登録 -->
			<a href="${pageContext.request.contextPath}/PaymentServlet"
				class="nav-center active"> <img
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

	<script>
		function checkManualPayment() {
			const inputs = document.querySelectorAll('input[name^="payCount"]');
			let totalCount = 0;

			for (const input of inputs) {
				const count = Number(input.value);

				if (count > 0) {
					totalCount += count;
				}
			}

			if (totalCount === 0) {
				const currentLang = document.body.dataset.lang;

			    if (currentLang === 'en') {
			        alert('Please enter at least one bill or coin.');
			    } else {
			        alert('支払う紙幣・硬貨を1枚以上入力してください。');
			    }

			    return false;
			};
		}
	</script>
</body>
</html>