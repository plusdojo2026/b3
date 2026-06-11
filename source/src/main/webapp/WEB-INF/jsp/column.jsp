<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<input type="text" maxlength="30" placeholder="検索したい文字を入力してください。">
		<button>検索</button>
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
		
			<!-- １件分のコラムを表示するブロック -->
			<div class="column-item" data-category="${col.category}">
			
				<!-- コラムのタイトルを表示 -->
				<div class="column-title">
					${col.title_ja}
					<span class="toggle-icon">▼</span>
				</div>
				
				<!-- 30文字まで -->
				<div class="column-short">
				</div>
	</div>
	
	</main>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
</body>
</html>