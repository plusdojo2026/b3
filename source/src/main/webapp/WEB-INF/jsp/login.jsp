<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ログイン - こぜピタ</title>
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
			<div class="page-title">会員登録</div>
			<a href="${pageContext.request.contextPath}/SignupServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<!-- メインここから -->
		<main class="main">


			<form method="POST"
				action="${pageContext.request.contextPath}/LoginServlet"
				id="login-form">

				<label class="logins" id="login-label-top"> ユーザーID <input
					type="text" name="loginId" class="login-input" id="loginId"
					maxlength="20" required>
				</label><label class="logins logins-bottom"> パスワード <input
					type="password" name="password" class="login-input" id="password"
					maxlength="20" required>
				</label> <label class="auto-login"> <input type="checkbox"
					name="autoLogin" id="autoLogin"> 次回から自動ログイン
				</label>
				<%
				if (request.getAttribute("errorMsg") != null) {
				%>
				<p class="error-message"><%=request.getAttribute("errorMsg")%></p>
				<%
				}
				%>
				<div class="form-buttons">
					<input type="submit" class="login-button" name="submit"
						id="loginBtn" value="ログイン">
				</div>
			</form>
		</main>
		<!-- メインここまで -->
	</div>
</body>
</html>
