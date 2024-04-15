package com.softskillz.config;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.config.Configurator;
import org.apache.logging.log4j.core.appender.ConsoleAppender;
import org.apache.logging.log4j.core.layout.PatternLayout;
import org.apache.logging.log4j.Logger;
import org.springframework.context.annotation.Configuration;

import jakarta.annotation.PostConstruct;

//@Configuration
public class Log4jConfig {

	private static final Logger LOGGER = LogManager.getLogger(Log4jConfig.class);

	@PostConstruct
	public void configureLog4j2() {
//		Configurator.setLevel("org.springframework.beans.factory", Level.ERROR);
//		Configurator.setLevel("com.timeline", Level.DEBUG);
		Configurator.setLevel("org.hibernate", Level.DEBUG); 

		ConsoleAppender consoleAppender = ConsoleAppender
				.newBuilder().withName("Console").setTarget(ConsoleAppender.Target.SYSTEM_OUT).withLayout(PatternLayout
						.newBuilder().withPattern("%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n").build())
				.build();
		consoleAppender.start();

		org.apache.logging.log4j.core.LoggerContext ctx = (org.apache.logging.log4j.core.LoggerContext) LogManager
				.getContext(false);
		org.apache.logging.log4j.core.config.Configuration config = ctx.getConfiguration();

		config.getRootLogger().addAppender(consoleAppender, Level.ERROR, null);
		ctx.updateLoggers(); // 需要更新 Loggers

		LOGGER.debug("Log4j2 configuration is completed.");
	}

}
