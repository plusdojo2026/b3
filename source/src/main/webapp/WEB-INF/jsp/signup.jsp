<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />
<%@ page import="dto.User"%>

<%
String errorMsg = (String) request.getAttribute("errorMsg");
User loginUser = (User) session.getAttribute("LoginUser");
%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><fmt:message key="signup.tab" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage_login.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/payment.js" defer></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/favicon/favicon.png">
</head>
<body>
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/SignupServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title"><fmt:message key="signup.title" /></div>
			<a href="${pageContext.request.contextPath}/SignupServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<!-- メインここから -->
		<main class="main">
		<div class="lang-switch">
    		<a href="${pageContext.request.contextPath}/LanguageServlet?lang=ja&from=/SignupServlet">JP</a> |
    		<a href="${pageContext.request.contextPath}/LanguageServlet?lang=en&from=/SignupServlet">EN</a>
		</div>
			<div class="signup-nav"><fmt:message key="signup.nav" /></div>

			<form method="POST"
				action="${pageContext.request.contextPath}/SignupServlet"
				id="signup-form">

				<label class="logins"> <fmt:message key="signup.userid" /> <span class="input-note"><fmt:message key="signup.id" /></span>
					<input type="text" name="loginId" class="signup-input" id="loginId"
					maxlength="20" required>
				</label> <label class="logins"> <fmt:message key="signup.nickname" /> <span class="input-note"><fmt:message key="signup.nick" /></span>
					<input type="text" name="nickname" class="signup-input"
					id="nickname" maxlength="30" required>
				</label> <label class="logins"> <fmt:message key="signup.password" /> <span class="input-note"><fmt:message key="signup.pw" /></span>
					<input type="password" name="password" class="signup-input"
					id="password" maxlength="20" required>
				</label> <label class="logins logins-bottom"> <fmt:message key="signup.confirmpw" /> <span
					class="input-note"><fmt:message key="signup.pwmemo" /></span> <input type="password"
					name="passwordConfirm" class="signup-input" id="passwordConfirm"
					maxlength="20" required>
				</label>
				<p class="error-message">
					<%=errorMsg != null ? errorMsg : ""%>
				</p>
				<div class="form-buttons">
					<input type="reset" class="reset-button" name="reset" id="resetBtn"
						value="<fmt:message key="signup.reset" />"> <input type="submit" class="signup-button"
						name="submit" id="signupBtn" value="<fmt:message key="signup.register" />">
				</div>
			</form>
			<a href="${pageContext.request.contextPath}/LoginServlet"
				class="acount-msg"><fmt:message key="signup.msg" /></a>
		</main>
		<!-- メインここまで -->
	</div>
</body>
</html>
