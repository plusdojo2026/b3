<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ja">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>新規登録 - こぜピタ</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage_login.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/payment.js" defer></script>
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
			<div class="signup-nav">あなたの情報を登録してください</div>

			<form method="POST"
				action="${pageContext.request.contextPath}/SignupServlet"
				id="signup-form">

				<label class="logins"> ユーザーID <span class="input-note">※英数字のみ</span>
					<input type="text" name="loginId" class="signup-input" id="loginId"
					maxlength="20" required>
				</label> <label class="logins"> ニックネーム <span class="input-note">例）レオナルド</span>
					<input type="text" name="nickname" class="signup-input"
					id="nickname" maxlength="30" required>
				</label> <label class="logins"> パスワード <span class="input-note">※英字のみ、数字のみ、記号のみ不可</span>
					<input type="password" name="password" class="signup-input"
					id="password" maxlength="20" required>
				</label> <label class="logins logins-bottom"> パスワードの再入力 <span
					class="input-note">※上記と同一のものを入力してください</span> <input type="password"
					name="passwordConfirm" class="signup-input" id="passwordConfirm"
					maxlength="20" required>
				</label>
				<%
				if (request.getAttribute("errorMsg") != null) {
				%>
				<p class="error-message"><%=request.getAttribute("errorMsg")%></p>
				<%
				}
				%>
				<div class="form-buttons">
					<input type="reset" class="reset-button" name="reset" id="resetBtn"
						value="リセット"> <input type="submit" class="signup-button"
						name="submit" id="signupBtn" value="登録">
				</div>
			</form>
			<a href="${pageContext.request.contextPath}/LoginServlet"
				class="acount-msg">アカウントを既にお持ちの方はこちら</a>
		</main>
		<!-- メインここまで -->
	</div>
</body>
</html>
