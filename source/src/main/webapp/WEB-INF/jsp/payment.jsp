<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />
<%
String errorMsg = (String) request.getAttribute("errorMsg");
String successMsg = (String) request.getAttribute("successMsg");
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
	href="${pageContext.request.contextPath}/images/favicon/favicon.png">
</head>
<body>
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title"><fmt:message key="payment.title" /></div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<!-- メインここから -->
		<main class="main">
			<div class="payment-nav" ><fmt:message key="payment.message.amount" /></div>
			<form method="POST"
				action="${pageContext.request.contextPath}/PaymentServlet"
				id="payment-form">
				<label class="payments"> <input type="text" name="amount"
					class="amount-input" id="amountInput" maxlength="8" value="${param.amount} ">
				</label>
				<div class="message-area">
					<%
					if (errorMsg != null) {
					%>
					<span class="error-message"><%=errorMsg%></span>
					<%
					} else if (successMsg != null) {
					%>
					<span class="success-message"><%=successMsg%></span>
					<%
					}
					%>
				</div>
				<div class="money_isUse"><fmt:message key="payment.message.check" /></div>
				<div class="money-check-area">
					<label class="money-option"> <input type="checkbox"
						name="moneyType" value="10000" checked> <img
						src="${pageContext.request.contextPath}/images/money/tenThousandYen.png"
						alt="10000円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="5000" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiveThousandYen.png"
						alt="5000円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="1000" checked> <img
						src="${pageContext.request.contextPath}/images/money/oneThousandYen.png"
						alt="1000円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="500" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiveHundredYen.png"
						alt="500円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="100" checked> <img
						src="${pageContext.request.contextPath}/images/money/oneHundredYen.png"
						alt="100円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="50" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiftyYen.png"
						alt="50円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="10" checked> <img
						src="${pageContext.request.contextPath}/images/money/tenYen.png"
						alt="10円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="5" checked> <img
						src="${pageContext.request.contextPath}/images/money/fiveYen.png"
						alt="5円" class="money-option-image">
					</label> <label class="money-option"> <input type="checkbox"
						name="moneyType" value="1" checked> <img
						src="${pageContext.request.contextPath}/images/money/oneYen.png"
						alt="1円" class="money-option-image">
					</label>
				</div>
				<div class="form-button">
					<input type="submit" name="submit" class="payment-button"
						id="paymentBtn" value="<fmt:message key='payment.button' />">
				</div>
			</form>
			<div class="payment-nav-buttons">
				<input type="button" class="payment-btn" value="<fmt:message key='payment.back' />"
					onclick="location.href='${pageContext.request.contextPath}/HomeServlet'">

				<input type="button" class="payment-btn" value="<fmt:message key='payment.log' />"
					onclick="location.href='${pageContext.request.contextPath}/PaymentLogServlet'">
			</div>
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
				class="nav-center active"> <img class="nav-img center-img normal-img"
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
