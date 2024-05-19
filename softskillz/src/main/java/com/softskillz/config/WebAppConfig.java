package com.softskillz.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.thymeleaf.spring6.SpringTemplateEngine;
import org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver;
import org.thymeleaf.spring6.view.ThymeleafViewResolver;

//相當於 mvc-servlet.xml的java程式組太
@Configuration
public class WebAppConfig implements WebMvcConfigurer {

	@Autowired
	WebApplicationContext webApplicationContext;

	@Bean
	public SpringResourceTemplateResolver thymeleafTemplateResolver() {
		SpringResourceTemplateResolver templateResolver = new SpringResourceTemplateResolver();
		templateResolver.setApplicationContext(webApplicationContext);
		templateResolver.setOrder(9);
		templateResolver.setPrefix("/WEB-INF/");
		templateResolver.setSuffix("");
		templateResolver.setCacheable(false);
		return templateResolver;
	}

	@Bean
	public SpringTemplateEngine templateEngine() {
		SpringTemplateEngine springTemplateEngine = new SpringTemplateEngine();
		springTemplateEngine.setTemplateResolver(thymeleafTemplateResolver());
		springTemplateEngine.setEnableSpringELCompiler(true);
		return springTemplateEngine;
	}

	@Bean
	public ThymeleafViewResolver thymeleafViewResolver() {
		final ThymeleafViewResolver viewResolver = new ThymeleafViewResolver();
		viewResolver.setViewNames(new String[] { "*.html" });
		viewResolver.setExcludedViewNames(new String[] { "*.jsp" });
		viewResolver.setTemplateEngine(templateEngine());
		viewResolver.setCharacterEncoding("UTF-8");
		return viewResolver;
	}

	@Bean
	public InternalResourceViewResolver jspViewResolver() {
		final InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setOrder(10);
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/");
		viewResolver.setSuffix("");
		viewResolver.setViewNames("*.jsp");
		return viewResolver;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		// 網頁串到模版之後這邊都要刪掉喔
		registry.addResourceHandler("/courseorder/css/**").addResourceLocations("/WEB-INF/courseorder/css/");
		registry.addResourceHandler("/courseorder/js/**").addResourceLocations("/WEB-INF/courseorder/js/");
		registry.addResourceHandler("/courseorder/html/**").addResourceLocations("/WEB-INF/courseorder/html/");
		registry.addResourceHandler("/courseorder/admin/**").addResourceLocations("/WEB-INF/courseorder/admin/");

		registry.addResourceHandler("/Companion/CompanionImg/**")
				.addResourceLocations("/WEB-INF/companion/jsp/Companion/CompanionImg/");

		registry.addResourceHandler("/html/**").addResourceLocations("/WEB-INF/html/");
		registry.addResourceHandler("/forum/js/**").addResourceLocations("/WEB-INF/forum/js/");
		registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/account/images/");
		registry.addResourceHandler("/mall/css/**").addResourceLocations("/WEB-INF/mall/css/");
		registry.addResourceHandler("/mall/js/**").addResourceLocations("/WEB-INF/mall/js/");
		registry.addResourceHandler("/mall/img/**").addResourceLocations("/WEB-INF/mall/img/");
		registry.addResourceHandler("/mall/html/**").addResourceLocations("/WEB-INF/mall/html/");
		registry.addResourceHandler("/mall/jsp/**").addResourceLocations("/WEB-INF/mall/jsp/");

		// 後台模版html
		registry.addResourceHandler("/dist/**").addResourceLocations("/WEB-INF/dist/");

		// 後台模版css
		registry.addResourceHandler("/assets/compiled/css/**")
				.addResourceLocations("/WEB-INF/dist/assets/compiled/css/");
		// 後台 Data Tables css
		registry.addResourceHandler("/assets/extensions/datatables.net-bs5/css/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/datatables.net-bs5/css/");
		// 後台 Date Picker
		registry.addResourceHandler("/assets/extensions/flatpickr/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/flatpickr/");

		registry.addResourceHandler("/assets/extensions/simple-datatables/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/simple-datatables/");

		// 後台模版js
		registry.addResourceHandler("/assets/static/js/**").addResourceLocations("/WEB-INF/dist/assets/static/js/");

		registry.addResourceHandler("/assets/static/js/components/**")
				.addResourceLocations("/WEB-INF/dist/assets/static/js/components/");

		registry.addResourceHandler("/assets/static/js/**").addResourceLocations("/WEB-INF/dist/assets/static/js/");

		registry.addResourceHandler("/assets/static/js/pages/**")
				.addResourceLocations("/WEB-INF/dist/assets/static/js/pages/");

		registry.addResourceHandler("/assets/extensions/perfect-scrollbar/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/perfect-scrollbar/");

		registry.addResourceHandler("/assets/extensions/sweetalert2/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/sweetalert2/");

		registry.addResourceHandler("/assets/extensions/apexcharts/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/apexcharts/");

		registry.addResourceHandler("/assets/extensions/jquery/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/jquery/");

		registry.addResourceHandler("/assets/extensions/datatables.net/js/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/datatables.net/js/");

		registry.addResourceHandler("/assets/extensions/datatables.net-bs5/js/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/datatables.net-bs5/js/");

		registry.addResourceHandler("/assets/extensions/simple-datatables/umd/js/**")
				.addResourceLocations("/WEB-INF/dist/assets/extensions/simple-datatables/umd/js/");

		registry.addResourceHandler("/assets/compiled/js/**").addResourceLocations("/WEB-INF/dist/assets/compiled/js/");

		// 後台模版jpg
		registry.addResourceHandler("/assets/compiled/jpg/**")
				.addResourceLocations("/WEB-INF/dist/assets/compiled/jpg/");
		// 後台模版svg
		registry.addResourceHandler("/assets/static/images/**")
				.addResourceLocations("/WEB-INF/dist/assets/static/images/");
		registry.addResourceHandler("/assets/compiled/svg/**")
				.addResourceLocations("/WEB-INF/dist/assets/compiled/svg/");

		// account圖片
		registry.addResourceHandler("/account/images/**")
				.addResourceLocations("file:src/main/webapp/WEB-INF/dist/account/images/");

		// 教師照片
		registry.addResourceHandler("/teacher/images/**")
				.addResourceLocations("file:src/main/webapp/WEB-INF/dist/account/teacher/images/");

		// 前台模版html
		registry.addResourceHandler("/elearning/**").addResourceLocations("/WEB-INF/elearning/");

		// 前台模版 Img
		registry.addResourceHandler("/img/**").addResourceLocations("/WEB-INF/elearning/img/");

		// 前台模版 Libraries Stylesheet
		registry.addResourceHandler("/lib/animate/**").addResourceLocations("/WEB-INF/elearning/lib/animate/");
		registry.addResourceHandler("/lib/owlcarousel/assets/**")
				.addResourceLocations("/WEB-INF/elearning/lib/owlcarousel/assets/");

		// 前台模版 Customized Bootstrap Stylesheet + Template Stylesheet
		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/elearning/css/");

		// 前台模版 JavaScript Libraries
		registry.addResourceHandler("/lib/wow/**").addResourceLocations("/WEB-INF/elearning/lib/wow/");
		registry.addResourceHandler("/lib/easing/**").addResourceLocations("/WEB-INF/elearning/lib/easing/");
		registry.addResourceHandler("/lib/waypoints/**").addResourceLocations("/WEB-INF/elearning/lib/waypoints/");
		registry.addResourceHandler("/lib/owlcarousel/**").addResourceLocations("/WEB-INF/elearning/lib/owlcarousel/");

		// 前台模版 Template Javascript
		registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/elearning/js/");

	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {

		registry.addViewController("/softskilz.homepage").setViewName("account/homepage/BackendPage.jsp");

		registry.addViewController("/softskillz/homepage").setViewName("pages/backendPage.jsp");

		// 後台模版首頁index.html
		registry.addViewController("/softskillz/newhomepage").setViewName("dist/index.html");

		// 前台模版首頁index.html
		registry.addViewController("/softskillz/fhomepage").setViewName("elearning/index.html");

		registry.addViewController("/match.do").setViewName("companion/companion/backendPage.jsp");
	}

}
