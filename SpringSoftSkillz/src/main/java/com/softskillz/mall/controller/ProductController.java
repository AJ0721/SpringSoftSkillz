package com.softskillz.mall.controller;

import com.softskillz.mall.model.ProductBean;
import com.softskillz.mall.model.ProductDAOInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class ProductController {

	@Autowired
	private ProductDAOInterface productDAO;

	// 新增
	@RequestMapping(value = "/InsertProduct", method = RequestMethod.POST)
	public ModelAndView insert(
//            @RequestParam("product_id") Integer productId,
//            @RequestParam("product_category_id") Integer productCategoryId,
			@RequestParam("product_name") String productName,
			@RequestParam("product_description") String productDescription,
			@RequestParam("product_price") Integer productPrice, @RequestParam("product_stock") Integer productStock,
//            @RequestParam("product_image_url") String productImageUrl,
//            @RequestParam("product_image") MultipartFile productImage, // 修改此行以接收文件
			@RequestParam("product_target_audience") String productTargetAudience,
			@RequestParam("product_create_date") String productCreateDate,
			@RequestParam("product_update_date") String productUpdateDate) {
		ModelAndView view = new ModelAndView("Mall/MallInsert/insertOK");
		try {
			ProductBean productBean = new ProductBean();
			// 假設您將文件保存在某處並獲得URL
//            String productImageUrl = saveUploadedFile(productImage); // 實現此方法以保存文件並返回URL
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate createDate = LocalDate.parse(productCreateDate, formatter);
			LocalDate updateDate = LocalDate.parse(productUpdateDate, formatter);

//            productBean.setProductId(productId);
			productBean.setProductCategoryId(1);
			productBean.setProductName(productName);
			productBean.setProductDescription(productDescription);
			productBean.setProductPrice(productPrice);
			productBean.setProductStock(productStock);
//            productBean.setProductImageUrl(productImageUrl);
			productBean.setProductTargetAudience(productTargetAudience);
			productBean.setProductCreateDate(createDate.toString()); // 儲存格式化後的日期
			productBean.setProductUpdateDate(updateDate.toString()); // 儲存格式化後的日期
			productDAO.insert(productBean);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

	// 刪除單筆id
	@RequestMapping(value = "/DeleteProductById", method = RequestMethod.POST)
	public ModelAndView deleteProductById(@RequestParam("product_id") Integer productId) {
		ModelAndView view = new ModelAndView("Mall/MallDelete/delete");
		try {
			productDAO.deleteOne(productId);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

	// 查詢欲修改學伴 單筆 id
	@RequestMapping(value = "/GetUpdateDataP", method = RequestMethod.POST)
	public ModelAndView getUpdateData(@RequestParam("product_id") Integer productId) {
		ModelAndView view = new ModelAndView("Mall/MallUpdate/updateData");
		try {
			ProductBean product = productDAO.selectById(productId);
			view.addObject("product", product);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

	// 修改單筆 抓id
	@RequestMapping(value = "/Updateproduct", method = RequestMethod.POST)
    public ModelAndView update(
            @RequestParam("product_id") Integer productId,
            @RequestParam("product_category_id") Integer productCategoryId,
            @RequestParam("product_name") String productName,
            @RequestParam("product_description") String productDescription,
            @RequestParam("product_price") Integer productPrice,
            @RequestParam(value = "product_stock", required = false) Integer productStock,
            @RequestParam("product_photo") String productImageUrl,
            @RequestParam("product_target_audience") String productTargetAudience,
            @RequestParam("product_create_date") String productCreateDate,
            @RequestParam("product_update_date") String productUpdateDate) {
        ModelAndView view = new ModelAndView("Mall/MallUpdate/update");
        try {
            ProductBean productBean = new ProductBean();
            String createDate = productCreateDate;
            String updateDate = productUpdateDate;
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate newCreateDate = LocalDate.parse(createDate, formatter);
            LocalDate newUpdateDate = LocalDate.parse(updateDate, formatter);

            productBean.setProductId(productId);
            productBean.setProductCategoryId(productCategoryId);
            productBean.setProductName(productName);
            productBean.setProductDescription(productDescription);
            productBean.setProductPrice(productPrice);
            productBean.setProductStock(productStock);
            productBean.setProductImageUrl(productImageUrl);
            productBean.setProductTargetAudience(productTargetAudience);
            productBean.setProductCreateDate(productCreateDate);
            productBean.setProductUpdateDate(productUpdateDate);
            productDAO.updateOne(productBean);
        } catch (Exception e) {
            e.printStackTrace();
            view.addObject("errorMessage", "An error occurred: " + e.getMessage());
        }
        return view;
    }

	// 查詢單筆id
	@RequestMapping(value = "/GetProductById", method = RequestMethod.POST)
	public ModelAndView getProductById(@RequestParam("product_id") Integer productId) {
		ModelAndView view = new ModelAndView("Mall/MallSelect/selectById");
		try {
			ProductBean product = productDAO.selectById(productId);
			view.addObject("product", product);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

	// 查詢單筆product_name
	@RequestMapping(value = "/GetProductByName", method = RequestMethod.POST)
	public ModelAndView getProductByName(@RequestParam("product_name") String productName) {
		ModelAndView view = new ModelAndView("Mall/MallSelect/selectByName");
		try {
			ProductBean product = productDAO.selectByName(productName);
			view.addObject("product", product);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

	// 查詢全部
	@RequestMapping(value = "/GetAllProducts", method = RequestMethod.POST)
	public ModelAndView getAllProducts() {
		ModelAndView view = new ModelAndView("Mall/MallSelect/GetAllProducts");
		try {
			List<ProductBean> products = productDAO.selectAll();
			System.out.println(products);
			view.addObject("products", products);
		} catch (Exception e) {
			e.printStackTrace();
			view.addObject("errorMessage", "An error occurred: " + e.getMessage());
		}
		return view;
	}

}