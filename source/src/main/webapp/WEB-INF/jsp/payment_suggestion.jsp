<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	moneyTypes = new int[] { 10000, 5000, 1000, 500, 100, 50, 10, 5, 1 };
}

String amountText = String.format("%,d", amount);
String payAmountText = payAmount != null ? String.format("%,d", payAmount) : "";
String changeText = change != null ? String.format("%,d", change) : "";

String[] moneyImagePaths = { "tenThousandYen.png", "fiveThousandYen.png", "oneThousandYen.png", "fiveHundredYen.png",
		"oneHundredYen.png", "fiftyYen.png", "tenYen.png", "fiveYen.png", "oneYen.png" };
%>
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
				alt="ロゴ" class="logo">
			</a>
			<div class="page-title">支出登録</div>
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
					<div class="amount-label">合計金額は</div>
					<div class="amount-large">
						￥
						<%=amountText%>
					</div>
					<div class="amount-text">です。</div>
				</div>

				<%
				if (manualMode) {
				%>
				<div class="suggestion-card">
					<div class="suggestion-title">別の支払い方を入力</div>

					<form method="POST"
						action="${pageContext.request.contextPath}/PaymentServlet">
						<input type="hidden" name="amount" value="<%=amount%>"> <input
							type="hidden" name="action" value="confirm">

						<div class="money-suggestion-list">
							<%
							for (int i = 0; i < moneyTypes.length; i++) {
							%>
							<div class="money-suggestion-row">
								<img
									src="${pageContext.request.contextPath}/images/money/<%=moneyImagePaths[i]%>"
									alt="<%=moneyTypes[i]%>円" class="money-image"> <span
									class="money-dots">・・・</span> <span class="money-count">
									× <input type="number" name="payCount<%=i%>" value="0" min="0"
									class="manual-pay-count">
								</span>
							</div>
							<%
							}
							%>
						</div>
						<div class="manual-buttons">
							<input type="button" class="manual-btn" value="戻る"
								onclick="history.back()"> <input type="submit"
								class="manual-btn" value="確定">
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
					<div class="suggestion-title">この組み合わせで支払う</div>

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
					総支払金額：¥<%=payAmountText%>
				</div>

				<div class="suggestion-buttons">
					<form method="POST"
						action="${pageContext.request.contextPath}/PaymentServlet">
						<input type="hidden" name="amount" value="<%=amount%>"> <input
							type="hidden" name="action" value="other"> <input
							type="submit" class="payment-btn" value="別の支払い方">
					</form>

					<form method="POST"
						action="${pageContext.request.contextPath}/PaymentServlet">
						<input type="hidden" name="amount" value="<%=amount%>"> <input
							type="hidden" name="payAmount" value="<%=payAmount%>"> <input
							type="hidden" name="change" value="<%=change%>"> <input
							type="hidden" name="action" value="confirm">

						<%
						for (int i = 0; i < moneyTypes.length; i++) {
						%>
						<input type="hidden" name="payCount<%=i%>"
							value="<%=payCounts[i]%>">
						<%
						}
						%>

						<input type="submit" class="payment-button" value="確定">
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