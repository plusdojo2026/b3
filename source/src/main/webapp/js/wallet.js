'use strict'
//登録ボタン　空白がある場合処理を中断
document.getElementById('editBtn').onclick = function(event) {
	
	
	const WLs=[
	'tenThousandYen',
	'fiveThousandYen',
	'oneThousandYen',
	'fiveHundredYen',
	'oneHundredYen',
	'fiftyYen',
	'tenYen',
	'fiveYen',
	'oneYen'];
	
	for(let id of WLs){
		if(document.getElementById(id).value === ''){
			document.getElementById('msg').textContent = '※枚数を入力してください。';
			event.preventDefault();
			return;
		}
	}
	document.getElementById('output').textContent ='登録しました。';
};



 