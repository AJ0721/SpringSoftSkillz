// GLOBAL FUNCTION: SHOW TABS IN HOMEPAGE WHEN REDIRECT


//FUNCTION: FETCH ALL CATEGORIES (returns a jQuery promise)
window.fetchCategories = function () {
    return $.ajax({
        url: '/forum/category/findall',
        method: 'GET',
        dataType: 'json',
    });
};


//CATEGORY HTML
window.createCategoryHtml = function (category) {
    return `
        <tr>
            <td><input type="checkbox"></td>
            <td>${category.forumCategoryId}</td>
            <td><a href="/forum/category/detailpage/${category.forumCategoryId}">${category.forumCategoryName}</a></td>
            <td>${category.forumCategoryDescription}</td>
            <td class="edit btn btn-sm icon btn-primary"><i class="bi bi-pencil"></i></td>
            
        </tr>
    `;
};

//FUNCTION: DISPLAY CATEGORY IN TAB 
window.displayCategoriesTab = function (categories) {
    var $categoryList = $('#categoryList');
    $categoryList.empty();
    categories.forEach(function (category) {
        $categoryList.append(`${createCategoryHtml(category)}`);
    })

}


$(document).ready(function () {

    //ACTION: FETCH ALL 
    $('#nav-category-tab').click(function (e) {
        e.preventDefault();
        $('#categoryList').empty();
        fetchCategories();
    })


    //SELECT 'DELETE ALL CHECKBOX'
    $('#selectAllCategories').change(function () {
        $('#categoryList :checkbox').prop('checked', $(this).prop('checked'));
    });


    //SWEET ALERT
    $('#deleteSelectedCategories').click(function () {
        var selectedCheckboxes = $('#categoryList :checkbox:checked');
        if (selectedCheckboxes.length === 0) {
            Swal.fire('請先選取資料再操作', '', 'error');
            return;
        }

        Swal.fire({
            title: '是否刪除選取資料?',
            text: '',
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: '取消',
            confirmButtonText: '確認'
        }).then((result) => {

            if (result.isConfirmed) {

                var categoryIds = [];
                selectedCheckboxes.each(function () {
                    var categoryId = $(this).closest('tr').find('td:nth-child(2)').text();
                    categoryIds.push(categoryId);
                });

                $.ajax({
                    url: '/forum/category/deleteall',
                    type: 'DELETE',
                    data: JSON.stringify({ forumCategoryIds: categoryIds }),
                    contentType: 'application/json',
                    success: function (response) {
                        Swal.fire('刪除成功', '', 'success');
                        $('#categoryList').empty();
                        console.log('emptied');
                        fetchCategories().done(function (categories) { //jquery syntax: done/fail 
                            console.log('fetched');
                            displayCategoriesTab(categories);
                            console.log('displayed');
                        }).fail(function (error) {
                            console.error("Error fetching categories:", error);
                            $('#categoryList').html('<tr><td colspan="5">資料載入失敗，請重新整理。</td></tr>');
                        });


                    },
                    error: function (xhr, status, error) {
                        Swal.fire('刪除失敗', '請重新整理' + error, 'error');
                    }
                });
            }
        });
    });


    //PAGE REDIRECT
    $('#createNewCategory').click(function (e) {
        e.preventDefault();
        window.location.href = '/forum/category/insertpage'
    });

    $('#categoryList').on('click', '.edit', function () {
        var categoryId = $(this).closest('tr').find('td:nth-child(2)').text();
        window.location.href = '/forum/category/updatepage/' + categoryId;
    });


    //SEARCH BAR: CLICK
    $('#searchbtn').on('click', function () {
        var searchValue = $(this).val();
        var searchCondition = $('#searchConditionSelect').val();
        if (searchCondition === 'categoryId') {
            searchCategoriesById(searchValue);
        } else if (searchCondition === 'categoryKeyword') {
            searchCategoriesByKeyword(searchValue);
        }
    });



    // FUNCTION: SEARCH BAR (KEYWORD/ID)
    function searchCategoriesByKeyword() {
        var keyword = $('#searchInput').val().trim();

        if (!keyword) {
            $('#categoryList').html('<tr><td colspan="13">請輸入搜索關鍵字。</td></tr>');
            return;
        } $.ajax({
            url: '/forum/category/search',
            method: 'GET',
            data: { keyword: keyword },
            dataType: 'json',
            success: function (categories) {
                if (categories.length === 0) {
                    $('#categoryList').empty();
                    $('#categoryList').append(`
                    <tr><td colspan="5">查無資訊，請重新輸入</td></tr>
                    `);
                } else {
                    $('#categoryList').empty();
                    categories.forEach(function (category) {
                        $('#categoryList').append(createCategoryHtml(category));
                    });
                }
            },
            error: function (error) {
                console.error('Error searching categories:', error);
            }
        });
    }
    function searchCategoriesById() {
        var categoryId = $('#searchInput').val();
        $.ajax({
            url: '/forum/category/find/id/' + categoryId,
            method: 'GET',
            dataType: 'json',
            success: function (category) {
                $('#categoryList').empty();
                $('#categoryList').append(`
                ${createCategoryHtml(category)}
                        `);
            },
            error: function (error) {
                $('#categoryList').empty();
                $('#categoryList').append(`
                <tr><td colspan="5">查無資訊，請重新輸入</td></tr>
             `);
                console.error('Error searching category by ID:', error);
            }
        });
    }

    //ACTION:DISPLAY CATEGORY IN TAB WHEN LOAD
    $('#nav-category-tab').click(function (e) {
        e.preventDefault();

        fetchCategories().done(function (categories) {
            displayCategoriesTab(categories);
        }).fail(function (error) {
            console.error("Error fetching categories:", error);
            $('#categoryList').html('<tr><td colspan="5">載入資料失敗，請重新整理</td></tr>');
        });


    });


})