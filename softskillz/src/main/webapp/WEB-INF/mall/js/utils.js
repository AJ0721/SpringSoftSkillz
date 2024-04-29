
// 顯示錯誤訊息
function showError(message) {
    alert(`錯誤: ${message}`);
}

// 將日期時間格式化為字符串
function formatDateTime(dateTime) {
    return new Date(dateTime).toLocaleString();
}

// 獲取 URL 參數值
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}
