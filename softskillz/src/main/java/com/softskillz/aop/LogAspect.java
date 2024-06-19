package com.softskillz.aop;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@Aspect
@Component
public class LogAspect {
    private static final Logger logger = LoggerFactory.getLogger(LogAspect.class);
    private static final ObjectWriter prettyPrinter = new ObjectMapper().writerWithDefaultPrettyPrinter();

    @Pointcut("execution(* com.softskillz.forum.controller.*.*(..))")
    public void controllerMethods() {
    }

    @Pointcut("execution(* com.softskillz.forum.model.service.*.*(..))")
    public void serviceMethods() {
    }

    @Around("controllerMethods()")
    public Object logAroundController(ProceedingJoinPoint joinPoint) throws Throwable {
        return logAround(joinPoint);
    }

    @Around("serviceMethods()")
    public Object logAroundService(ProceedingJoinPoint joinPoint) throws Throwable {
        return logAround(joinPoint);
    }

    private Object logAround(ProceedingJoinPoint joinPoint) throws Throwable {
        logger.debug("Enter method: {} \n with arguments: {}", 
        		joinPoint.getSignature().getName(), formatArgs(joinPoint.getArgs()));

        Object result;
        try {
            result = joinPoint.proceed();
        } catch (Throwable throwable) {
            logger.error("Exception in method: {} \n with message: {}", 
            		joinPoint.getSignature(), throwable.getMessage());
            throw throwable;
        }

        if (result instanceof Collection) {
            logger.debug("Exit method: {} \n with result size: {}", joinPoint.getSignature().getName(), ((Collection<?>) result).size());
        } else {
            logger.debug("Exit method: {} \n with result: {}", joinPoint.getSignature().getName(), formatObject(result));
        }

        return result;
    }

    private String formatArgs(Object[] args) {
        return Arrays.stream(args)
                .map(arg -> arg instanceof Collection ? "Collection size: " + ((Collection<?>) arg).size() : formatObject(arg))
                .collect(Collectors.joining(", "));
    }

    private String formatObject(Object obj) {
        try {
            return prettyPrinter.writeValueAsString(obj);
        } catch (Exception e) {
            logger.error("Error formatting object to JSON", e);
            return obj.toString();
        }
    }
}
