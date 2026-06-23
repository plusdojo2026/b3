<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.currentLang}" />
<fmt:setBundle basename="messages" />
<%
String errorMsg = (String) request.getAttribute("errorMsg");
%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title><fmt:message key="login.tab" /></title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage_login.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/login.js" defer></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/favicon/favicon.png">
</head>
<body>
	<div class="app">
		<!-- ヘッダーここから -->
		<header class="header">
			<a href="${pageContext.request.contextPath}/SignupServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/logo.png"
				alt="ロゴ" class="logo"></a>
			<div class="page-title"><fmt:message key="login.title" /></div>
			<a href="${pageContext.request.contextPath}/SignupServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<!-- メインここから -->
		<main class="main">
		<div class="lang-switch">
    		<a href="${pageContext.request.contextPath}/LanguageServlet?lang=ja&from=/LoginServlet">JP</a> |
    		<a href="${pageContext.request.contextPath}/LanguageServlet?lang=en&from=/LoginServlet">EN</a>
		</div>

			<form method="POST"
				action="${pageContext.request.contextPath}/LoginServlet"
				id="login-form">

				<label class="logins" id="login-label-top"> <fmt:message key="login.userid" /> <input
					type="text" name="loginId" class="login-input" id="loginId"
					maxlength="20" required>
				</label><label class="logins logins-bottom"> <fmt:message key="login.password" /> <input
					type="password" name="password" class="login-input" id="password"
					maxlength="20" required>
				</label> <label class="auto-login"> <input type="checkbox"
					name="autoLogin" id="autoLogin"> <fmt:message key="login.auto" />
				</label>
				<p class="error-message">
					<%=errorMsg != null ? errorMsg : ""%>
				</p>


				<div class="form-buttons">
					<input type="submit" class="login-button" name="submit"
						id="loginBtn" value="<fmt:message key='login.login' />">
				</div>
			</form>
			<a href="${pageContext.request.contextPath}/SignupServlet"
				class="acount-msg"><fmt:message key="login.msg" /></a>
		</main>
		<!-- メインここまで -->
	</div>
</body>
</html>
