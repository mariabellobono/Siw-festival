package it.uniroma3.siw.configuration;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {
	
	private final DataSource dataSource;
	
	public SecurityConfiguration(DataSource dataSource) {     //connesione al database 
		this.dataSource = dataSource;
	}
	@Bean
	public PasswordEncoder confrontaPassword() {
	    return new BCryptPasswordEncoder();
	}
	
	@Bean
	public UserDetailsService cercaUtente() {
		JdbcUserDetailsManager manager = new JdbcUserDetailsManager(dataSource);  // oggetto della libreria che interroga il database passato 
		manager.setUsersByUsernameQuery("SELECT username,password,true AS enabled FROM credenziali WHERE username=?"); //
		manager.setAuthoritiesByUsernameQuery("SELECT username,ruolo FROM credenziali WHERE username =?");
		return manager;  //consegna al magazzino 
	}
	@Bean
	public SecurityFilterChain regoleAccesso(HttpSecurity http) throws Exception {
	    http.authorizeHttpRequests(auth -> {
	        auth.requestMatchers(HttpMethod.GET, "/", "/index", "/login", "/register", "/error",
	                "/festivals/**", "/films/**", "/sale/**", "/proiezioni/**", "/attori/**",
	                "/css/**", "/images/**", "/favicon.ico").permitAll();
	        auth.requestMatchers(HttpMethod.POST, "/register", "/login").permitAll();
	        auth.requestMatchers("/admin/**").hasAuthority("ADMIN");    //hasAuthority protegge gia l'admin quindi non deve passare per il controller 
	        auth.anyRequest().authenticated();
	    });
	    http.formLogin(form -> {
	        form.loginPage("/login").permitAll();
	        form.defaultSuccessUrl("/", true);
	        form.failureUrl("/login?error=true");
	   });
	    http.logout(logout -> {
	        logout.logoutUrl("/logout");
	        logout.logoutSuccessUrl("/");
	        logout.invalidateHttpSession(true);
	        logout.deleteCookies("JSESSIONID");
	        logout.clearAuthentication(true);
	        logout.permitAll();
	    });
	
	return http.build();
	}
}
