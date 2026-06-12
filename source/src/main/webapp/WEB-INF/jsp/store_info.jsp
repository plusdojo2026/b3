<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp" />
	<main>
<!-- 検索機能 -->

<div name="search_map" id="search_map">
	<input type="text" id="keyword" placeholder="施設名、住所">
	<div class="search_btn">
		<img src="/webapp/images/search.png" alt="検索">
	</div>
</div>

<!-- カテゴリー -->
<div class="filter-container">
	<button type="button" class="filter-btn active" data-category="Cashonly" aria-pressed="true">
    現金のみ
  </button>
  <button type="button" class="filter-btn" data-category="Cashlessonly" aria-pressed="false">
    キャッシュレスのみ
  </button>
  <button type="button" class="filter-btn" data-category="Both" aria-pressed="false">
    両対応
  </button>
  <button type="button" class="filter-btn" data-category="ATM" aria-pressed="false">
    ATM
  </button>
  <button type="button" class="filter-btn" data-category="Exchange" aria-pressed="false">
    外貨両替機
  </button>
 </div>
<!-- 施設のリスト(内容はjsで) -->
<div id="store_list">
</div>
	</main>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
<script src="js/store_info.js"></script>
</body>
</html>