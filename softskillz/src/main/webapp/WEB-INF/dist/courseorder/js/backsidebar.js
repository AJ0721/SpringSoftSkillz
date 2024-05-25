function sidebar() {
  return `     
  <div id="sidebar">
  <div class="sidebar-wrapper active">
    <div class="sidebar-header position-relative">
      <div class="d-flex justify-content-between align-items-center">
        <!-- 左上角Logo -->
        <div class="logo">
          <a href="/softskillz/newhomepage"
            ><img
              src="/assets/compiled/jpg/logo1.jpg"
              alt="Logo"
              srcset=""
          /></a>
        </div>
        <!-- 切換日間夜間模式 -->
        <div class="theme-toggle d-flex gap-2 align-items-center mt-2">
          <!-- 日間模式圖片 -->
          <svg
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            aria-hidden="true"
            role="img"
            class="iconify iconify--system-uicons"
            width="20"
            height="20"
            preserveAspectRatio="xMidYMid meet"
            viewBox="0 0 21 21"
          >
            <g
              fill="none"
              fill-rule="evenodd"
              stroke="currentColor"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path
                d="M10.5 14.5c2.219 0 4-1.763 4-3.982a4.003 4.003 0 0 0-4-4.018c-2.219 0-4 1.781-4 4c0 2.219 1.781 4 4 4zM4.136 4.136L5.55 5.55m9.9 9.9l1.414 1.414M1.5 10.5h2m14 0h2M4.135 16.863L5.55 15.45m9.899-9.9l1.414-1.415M10.5 19.5v-2m0-14v-2"
                opacity=".3"
              ></path>
              <g transform="translate(-210 -1)">
                <path d="M220.5 2.5v2m6.5.5l-1.5 1.5"></path>
                <circle cx="220.5" cy="11.5" r="4"></circle>
                <path
                  d="m214 5l1.5 1.5m5 14v-2m6.5-.5l-1.5-1.5M214 18l1.5-1.5m-4-5h2m14 0h2"
                ></path>
              </g>
            </g>
          </svg>
          <!-- 切換按鈕 -->
          <div class="form-check form-switch fs-6">
            <input
              class="form-check-input me-0"
              type="checkbox"
              id="toggle-dark"
              style="cursor: pointer"
            />
            <label class="form-check-label"></label>
          </div>
          <!-- 夜間模式圖片 -->
          <svg
            xmlns="http://www.w3.org/2000/svg"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            aria-hidden="true"
            role="img"
            class="iconify iconify--mdi"
            width="20"
            height="20"
            preserveAspectRatio="xMidYMid meet"
            viewBox="0 0 24 24"
          >
            <path
              fill="currentColor"
              d="m17.75 4.09l-2.53 1.94l.91 3.06l-2.63-1.81l-2.63 1.81l.91-3.06l-2.53-1.94L12.44 4l1.06-3l1.06 3l3.19.09m3.5 6.91l-1.64 1.25l.59 1.98l-1.7-1.17l-1.7 1.17l.59-1.98L15.75 11l2.06-.05L18.5 9l.69 1.95l2.06.05m-2.28 4.95c.83-.08 1.72 1.1 1.19 1.85c-.32.45-.66.87-1.08 1.27C15.17 23 8.84 23 4.94 19.07c-3.91-3.9-3.91-10.24 0-14.14c.4-.4.82-.76 1.27-1.08c.75-.53 1.93.36 1.85 1.19c-.27 2.86.69 5.83 2.89 8.02a9.96 9.96 0 0 0 8.02 2.89m-1.64 2.02a12.08 12.08 0 0 1-7.8-3.47c-2.17-2.19-3.33-5-3.49-7.82c-2.81 3.14-2.7 7.96.31 10.98c3.02 3.01 7.84 3.12 10.98.31Z"
            ></path>
          </svg>
        </div>
        <div class="sidebar-toggler x">
          <a href="#" class="sidebar-hide d-xl-none d-block"
            ><i class="bi bi-x bi-middle"></i
          ></a>
        </div>
      </div>
    </div>
    <!-- 側邊欄 -->
    <div class="sidebar-menu">
      <ul class="menu">
        <li class="sidebar-item active">
          <a href="/softskillz/newhomepage" class="sidebar-link">
            <i class="bi bi-grid-fill"></i>
            <span>首頁</span>
          </a>
        </li>
        <li class="sidebar-title">用戶管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>管理員</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/admin/admin-account" class="submenu-link"
                >管理員帳號</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>教師</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/teacher/teacher-account" class="submenu-link"
                >教師帳號</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>學生</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/student/student-account" class="submenu-link"
                >學生帳號</a
              >
            </li>
          </ul>
        </li>

        <li class="sidebar-title">課程管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>課程</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/course/insertPage" class="submenu-link"
                >新增課程</a
              >
            </li>
            <li class="submenu-item">
              <a href="/course/selectAllPage" class="submenu-link"
                >查詢課程</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>教師行事曆</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/teacherSchedule/insertPage" class="submenu-link"
                >新增教師行事曆</a
              >
            </li>
            <li class="submenu-item">
              <a
                href="/teacherSchedule/selectAllPage"
                class="submenu-link"
                >查詢教師行事曆</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>學生預約</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a
                href="/studentReservation/insertPage"
                class="submenu-link"
                >新增學生預約</a
              >
            </li>
            <li class="submenu-item">
              <a
                href="/studentReservation/selectAllPage"
                class="submenu-link"
                >查詢學生預約</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>學生行事曆</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a
                href="/studentSchedule/selectAllPage"
                class="submenu-link"
                >查詢學生行事曆</a
              >
            </li>
          </ul>
        </li>

        <li class="sidebar-title">課程訂單管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>課程訂單管理</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/adminorder/adorder.do" class="submenu-link"
                >課程訂單管理</a
              >
            </li>
            <li class="submenu-item">
              <a href="/coursediscount/discount.do" class="submenu-link"
                >課程折扣管理</a
              >
            </li>
          </ul>
        </li>

        <li class="sidebar-title">商品管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>商品管理</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/mall/backend" class="submenu-link">商品管理</a>
            </li>
          </ul>
        </li>
        <li class="sidebar-title">商品訂單管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>商品訂單管理</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/order/all" class="submenu-link">商品訂單管理</a>
            </li>
            <li class="submenu-item">
              <a href="/order/createPage" class="submenu-link"
                >新增商品訂單</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-title">學伴資料管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>學伴資料管理</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/companionIndex" class="submenu-link"
                >學伴資料管理</a
              >
            </li>
          </ul>
        </li>
        <li class="sidebar-title">論壇管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>論壇管理</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/forum/adminhome" class="submenu-link">論壇管理</a>
            </li>
          </ul>
        </li>

        <li class="sidebar-title">訊息管理</li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-grid-1x2-fill"></i>
            <span>訊息管理</span>
          </a>
          <ul class="submenu">
            <li class="submenu-item">
              <a href="/chat/coursechat.do" class="submenu-link"
                >訊息管理</a
              >
            </li>
          </ul>
        </li>

        <br />
        <form
          action="/admin/admin-logout"
          method="post"
          style="text-align: center; margin: 0 auto"
        >
          <button
            type="submit"
            class="btn rounded-pill"
            style="
              background-color: #3f6cba;
              color: white;
              font-size: 20px;
            "
          >
            <i class="bi bi-person-circle"></i>&nbsp;登出
          </button>
        </form>
      </ul>
    </div>
  </div>
</div>`
}

document.querySelector("#app").innerHTML = sidebar();