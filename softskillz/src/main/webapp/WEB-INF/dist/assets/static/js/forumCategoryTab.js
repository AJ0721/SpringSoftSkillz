
$(document).ready(function () {

    //ACTION: FETCH ALL 
    $('#nav-category-tab').click(function (e) {
        e.preventDefault();
        $('#categoryList').empty();
        fetchCategories()
            .then(categories => displayCategoriesTab(categories))
            .catch(function (error) {
                console.error("Error fetching categories:", error);
                $('#categoryList').html('<tr><td colspan="5">資料載入失敗，請重新整理。</td></tr>');
            });
    })


    //SELECT 'DELETE ALL CHECKBOX'
    $('#selectAllCategories').change(function () {
        $('#categoryList :checkbox').prop('checked', $(this).prop('checked'));
    });


    //BULK DELETE ACTION
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


                fetch('/forum/category/delete-all', {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(categoryIds)
                })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok ' + response.statusText);
                        }
                        return response.text();
                    })
                    .then(data => {
                        console.log(data);
                        Swal.fire("刪除成功", "", "success");
                        $('#categoryList').empty();
                        fetchCategories()
                            .then(function (categories) {
                                displayCategoriesTab(categories);
                            })
                            .catch(
                                function (error) {
                                    console.error("Error fetching categories:", error);
                                    $('#categoryList').html('<tr><td colspan="5">資料載入失敗，請重新整理。</td></tr>');
                                }
                            )
                    }
                    ).catch(error => {
                        console.error('There was a problem with the fetch operation:', error);
                        Swal.fire('刪除失敗', '請檢查連線並重新整理', 'error');
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




})