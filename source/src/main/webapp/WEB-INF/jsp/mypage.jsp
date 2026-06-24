<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><fmt:message key="mypage.tab" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage_login.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/home.js" defer></script>
<script src="${pageContext.request.contextPath}/js/mypage.js" defer></script>
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
			<div class="page-title">
				<fmt:message key="mypage.title" />
			</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<!-- メインここから -->
		<main class="mypage">
			<section class="profile-edit">
				<div class="profile">
					<fmt:message key="mypage.profile" />
				</div>
				<div class="user-id">
					<fmt:message key="mypage.userID" />
					<!-- ユーザIDを表示 -->
					<div>${user.loginId}</div>
				</div>
				<div class="nickname">
					<fmt:message key="mypage.nickname" />
					<!-- ニックネームを表示 -->
					<div>${user.nickname}</div>
				</div>
				<form action="UserEditServlet" method="get">
					<input type="submit"
						value="<fmt:message key='mypage.button.edit' />">
				</form>
			</section>

			<section class="multilingual-feature">
				<form action="MyPageServlet" method="post">
					<input type="hidden" name="action" value="language">
					<div class="multilingual">
						<fmt:message key="mypage.multilingual" />
					</div>
					<select class="pull-input" name="language"
						onchange="this.form.submit()">
						<option value="ja"
							${sessionScope.currentLang != 'en' ? 'selected' : ''}>日本語</option>
						<option value="en"
							${sessionScope.currentLang == 'en' ? 'selected' : ''}>English</option>
					</select>
				</form>
			</section>

			<section class="alert-setting">
				<div class="alert">
					<fmt:message key="mypage.alert" />
				</div>

				<form action="MyPageServlet" method="post" class="alert-form">
					<input type="hidden" name="action" value="alert">

					<div class="alert-row">
						<div class="alert-item">
							<span class="alert-label"> <fmt:message
									key="mypage.amount" />
							</span> <input type="text" name="alertAmount"
								value="${user.alertAmount}"> <span class="alert-unit">
								<fmt:message key="mypage.en" />
							</span>
						</div>

						<div class="alert-item">
							<span class="alert-label"> <fmt:message
									key="mypage.quantity" />
							</span> <input type="number" name="alertCount" min="0"
								value="${user.alertCount}"> <span class="alert-unit">
								<fmt:message key="mypage.mai" />
							</span>
						</div>
					</div>

					<div class="alert-button-area">
						<input type="submit" value="<fmt:message key='mypage.change' />">
					</div>
				</form>
			</section>


			<section class="logout-user">
				<div class="logout">
					<fmt:message key="mypage.logout" />
				</div>
				<form action="LogoutServlet" method="post">
					<input type="submit"
						value="<fmt:message key='mypage.button.logout' />">
				</form>
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
				alt="<fmt:message key='menu.coin_support' />"> <!-- 施設情報 -->
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
				alt="<fmt:message key='menu.column' />"> <!-- マイページ -->
			</a> <a href="${pageContext.request.contextPath}/MyPageServlet"
				class="nav-item active"> <img class="nav-img normal-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_normal${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />"> <img
				class="nav-img hover-img"
				src="${pageContext.request.contextPath}/images/nav/mypage_hover${pageContext.response.locale.language == 'en' ? '_en' : ''}.png"
				alt="<fmt:message key='menu.mypage' />"> <!-- 支出登録 -->
			</a> <a href="${pageContext.request.contextPath}/PaymentServlet"
				class="nav-center"> <img class="nav-img center-img normal-img"
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