<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

			<div class="page-title">支出ログ</div>

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
				<div class="empty-message">支出ログはまだありません。</div>
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
							支払い：<%=String.format("%,d", paymentLog.get("payAmount"))%>
						</div>

						<div class="payment-log-cash">
							お釣り：<%=String.format("%,d", paymentLog.get("changeAmount"))%>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>

				<div class="payment-log-buttons">
					<input type="button" class="log-back-btn" value="戻る"
						onclick="location.href='${pageContext.request.contextPath}/PaymentServlet'">
				</div>
			</section>
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