package com.academy.lodsing.core.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Application 환경 설정
 * @author 이세훈
 */
@Configuration
public class ApplicationConfig implements WebMvcConfigurer {

	//2.
	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver internalResourceViewResolver = new InternalResourceViewResolver();
		internalResourceViewResolver.setViewClass(JstlView.class);
		internalResourceViewResolver.setPrefix("/WEB-INF/views/");
		internalResourceViewResolver.setSuffix(".jsp");
		internalResourceViewResolver.setRequestContextAttribute("rc");	//이 부분만 아니면 jsonViewResolver만 별도의 빈으로 선언하고 나머지는 application.yml 파일의
																		//spring.mvc.view.prefix와 spring.mvc.view.suffix 부분을 설정하면 됨
		
		
		List<ViewResolver> viewResolvers = new ArrayList<ViewResolver>();
		viewResolvers.add(internalResourceViewResolver);
		
		ContentNegotiatingViewResolver viewResolver = new ContentNegotiatingViewResolver();
		viewResolver.setViewResolvers(viewResolvers);
		
		return viewResolver;
	}

	
}
