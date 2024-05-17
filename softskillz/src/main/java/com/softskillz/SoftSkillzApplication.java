package com.softskillz;

import java.util.concurrent.DelayQueue;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import com.softskillz.courseorder.model.bean.CorderBean;


@SpringBootApplication
@EnableScheduling
@EnableCaching
public class SoftSkillzApplication {

	public static void main(String[] args) {
		SpringApplication.run(SoftSkillzApplication.class, args);
	}
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}

	@Bean
	public DelayQueue<CorderBean> delayQueue() {
		return new DelayQueue<>(); // 创建延迟队列
	}

	@Bean
	public ThreadPoolTaskScheduler taskScheduler() {
		ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
		scheduler.setPoolSize(5); // 设置线程池大小
		return scheduler;
	}

	@Bean
	public ReentrantLock reentrantLock() {
		return new ReentrantLock();
	}
	@Bean
	public ServerEndpointExporter serverEndpointExporter() {
		return new ServerEndpointExporter();
	}
}
