'use strict';

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

	if (amountInput.form) {
		amountInput.form.addEventListener('submit', function() {
			let value = amountInput.value;

			value = toHalfWidthNumber(value);
			value = value.replace(/[^0-9]/g, '');

			amountInput.value = value;
		});
	}
}


// 財布メニュー開閉
const eyeBtn = document.getElementById("eyeBtn");
const moneyListView = document.getElementById("wallet-money-list");
const homeWalletAmount = document.getElementById("home-wallet-amount");
const orignalWalletAmount = homeWalletAmount.textContent;
homeWalletAmount.textContent = "~~~~~~"

if (eyeBtn) {
	eyeBtn.addEventListener("click", function() {
		moneyListView.classList.toggle("open");

		if (moneyListView.classList.contains("open")) {
			// open が付いた時
			eyeBtn.textContent = "閉";
			homeWalletAmount.textContent = orignalWalletAmount;
		} else {
			// open が外れた時
			eyeBtn.textContent = "目";
			homeWalletAmount.textContent = "~~~~~~"
		}
	});
}
/*  予算アラート機能  */

let alertHomeAmount = Number(homeWalletAmount.textContent.replace(/[^0-9]/g, ''));

if()



