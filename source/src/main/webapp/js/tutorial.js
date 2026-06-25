'use strict';

const messages = {
ja: {
		welcomeTitle: 'こぜピタへようこそ',
		welcomeText: 'こぜピタは、財布の中の現金を見える化して、支払い方までサポートするアプリです。まずは主な機能を紹介します。',

		walletTitle: '財布の中身を確認',
		walletText: 'ここでは、登録した現金の合計金額や、紙幣・硬貨の枚数を確認できます。今の財布の状態をひと目で見られます。',

		walletEditTitle: '現金の追加・編集',
		walletEditText: '最初にここから財布の中身を登録しましょう。登録しておくと、支出登録や支払い提案が正確になります。',

		paymentTitle: '支出登録',
		paymentText: '支払金額を入力すると、小銭が少なく残る支払い方を提案します。支払い後は財布の中身も自動で更新されます。',

		coinTitle: '小銭ぴったり消費ガイド',
		coinText: '手持ちの小銭をうまく使うための機能です。財布に小銭が増えてきたときに活用できます。',

		storeTitle: '施設情報',
		storeText: '現金が使える場所や、現金まわりの施設情報を確認できます。外出先で現金を使いたいときに便利です。',

		columnTitle: 'コラム',
		columnText: '現金やお金に関するちょっとした知識を読めます。すきま時間に気軽にチェックできます。',

		mypageTitle: 'マイページ',
		mypageText: '表示設定や言語設定、アラート金額・枚数の変更ができます。自分に合った使い方に調整しましょう。',

		nextLabel: '次へ',
		prevLabel: '戻る',
		doneLabel: '完了'
	},

	en: {
		welcomeTitle: 'Welcome to Kozepita',
		welcomeText: 'Kozepita visualizes the cash in your wallet and helps you choose how to pay. First, let us introduce the main features.',

		walletTitle: 'Check Wallet Contents',
		walletText: 'You can view the total amount of cash, bills, and coins registered in your wallet.',

		walletEditTitle: 'Add or Edit Cash',
		walletEditText: 'Start by registering the cash currently in your wallet. This helps improve payment suggestions.',

		paymentTitle: 'Register Expenses',
		paymentText: 'Enter a payment amount and the app will suggest a way to minimize remaining coins. Your wallet contents are updated automatically.',

		coinTitle: 'Coin Usage Guide',
		coinText: 'This feature helps you use the coins you already have efficiently.',

		storeTitle: 'Facility Information',
		storeText: 'Find places where cash can be used and view other cash-related information.',

		columnTitle: 'Articles',
		columnText: 'Read short articles and tips about cash and money.',

		mypageTitle: 'My Page',
		mypageText: 'Change display settings, language settings, and alert thresholds.',

		nextLabel: 'Next',
		prevLabel: 'Back',
		doneLabel: 'Done'}
		};

document.addEventListener('DOMContentLoaded', function() {
	const showTutorialElement = document.getElementById('show-tutorial');
	const lang = window.currentLang || 'ja';
	const msg = messages[lang];
	

	if (showTutorialElement == null) {
		return;
	}

	const showTutorial = showTutorialElement.textContent.trim();

	if (showTutorial !== 'true') {
		return;
	}

	if (typeof introJs === 'undefined') {
		console.error('Intro.jsが読み込まれていません。');
		return;
	}

	const steps = [];

	addFloatingStep(
		steps,
		msg.welcomeTitle,
		msg.welcomeText
		
	);

	addStep(
		steps,
		'#tutorial-wallet',
		msg.walletTitle,
		msg.walletText
	);

	addStep(
		steps,
		'#tutorial-wallet-edit',
		msg.walletEditTitle,
		msg.walletEditText
	);

	addStep(
		steps,
		'#tutorial-nav-payment',
		msg.paymentTitle,
		msg.paymentText
	);

	addStep(
		steps,
		'#tutorial-nav-coin',
		msg.coinTitle,
		msg.coinText
	);

	addStep(
		steps,
		'#tutorial-nav-store',
		msg.storeTitle,
		msg.storeText
	);

	addStep(
		steps,
		'#tutorial-nav-column',
		msg.columnTitle,
		msg.columnText
	);

	addStep(
		steps,
		'#tutorial-nav-mypage',
		msg.mypageTitle,
		msg.mypageText
	);

	if (steps.length === 0) {
		return;
	}

	const tour = typeof introJs.tour === 'function' ? introJs.tour() : introJs();

	tour.setOptions({
		steps: steps,
		nextLabel: msg.nextLabel,
		prevLabel: msg.prevLabel,
		doneLabel: msg.doneLabel,
		skipLabel: '',
		tooltipClass: 'koze-tutorial-tooltip',
		showProgress: true,
		showBullets: false,
		showStepNumbers: false,
		exitOnOverlayClick: false,
		disableInteraction: false,
		scrollToElement: true,
		tooltipPosition: 'floating'
	});

	tour.onafterchange(function() {
		fixTooltipCenterLater();
	});

	tour.onstart(function() {
		fixTooltipCenterLater();
	});

	tour.start();

	fixTooltipCenterLater();
});

function addFloatingStep(steps, title, intro) {
	steps.push({
		title: title,
		intro: intro,
		position: 'floating'
	});
}

function addStep(steps, selector, title, intro) {
	const element = document.querySelector(selector);

	if (element == null) {
		return;
	}

	steps.push({
		element: element,
		title: title,
		intro: intro,
		position: 'floating'
	});
}

function fixTooltipCenterLater() {
	setTimeout(fixTooltipCenter, 0);
	setTimeout(fixTooltipCenter, 80);
	setTimeout(fixTooltipCenter, 200);
}

function fixTooltipCenter() {
	const referenceLayer = document.querySelector('.introjs-tooltipReferenceLayer');
	const tooltip = document.querySelector('.introjs-tooltip.koze-tutorial-tooltip');

	if (referenceLayer != null) {
		referenceLayer.style.setProperty('position', 'fixed', 'important');
		referenceLayer.style.setProperty('top', '0', 'important');
		referenceLayer.style.setProperty('left', '0', 'important');
		referenceLayer.style.setProperty('right', '0', 'important');
		referenceLayer.style.setProperty('bottom', '0', 'important');
		referenceLayer.style.setProperty('width', '100vw', 'important');
		referenceLayer.style.setProperty('height', '100vh', 'important');
		referenceLayer.style.setProperty('transform', 'none', 'important');
	}

	if (tooltip != null) {
		tooltip.style.setProperty('position', 'fixed', 'important');
		tooltip.style.setProperty('top', '69%', 'important');
		tooltip.style.setProperty('left', '50%', 'important');
		tooltip.style.setProperty('right', 'auto', 'important');
		tooltip.style.setProperty('bottom', 'auto', 'important');
		tooltip.style.setProperty('transform', 'translate(-50%, -50%)', 'important');
		tooltip.style.setProperty('margin', '0', 'important');
	}
}