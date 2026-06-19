<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>コラム - こぜピタ</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/column.css">
<script src="${pageContext.request.contextPath}/js/common.js" defer></script>
<script src="${pageContext.request.contextPath}/js/column.js" defer></script>
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
			<div class="page-title">コラム</div>
			<a href="${pageContext.request.contextPath}/HomeServlet"> <img
				src="${pageContext.request.contextPath}/images/logo/home.png"
				alt="ホーム" class="toHome"></a>
		</header>
		<!-- ヘッダーここまで -->
	<main class="main">
	
	<!-- 検索フォーム -->
	<div class="search-box">
		<form method="GET" action="ColumnServlet">
			<input type="text" name="keyword" maxlength="30" placeholder="検索したい内容を入力">
			<button type="submit">検索</button>
		</form>
	</div>
	
	<!-- カテゴリ -->
	<div class="category-list">
		<div class="category-btn" data-category="全て">全て</div>
		<div class="category-btn" data-category="冠婚葬祭">冠婚葬祭</div>
		<div class="category-btn" data-category="日常生活">日常生活</div>
		<div class="category-btn" data-category="贈り物">贈り物</div>
		<div class="category-btn" data-category="ビジネス">ビジネス</div>
		<div class="category-btn" data-category="恋愛・結婚">恋愛・結婚</div>
		<div class="category-btn" data-category="家庭・親戚">家庭・親戚</div>
		<div class="category-btn" data-category="雑学">雑学</div>
	</div>
	
	<!-- コラム一覧  -->
	<!-- DBから受け取ったコラム一覧(list)を１件ずつ取り出す -->
	<div id="columnArea">
		
		<!-- listの中身を１件ずつcolに入れて繰り返す -->
		<c:forEach var="col" items="${list}">
		
			<!-- タイトルを、言語に応じて変数に入れる -->
			<c:if test="${lang == 'ja'}">
				<c:set var="title" value="${col.title_ja}"/>
			</c:if>
			<c:if test="${lang == 'en'}">
				<c:set var="title" value="${col.title_en}"/>
			</c:if>
			
			<!-- 本文を、言語に応じて変数に入れる -->
			<c:if test="${lang == 'ja'}">
				<c:set var="body" value="${col.column_ja}"/>
			</c:if>
			<c:if test="${lang == 'en'}">
				<c:set var="body" value="${col.column_en}"/>
			</c:if>
			
				<!-- １件分のコラムを表示するブロック -->
				<div class="column-item" data-category="${col.category}">
				
					<!-- コラムのタイトルを表示 -->
					<div class="column-title">
						${title}
						<span class="toggle-icon">▼</span>
					</div>
					
					<!-- 30文字まで（閉じている時） -->
					<div class="column-short">
						<c:choose>
							<c:when test="${fn:length(body) > 30}">
								${fn:substring(body, 0, 30)}...
							</c:when>
							<c:otherwise>
								${body}
							</c:otherwise>
						</c:choose>
					</div>
					
					<!-- 開いたときに表示する全文 -->
					<div class="column-full" style="display:none;">
						${body}
					</div>
			</div>
		
		</c:forEach>
	
	</div>
	
	<div id="noResultMessage" style="display:none;">
		該当するコラムが見つかりませんでした
	</div>
	
	</main>
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
				class="nav-item active"> <img class="nav-img normal-img"
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
				class="nav-center"> <img class="nav-img center-img normal-img"
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