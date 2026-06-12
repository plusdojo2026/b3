<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>予算登録・編集</title>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/common/header.jsp" />
	<main class="wallet-page">
		<section class="total-amount">
			<div>現在の予算</div>
			<div>
				<!-- 合計金額を入れる -->
				${totalAmount}
			</div>
		</section>

		<div>所持金額を入力してください(枚数)</div>

		<form method="post" action="/b3/WalletServlet">

			<div class="money-list">
				<!--お金の種類ごとの入力欄-->
				<!-- 10000円 -->
				<div class="money-type">
					<img src="/b3/images/money/tenThousandYen.png"> × <input type="number" name="tenThousandYen"
						min="0" value="">
				</div>
				<!-- 5000円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiveThousandYen.png"> × <input type="number" name="fiveThousandYen"
						min="0" value="">
				</div>
				<!-- 1000円 -->
				<div class="money-type">
					<img src="/b3/images/money/oneThousandYen.png"> × <input type="number" name="oneThousandYen"
						min="0" value="">
				</div>
				<!-- 500円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiveHundredYen.png"> × <input type="number" name="fiveHundredYen"
						min="0" value="">
				</div>
				<!-- 100円 -->
				<div class="money-type">
					<img src="/b3/images/money/oneHundredYen.png"> × <input type="number" name="oneHundredYen"
						min="0" value="">
				</div>
				<!-- 50円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiftyYen.png"> × <input type="number" name="fiftyYen" min="0"
						value="">
				</div>
				<!-- 10円 -->
				<div class="money-type">
					<img src="/b3/images/money/tenYen.png"> × <input type="number" name="tenYen" min="0"
						value="">
				</div>
				<!-- 5円 -->
				<div class="money-type">
					<img src="/b3/images/money/fiveYen.png"> × <input type="number" name="fiveYen" min="0"
						value="">
				</div>
				<!-- 1円 -->
				<div class="money-type">
					<img src="/b3/images/money/oneYen.png"> × <input type="number" name="oneYen" min="0"
						value="">
				</div>
			</div>

			<div class="button-regist">
				<button type="submit">登録</button>
			</div>

		</form>

	</main>
	<jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
</body>
</html>