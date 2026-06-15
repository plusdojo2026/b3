<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>コラム</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp" />
	<main>
	
	<!-- 検索フォーム -->
	<div class="search-box">
		<form method="GET" action="ColumnServlet">
			<input type="text" name="keyword" maxlength="30" placeholder="検索したい文字を入力してください。">
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
		<div class="category-btn" data-category="家族・親戚">家族・親戚</div>
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
					
					<!-- 30文字まで -->
					<div class="column-short">
						
						<!-- 30文字より長い場合 -->
						<c:if test="${fn:length(body) > 30}">
						 	${fn:substring(body, 0, 30)}...
						</c:if>
						
						<!-- 30文字以下の場合 -->
						<c:if test="${fn:length(body) <= 30}">
							${body}
						</c:if>
						
					</div>
					
					<!-- 本文（全文） -->
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
<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
</body>
</html>