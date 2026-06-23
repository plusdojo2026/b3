'use strict';

/* ------------------------- */
/* --------金額入力欄-------- */
/* ------------------------- */

const amountInput = document.querySelector('.amount-input');

let isComposing = false;

// 全角数字 → 半角数字
function toHalfWidthNumber(value) {
	return value.replace(/[０-９]/g, function(s) {
		return String.fromCharCode(s.charCodeAt(0) - 0xFEE0);
	});
}

// 金額表示用に整形
function formatAmount() {
	if (amountInput == null) {
		return;
	}

	let value = amountInput.value;

	// 全角数字を半角数字に変換
	value = toHalfWidthNumber(value);

	// 数字以外を消す
	value = value.replace(/[^0-9]/g, '');

	if (value.length === 0) {
		amountInput.value = '';
		return;
	}

	// 先頭の0を消す
	value = value.replace(/^0+/, '');

	if (value.length === 0) {
		amountInput.value = '';
		return;
	}

	// カンマ区切り + ¥
	amountInput.value = '¥' + Number(value).toLocaleString();
}

if (amountInput != null) {
	// IME入力開始
	amountInput.addEventListener('compositionstart', function() {
		isComposing = true;
	});

	// IME入力確定
	amountInput.addEventListener('compositionend', function() {
		isComposing = false;
		formatAmount();
	});

	amountInput.addEventListener('input', function() {
		// 全角入力の変換中は整形しない
		if (isComposing) {
			return;
		}

		formatAmount();
	});

	if (amountInput.form != null) {
		amountInput.form.addEventListener('submit', function() {
			let value = amountInput.value;

			value = toHalfWidthNumber(value);
			value = value.replace(/[^0-9]/g, '');

			amountInput.value = value;
		});
	}
}

/* ----------------------- */
/* --------財布開閉-------- */
/* ----------------------- */

const eyeBtn = document.getElementById("eyeBtn");
const moneyListView = document.getElementById("wallet-money-list");
const homeWalletAmount = document.getElementById("home-wallet-amount");

if (eyeBtn != null && moneyListView != null && homeWalletAmount != null) {
	const originalWalletAmount = homeWalletAmount.textContent;

	// 初期状態は金額を隠す
	homeWalletAmount.textContent = "~~~~~~";

	eyeBtn.addEventListener("click", function() {
		moneyListView.classList.toggle("open");

		if (moneyListView.classList.contains("open")) {
			// open が付いた時
			eyeBtn.textContent = "閉";
			homeWalletAmount.textContent = originalWalletAmount;
		} else {
			// open が外れた時
			eyeBtn.textContent = "目";
			homeWalletAmount.textContent = "~~~~~~";
		}
	});
}

/* ------------------------- */
/* --------予算アラート-------- */
/* ------------------------- */

const alertHomeAmount = document.getElementById("total-amount");
const alertHomeCount = document.getElementById("coin-amount");
const message1 = document.getElementById("message1");
const alertArea = document.querySelector(".alert-area");
const alertAmountElement = document.getElementById("alert-amount");
const alertCountElement = document.getElementById("alert-count");

if (alertHomeAmount != null && alertHomeCount != null && message1 != null && alertArea != null
	&& alertAmountElement != null && alertCountElement != null) {
	const homeCashAmount = Number(alertHomeAmount.textContent.replace(/[^0-9]/g, ''));
	const homeCoinCount = Number(alertHomeCount.textContent.replace(/[^0-9]/g, ''));

	const alertAmount = Number(alertAmountElement.textContent.replace(/[^0-9]/g, ''));
	const alertCount = Number(alertCountElement.textContent.replace(/[^0-9]/g, ''));
	if (homeCashAmount = 0) {
		message1.textContent = "予算を登録するでござる";
	} else if (homeCoinCount > alertCount) {
		message1.textContent = "小銭が多くなってきたでござる";
		alertArea.classList.remove("is-hidden");
	} else if (homeCashAmount < alertAmount) {
		message1.textContent = "予算が少なくなってきたでござる";
		alertArea.classList.remove("is-hidden");
	} else {
		alertArea.classList.add("is-hidden");
	}
}