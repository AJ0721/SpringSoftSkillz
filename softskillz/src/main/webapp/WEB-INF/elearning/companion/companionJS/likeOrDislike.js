document.addEventListener('DOMContentLoaded', function() {
	// 取得like表單和按鈕
	const likeForm = document.getElementById('likeForm');

	// 監聽like表單提交事件
	likeForm.addEventListener('submit', function(event) {
		alert('已申請配對'); // 顯示提示訊息

	});

	// 取得dislike表單和按鈕
	const dislikeForm = document.getElementById('dislikeForm');

	// 監聽dislike表單提交事件
	dislikeForm.addEventListener('submit', function(event) {
		alert('已隱藏學伴'); // 顯示提示訊息
	});
});
