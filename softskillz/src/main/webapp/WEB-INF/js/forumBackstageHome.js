
$(document).ready(function () {
    fetchCategories();

    function fetchCategories() {
        console.log("Fetching categories!");
        $.ajax({
            url: '/forum/category/findall',  // Updated URL to match your controller mapping
            method: 'GET',
            dataType: 'json',
            success: function (categories) {
                console.log("Categories fetched successfully:", categories);
                categories.forEach(function (category) {
                    $('#categoryList').append(`
                        <tr>
                            <td>${category.forumCategoryId}</td>
                            <td>${category.forumCategoryName}</td>
                            <td>${category.forumCategoryDescription}</td>
                        </tr>
                    `);
                });
            },
            error: function (error) {
                console.error("Error fetching categories: ", error);
            }
        });
    }
});
