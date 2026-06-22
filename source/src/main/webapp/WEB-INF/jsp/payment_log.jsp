<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="messages" />
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<%
List<Map<String, Object>> paymentLogList = (List<Map<String, Object>>) request.getAttribute("paymentLogList");
String errorMsg = (String) request.getAttribute("errorMsg");
%>

<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>支出ログ - こぜピタ</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/payment.css">
<link rel="icon"
	href="${pageContext.request.contextPath}/favicon/favicon.png">

<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/payment.js" defer></script>
</head>

<body>
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo">
			</a>

			<div class="page-title">
				<fmt:message key="payment.log" />
			</div>

			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome">
			</a>
		</header>
		<!-- ヘッダーここまで -->

		<!-- メインここから -->
		<main class="main">
			<section class="payment-log-area">
				<%
				if (errorMsg != null) {
				%>
				<div class="error-message"><%=errorMsg%></div>
				<%
				}
				%>

				<%
				if (paymentLogList == null || paymentLogList.size() == 0) {
				%>
				<div class="empty-message">
					<fmt:message key="payment.log.null" />
				</div>
				<%
				} else {
				for (Map<String, Object> paymentLog : paymentLogList) {
				%>
				<div class="payment-log-card">
					<div class="payment-log-amount">
						¥
						<%=String.format("%,d", paymentLog.get("amount"))%>
					</div>

					<div class="log-card-details">
						<div class="payment-log-pay">
							<fmt:message key="payment.log.pay" />
							：<%=String.format("%,d", paymentLog.get("payAmount"))%>
						</div>

						<div class="payment-log-cash">
							<fmt:message key="payment.log.change" />
							：<%=String.format("%,d", paymentLog.get("changeAmount"))%>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>

				<div class="payment-log-buttons">
					<input type="button" class="log-back-btn"
						value="<fmt:message key='payment.log.back' />"
						onclick="location.href='${pageContext.request.contextPath}/PaymentServlet'">
				</div>
			</section>
		</main>
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
				class="nav-center active"> <img
				class="nav-img center-img normal-img"
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