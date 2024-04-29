document.addEventListener("DOMContentLoaded", function () {
    var userDropdown = document.getElementById("userDropdown");
    var userDropdownContent = document.getElementById(
        "userDropdownContent"
    );

    userDropdown.addEventListener("click", function (event) {
        event.stopPropagation(); // 防止點擊事件向上冒泡
        toggleDropdown(userDropdownContent);
    });

    var courseDropdown = document.getElementById("courseDropdown");
    var courseDropdownContent = document.getElementById(
        "courseDropdownContent"
    );

    courseDropdown.addEventListener("click", function (event) {
        event.stopPropagation(); // 防止點擊事件向上冒泡
        toggleDropdown(courseDropdownContent);
    });

    function toggleDropdown(dropdownContent) {
        var allDropdowns = document.querySelectorAll(".dropdown-content");
        allDropdowns.forEach(function (dropdown) {
            if (dropdown !== dropdownContent) {
                dropdown.style.display = "none";
            }
        });

        if (dropdownContent.style.display === "none") {
            dropdownContent.style.display = "block";
        } else {
            dropdownContent.style.display = "none";
        }
    }

    // 點擊頁面其他地方隱藏下拉菜單
    document.addEventListener("click", function (event) {
        var dropdowns = document.querySelectorAll(".dropdown-content");
        dropdowns.forEach(function (dropdown) {
            if (dropdown.style.display === "block") {
                dropdown.style.display = "none";
            }
        });
    });
});