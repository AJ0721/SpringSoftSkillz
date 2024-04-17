package com.softskillz.config;

import java.util.ArrayList;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

//相當於 mvc-servlet.xml的java程式組太
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = { "com.softskillz" })
public class WebAppConfig implements WebMvcConfigurer {

	@Bean
	public MappingJackson2JsonView jsonView() {
		MappingJackson2JsonView jv = new MappingJackson2JsonView();
		jv.setPrettyPrint(true);
		return jv;
	}

	@Bean
	public ContentNegotiatingViewResolver cnViewResolver() {
		ContentNegotiatingViewResolver cnvr = new ContentNegotiatingViewResolver();
		ArrayList<View> list = new ArrayList<View>();
		list.add(jsonView());
		return cnvr;
	}

	@Bean
	public InternalResourceViewResolver irViewResolver() {
		InternalResourceViewResolver irvr1 = new InternalResourceViewResolver();
		irvr1.setViewClass(HtmlResourceView.class);
		irvr1.setPrefix("/WEB-INF/");
		irvr1.setSuffix(".jsp");
		irvr1.setOrder(6);

		return irvr1;
	}

	@Bean
	public ViewResolver viewResolver() {
		UrlBasedViewResolver resolver = new UrlBasedViewResolver();
		resolver.setViewClass(HtmlResourceView.class);
		resolver.setPrefix("/WEB-INF/");
		resolver.setSuffix(".html");
		resolver.setOrder(3);
		return resolver;
	}
	
//	@Bean
//	public ViewResolver viewResolver02() {
//		UrlBasedViewResolver resolver = new UrlBasedViewResolver();
//		resolver.setViewClass(HtmlResourceView.class);
//		resolver.setPrefix("");
//		resolver.setSuffix("");
//		resolver.setOrder(7);
//		return resolver;
//	}

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	@Bean
	public ResourceBundleMessageSource messageSource() {
		ResourceBundleMessageSource ms = new ResourceBundleMessageSource();
		ms.setBasename("i18n.message");
		ms.setDefaultEncoding("UTF-8");
		return ms;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
		lci.setParamName("locale");
		registry.addInterceptor(lci).addPathPatterns("/**");
	}

	@Bean
	public SessionLocaleResolver localeResolver() {
		return new SessionLocaleResolver();
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/img/**").addResourceLocations("/WEB-INF/courseorder/img/");
		registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/courseorder/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/courseorder/js/");
		registry.addResourceHandler("/html/**").addResourceLocations("/WEB-INF/courseorder/html/");
		registry.addResourceHandler("/").addResourceLocations("/");
		registry.addResourceHandler("/Companion/CompanionImg/**").addResourceLocations("/WEB-INF/Companion/CompanionImg/");
		registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/account/images/");
		registry.addResourceHandler("/Mall/MallImg/**").addResourceLocations("/WEB-INF/Mall/MallImg/");
		registry.addResourceHandler("/forum/css/**").addResourceLocations("/WEB-INF/forum/css/");


	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/softskillz.homepage").setViewName("pages/backendPage");
		registry.addViewController("/match.do").setViewName("Companion/CompanionIndex/index");
		registry.addViewController("/match.insert").setViewName("Companion/CompanionInsert/insert");
		registry.addViewController("/admin.insert").setViewName("account/admin/AdminCreate");
		registry.addViewController("/mall.do").setViewName("Mall/MallIndex/index");
		registry.addViewController("/mall.insert").setViewName("Mall/MallIndex/insert");
		registry.addViewController("/main").setViewName("LoginSimulation.html");
	}

	@Bean
	public StandardServletMultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}
	

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
	
}
