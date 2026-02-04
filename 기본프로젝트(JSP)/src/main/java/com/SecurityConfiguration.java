package com;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {
	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		// http.httpBasic().disable();
		http.httpBasic().disable().csrf().disable().authorizeRequests().antMatchers("/user/**").permitAll()
				.antMatchers("/board/boardMain", "/board/boardDetail").permitAll()
				.and()
				.sessionManagement()
				.invalidSessionUrl("/login"); // 세션 만료 시 이동할 페이지;

		return http.build();
	}

	@Bean
	public PasswordEncoder encoder() {
		PasswordEncoder encode = new BCryptPasswordEncoder();
		return encode; // password를 인코딩 해줄때 쓰기 위함
	}
}
