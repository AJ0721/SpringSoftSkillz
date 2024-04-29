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
		registry.addResourceHandler("/img/**").addResourceLocations("/WEB-INF/courseorder/img/");
		registry.addResourceHandler("/courseorder/css/**").addResourceLocations("/WEB-INF/courseorder/css/");
		registry.addResourceHandler("/courseorder/js/**").addResourceLocations("/WEB-INF/courseorder/js/");
		registry.addResourceHandler("/courseorder/html/**").addResourceLocations("/WEB-INF/courseorder/html/");
		registry.addResourceHandler("/courseorder/admin/**").addResourceLocations("/WEB-INF/admin/");
		
		registry.addResourceHandler("/Companion/CompanionImg/**").addResourceLocations("/WEB-INF/companion/jsp/Companion/CompanionImg/");
		
		
		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/js/");
		registry.addResourceHandler("/html/**").addResourceLocations("/WEB-INF/html/");
		
		
		registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/account/images/");
		
	    registry.addResourceHandler("/mall/css/**").addResourceLocations("/WEB-INF/mall/css/");
	    registry.addResourceHandler("/mall/js/**").addResourceLocations("/WEB-INF/mall/js/");
	    registry.addResourceHandler("/mall/img/**").addResourceLocations("/WEB-INF/mall/img/");
	    registry.addResourceHandler("/mall/html/**").addResourceLocations("/WEB-INF/mall/html/");
	    registry.addResourceHandler("/mall/jsp/**").addResourceLocations("/WEB-INF/mall/jsp/");

	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {

		registry.addViewController("/softskilz.homepage").setViewName("account/homepage/BackendPage.jsp");

		registry.addViewController("/softskillz/homepage").setViewName("pages/backendPage.jsp");
		registry.addViewController("/match.do").setViewName("companion/companion/backendPage.jsp");
	}

}
