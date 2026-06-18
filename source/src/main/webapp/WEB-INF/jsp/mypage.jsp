<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>予算・登録編集 - こぜピタ</title>
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
			<div class="page-title">マイページ</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
		<main class="mypage">
			<section class="profile-edit">
				<div class="profile">プロフィール</div>
				<div class="user-id">
				ユーザID
					<!-- ユーザIDを表示 -->
					<div>${user.loginId}</div>
				</div>
				<div class="nickname">
				ニックネーム
					<!-- ニックネームを表示 -->
					<div>${user.nickname}</div>
				</div>
				<form action="UserEditServlet" method="get">
					<input type="submit" value="編集">
				</form>
			</section>

			<section class="night-mode">
				<div class="night">ナイトモード</div>
				<div class="sample2Area" id="makeImg">
					<input type="checkbox" id="sample2check" checked=""> 
					<label for="sample2check">
						<div id="sample2box"></div>
					</label>
				</div>
			</section>

			<section class="multilingual-feature">
				<div class=multilingual>多言語機能</div>
				<select class="pull-input">
					<option value="japanese">日本語</option>
					<option value="english">英語</option>
				</select>
			</section>

			<section class="alert-setting">
				<div class="alert">アラート設定</div>
				設定金額<input type="text" name="alert-money" value="">円 
				設定枚数<input
					type="number" name="alert-number" min="0" value="">枚
			</section>

			<section class="dress-up">
				<div class="dress">着せ替え機能</div>
				<button type="button" onclick="changeTheme('green')"></button>
				<button type="button" onclick="changeTheme('blue')"></button>
				<button type="button" onclick="changeTheme('purple')"></button>
				<button type="button" onclick="changeTheme('orange')"></button>
			</section>

			<section class="logout-user">
				<div class="logout">ログアウト</div>
				<form action="LogoutServlet" method="post">
					<input type="submit" value="ログアウト">
				</form>

			</section>



		</main>
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