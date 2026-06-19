'use strict';

const amountInput = document.querySelector('.toPayment-input');

if (amountInput != null) {
	amountInput.addEventListener('input', () => {
		let value = amountInput.value;

		// 数字以外を消す
		value = value.replace(/[^0-9]/g, '');

		// 未入力なら空に戻す
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

		// カンマ区切りにする
		const numberValue = Number(value).toLocaleString();

		// ¥を付けて表示
		amountInput.value = '¥' + numberValue;
	});

	amountInput.form.addEventListener('submit', () => {
		// Servletへ送る直前に、¥とカンマを消して数字だけにする
		amountInput.value = amountInput.value.replace(/[^0-9]/g, '');
	});
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

