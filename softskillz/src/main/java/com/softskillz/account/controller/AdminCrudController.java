package com.softskillz.account.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.service.AdminService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminCrudController {

	@Autowired
	private AdminService adminService;

	// 登入
	// 網址頁登入一定要用get方法
	@GetMapping("/admin-loginPage")
	public String processLoginAction() {
		return "/dist/account/admin/AdminLoginBack.jsp";
	}

	// 登出功能
	@PostMapping("/admin-logout")
	public String logoutAction(HttpServletRequest request) {
		HttpSession session = request.getSession(false); // 獲取當前會話，不創建新會話
		if (session != null) {
			session.invalidate(); // 使會話失效
		}
		return "redirect:/admin/admin-loginPage"; // 重定向到登入頁面
	}

	// 管理員登入，post沒辦法在網址頁輸入
	@PostMapping("/admin-login")
	public String loginAction(@RequestParam("adminAccount") String adminAccount,
			@RequestParam("adminPassword") String adminPassword, HttpSession session, Model model) {

		AdminBean adminData = adminService.checkLogin(new AdminBean(adminAccount, adminPassword));

		if (adminData != null) {
			session.setAttribute("adminData", adminData);
			return "/dist/index.html"; // 驗證成功，重定向到首頁
		} else {
			model.addAttribute("errMsg", "請輸入正確的帳號密碼");
		}
		return "/dist/account/admin/AdminLoginBack.jsp"; // 錯誤，重新返回登入頁面
	}

	// 管理員頁面
	@GetMapping("/admin-account")
	public String goToAccountPage() {
		return "/dist/account/admin/adminCrudPage.jsp";
	}

	// 註冊頁面
	@GetMapping("/admin-createPage")
	public String goToAdminCreatePage() {
		return "/dist/account/admin/AdminCreate.jsp";
	}

	// 新增
	@PostMapping("/admin-create")
	public String processInsertAction(@RequestParam("adminAccount") String adminAccount,
			@RequestParam("adminPassword") String adminPassword,
			@RequestParam(value = "adminLevel", required = false) Integer adminLevel, Model model) {
		AdminBean insertBean = new AdminBean(adminAccount, adminPassword, adminLevel);

		AdminBean result = adminService.insert(insertBean);

		if (result == null) {
			model.addAttribute("errMsg", "該帳號已被使用");

		} else {
			model.addAttribute("errMsg", "帳號創建成功");
		}
		return "/dist/account/admin/AdminLoginBack.jsp";
	}

	// 查詢用GetMapping
	@GetMapping("/AdminSelectOne")
	// @ResponseBody傳出json格式
	// @PathVariable("adminId")要跟{adminId}一樣才找得到輸入的值
	public String processQueryById(@RequestParam("admin_id") Integer adminId, Model model) {
		AdminBean resultBean = adminService.findById(adminId);

		if (resultBean != null) {
			// forEach只能跑集合
			List<AdminBean> admin = new ArrayList();
			admin.add(resultBean);
			model.addAttribute("admin", admin);

		} else {
			model.addAttribute("rowMsg", "找不到此id");

		}

		System.out.println(resultBean);
		return "/dist/account/admin/adminCrudPage.jsp";

	}

	// 查詢全部
	@GetMapping("/AdminSelectAll")
	public String processFindAllAction(Model m, HttpServletRequest request) {
		List<AdminBean> admin = adminService.getAll();
		System.out.println(admin);
		m.addAttribute("admin", admin);

		int pageSize = 10; // 設置每頁顯示的數量
		Pageable pageable = PageRequest.of(0, pageSize); // 創建分頁請求，從0開始(所以如果從第一頁，要減一才會從零開始)
		Page<AdminBean> page = adminService.findAllByPage(pageable); // 調用服務層方法，返回分頁數據

		request.getSession().setAttribute("totalElements", page.getTotalElements());
		request.getSession().setAttribute("totalPages", page.getTotalPages()); // 從Page對象獲取總頁數

		return "/dist/account/admin/adminCrudPage.jsp";
	}

	@GetMapping("/AdminQueryByPage/{pageNo}")
	@ResponseBody
	public List<AdminBean> AdminQueryByPage(@PathVariable("pageNo") int pageNo, Model model,
			HttpServletRequest request) {
		int pageSize = 10; // 設置每頁顯示的數量
		Pageable pageable = PageRequest.of(pageNo - 1, pageSize); // 創建分頁請求，從0開始(所以如果從第一頁，要減一才會從零開始)
		Page<AdminBean> page = adminService.findAllByPage(pageable); // 調用服務層方法，返回分頁數據

		return page.getContent();

	}

	@PutMapping("/AdminUpdate")
	public String processUpdateAction(@RequestParam("adminId") Integer adminId,
			@RequestParam("adminLevel") Integer adminLevel, Model m) {

		AdminBean updateBean = new AdminBean();

		adminService.updateLevel(adminId, adminLevel);

		// 把東西丟到頁面
		m.addAttribute("rowMsg", "已更新層級");

		return "redirect:/admin/admin-account";
	}

	// 刪除
	@DeleteMapping("/AdminDelete")
	public String processDeleteAction(@RequestParam("adminId") Integer adminId, Model m) {
		boolean deleteStatus = adminService.deleteById(adminId);

		if (deleteStatus) {
			m.addAttribute("rowMsg", "已刪除一筆資料");
		}

//		return "account/admin/AdminHomepageCRUD.jsp";
		return "redirect:/admin/admin-account";

	}

}
