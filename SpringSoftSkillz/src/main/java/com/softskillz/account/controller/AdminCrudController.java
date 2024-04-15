package com.softskillz.account.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.mysql.cj.callback.UsernameCallback;
import com.softskillz.account.model.AdminBean;
import com.softskillz.account.model.AdminService;

@Controller
public class AdminCrudController {

	@Autowired
	private AdminService adminService;

	// 登入
	// 網址頁登入一定要用get方法
	@RequestMapping(path = { "/admin-loginPage" }, method = RequestMethod.GET)
	public String processLoginAction() {
		System.out.println("aaaa");
		return "account/homepage/AdminLogin_back";
	}

	// post沒辦法在網址頁輸入
	@PostMapping("/admin-login")
	public String loginAction(@RequestParam("adminAccount") String adminAccount,
			@RequestParam("adminPassword") String adminPassword, Model model) {
//		Map<String, String> errMsg = new HashMap<>();

//		if (adminAccount == null || adminAccount.isEmpty()) {
//			System.out.println("vvvvadf");
//			errMsg.put("errMsg", "請輸入帳號");
//			model.addAttribute("errMsg","請輸入帳號");
//		}
//		if (adminPassword == null || adminPassword.isEmpty()) {
//			errMsg.put("errMsg", "請輸入密碼");
//			model.addAttribute("errMsg", errMsg);
//		}
//		if (!errMsg.isEmpty()) {
//			model.addAttribute("errMsg", errMsg);
//			return "account/homepage/AdminLogin_back"; // 錯誤，重新返回登入頁面
//		}

		boolean result = adminService.checkLogin(new AdminBean(adminAccount, adminPassword));
		if (result) {
			model.addAttribute("adminAccount", adminAccount);
			return "redirect:softskillz.homepage"; // 驗證成功，重定向到首頁
		} else {
//			errMsg.put("loginError", "請輸入正確的帳號密碼");
			model.addAttribute("errMsg", "請輸入正確的帳號密碼");

		}
		return "account/homepage/AdminLogin_back"; // 錯誤，重新返回登入頁面
	}

	// 管理員頁面
	@RequestMapping(path = { "/admin-account" }, method = RequestMethod.GET)
	public String goToAccountPage() {
		return "account/homepage/AdminHomepageCRUD";
	}

	// 新增
	@PostMapping("/admin")
	public String processInsertAction(@RequestParam("adminAccount") String adminAccount,
			@RequestParam("adminPassword") String adminPassword,
			@RequestParam(value = "adminLevel", required = false) Integer adminLevel) {
		AdminBean insertBean = new AdminBean(adminAccount, adminPassword, adminLevel);
		adminService.insert(insertBean);
		return "account/homepage/AdminLogin_back";
	}

	// 查詢用GetMapping
	@PostMapping("/AdminSelectOne")
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
		return "account/homepage/AdminHomepageCRUD";

	}

	// 查詢全部
	@PostMapping("/AdminSelectAll")
	public String processFindAllAction(Model m) {
		List<AdminBean> admin = adminService.findAll();
		m.addAttribute("admin", admin);

		return "account/homepage/AdminHomepageCRUD";

	}

//	// 更新
//	//.jsp用網址方法一定要用@GetMapping
//	@GetMapping("/AdminUpdate")
//	public String processUpdateAction(@RequestParam("adminId") Integer adminId,
//			@RequestParam("adminAccount") String adminAccount, @RequestParam("adminPassword") String adminPassword,
//			@RequestParam(value = "adminLevel", required = false) Integer adminLevel) {
//		AdminBean updateBean = new AdminBean(adminId, adminAccount, adminPassword, adminLevel);
//		adminService.update(updateBean);
//		return "已更新資料";
//	}
//	
	// 更新
	// .jsp用網址方法一定要用@GetMapping
//	@GetMapping("/AdminUpdate")
//	public String processUpdateAction(@RequestParam("adminId") Integer adminId,
//			@RequestParam("adminAccount") String adminAccount, @RequestParam("adminPassword") String adminPassword,
//			@RequestParam(value = "adminLevel", required = false) Integer adminLevel) {
//		AdminBean updateBean = new AdminBean(adminId, adminAccount, adminPassword, adminLevel);
//		adminService.update(updateBean);
//		return "已更新資料";
//	}

	@GetMapping("/AdminUpdate")
	public String processUpdateAction(@RequestParam("adminId") Integer adminId,
			@RequestParam("adminLevel") Integer adminLevel, Model m) {
		AdminBean updateBean = new AdminBean();
		
		adminService.update(adminId, adminLevel);
		
		m.addAttribute("rowMsg", "已更新層級");
		
		return "account/homepage/AdminHomepageCRUD";
	}

	// 刪除
	@GetMapping("/AdminDelete")
	public String processDeleteAction(@RequestParam("adminId") Integer adminId, Model m) {
		boolean deleteStatus = adminService.deleteById(adminId);

		if (deleteStatus) {
			m.addAttribute("rowMsg", "已刪除一筆資料");
		}

		return "account/homepage/AdminHomepageCRUD";

	}

}
