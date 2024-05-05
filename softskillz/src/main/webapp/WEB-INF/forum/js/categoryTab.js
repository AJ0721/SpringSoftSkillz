$(document).ready(function () {


    //CATEGORY HTML
    function createCategoryHtml(category) {
        return `
        <tr>
            <td><input type="checkbox"></td>
            <td>${category.forumCategoryId}</td>
            <td> <a href="/forum/category/detail/`+ category.forumCategoryId + `">${category.forumCategoryName}</a></td>
            <td>${category.forumCategoryDescription}</td>
            <td class="edit btn btn-primary btn-sm"><i class="fas fa-edit"></i>
            編輯
            </td>
        </tr>
    ` ;
    }

    //ACTION: FETCH ALL 
    $('#nav-category-tab').click(function (e) {
        e.preventDefault();
        $('#categoryList').empty();
        fetchCategories();
    })


    //FUCTION: FETCH ALL
    function fetchCategories() {
        console.log("Fetching categories!");
        // avoid repetitive loading when multiple clicks happen
        $('#categoryList').empty();
        $.ajax({
            url: '/forum/category/findall',
            method: 'GET',
            dataType: 'json',
            success: function (categories) {
                console.log("Categories fetched successfully:", categories);
                categories.forEach(function (category) {
                    $('#categoryList').append(`
                    ${createCategoryHtml(category)}
           
     <!--  <tr>
            <td><input type="checkbox"></td>
            <td> ${category.forumCategoryId} </td>
            <td> <a href="#detail"> ${category.forumCategoryName} </a></td>
            <td> ${category.forumCategoryDescription} </td>
           
            <td id="updateCategory"> <a href="#" class="btn btn-primary btn-sm"><i class="fas fa-edit"></i>
            編輯</a>
    
            </td>
             </tr> -->
                    `);
                });
            },
            error: function (error) {
                console.error("Error fetching categories: ", error);
            }
        });
    }


    //SELECT 'DELETE ALL CHECKBOX'
    $('#selectAllCategories').change(function () {
        $('#categoryList :checkbox').prop('checked', $(this).prop('checked'));
    });


    //SWEET ALERT
    $('#deleteSelectedCategories').click(function () {
        var selectedCheckboxes = $('#categoryList :checkbox:checked');
        if (selectedCheckboxes.length === 0) {
            Swal.fire('錯誤', '請選擇至少一筆刪除資料', 'error');
            return;
        }

        Swal.fire({
            title: '是否刪除選取資料?',
            text: '',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '確認',
            cancelButtonText: '取消'
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
                        fetchCategories(); // Refresh the category list
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
        window.location.href = '/forum/admin/category/insert'
    });

    $('#categoryList').on('click', '.edit', function () {
        var categoryId = $(this).closest('tr').find('td:nth-child(2)').text();
        window.location.href = '/forum/admin/category/update/' + categoryId;
    });


    //SEARCH BAR: INPUT
    // $('#searchInput').on('input', function () {
    //     var searchValue = $(this).val();
    //     var searchCondition = $('#searchConditionSelect').val();
    //     if (searchCondition === 'categoryKeyword') {
    //         searchCategoriesByKeyword(searchValue);
    //     }
    // });


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
        var keyword = $('#searchInput').val();
        $.ajax({
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
                    categories.forEach(function (category) {
                        $('#categoryList').empty();
                        $('#categoryList').append(`
                        ${createCategoryHtml(category)}
                     `);
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

})

