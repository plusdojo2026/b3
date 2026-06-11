<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ぴったり価格ガイド</title>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/header.jsp" />
	<main>
	<%--任意の金額入力フォーム（金額を入力して探す）（上限は￥2,000） --%>
	<h3>金額を入力して探す<span>（上限は2000円）</span></h3>
	<input type="number" inputmode="numeric" id="amountInput" name="amountInput" 
	min="0" max="2000" placeholder="￥500-">
	
	<%--検索ボタン --%>
	<button type="submit" id="btnSearchAmount">検索</button>
	
	<%--財布の小銭から探す（上限は￥2,000） --%>
	<h3>財布の小銭から探す<span>（上限は￥2,000）</span></h3>
	
	<%--現在の財布の小銭合計額をwalletsテーブルから取得 --%>
	<p>現在の財布の小銭合計<span>￥${totalCoins}</span></p>
	
	
	<%--この小銭を使いきる商品をみるボタン --%>
	<button type="submit" id="btnUseAllCoins">この小銭を使い切る商品をみる</button>
	
	<%--ぴったり使い切る組み合わせ （リストで表示）（最大4つまで）--%>
	<div class="matchComboArea">
	<h3>ぴったり使い切る組み合わせ</h3>
	
	<ul class="matchList">
	<c:forEach var="item" items="${matchComboList}">
	<li>${item.storeId} ${item.nameJa} ${item.price}円</li>
    </c:forEach>
    </ul>
</div>
	
	<%--その他のおすすめ商品（現在の小銭合計をwalletsテーブルから取得） --%>
	<div class="recItemsArea">
	<h3>その他のおすすめ商品<span>￥${totalCoins}</span></h3>
	
	
	<%--ソートを選択できるドロップダウン --%>
	
	
	<%--カテゴリーを選択できるフィルターボタン --%>
	
	
	<%--小銭合計以下のおすすめ商品（リストで表示）（最大30件まで）（さらに読み込むボタン）--%>
	
	
	
	</main>
<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
</body>
</html>