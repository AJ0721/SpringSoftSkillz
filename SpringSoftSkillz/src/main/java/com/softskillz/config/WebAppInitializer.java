package com.softskillz.config;

import org.springframework.orm.hibernate5.support.OpenSessionInViewFilter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import jakarta.servlet.Filter;
import jakarta.servlet.MultipartConfigElement;
import jakarta.servlet.ServletRegistration.Dynamic;

//相當於web.xml的Java程式組態
public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	// 用來註冊相當於beans.config.xml的java程式組態
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { RootAppConfig.class };
	}

	// 用來註冊相當於mvc-servlet.xml的java程式組態
	@Override
	protected Class<?>[] getServletConfigClasses() {

		return new Class[] { WebAppConfig.class };
//		return null;
	}

	// 用來設定DispatcherServlet的url-pattern的路徑位置
	@Override
	protected String[] getServletMappings() {

		return new String[] { "/" };
//		return null;
	}

	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter ecf = new CharacterEncodingFilter("UTF-8", true);

		return new Filter[] { ecf };
	}

	@Override
	protected void customizeRegistration(Dynamic registration) {
		registration.setMultipartConfig(new MultipartConfigElement("c:/temp/upload/"));
	}


}
