package com.softskillz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.PropertySource;


@SpringBootApplication
@PropertySource(value = {"classpath:jdbc.properties"}, ignoreResourceNotFound = true)
public class SpringBootSoftSkillzApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringBootSoftSkillzApplication.class, args);
	}

}
