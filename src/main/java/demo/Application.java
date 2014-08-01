package demo;

import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.solr.server.support.MulticoreSolrServerFactory;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan(basePackages = { "demo" })
@EnableAutoConfiguration
public class Application extends SpringBootServletInitializer {

	@Bean
	public Filter encodingFilter() {
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("utf8");
		filter.setForceEncoding(true);
		return filter;
	}

	@Bean
	public ViewResolver defaultViewResolver() {
		ViewResolver vr = new InternalResourceViewResolver();
		return vr;
	}

	@Bean
	public SolrServer solrServer() {
		SolrServer solrServer = new HttpSolrServer("http://localhost:8983/solr");
		return solrServer;
	}

	@Bean
	public MulticoreSolrServerFactory solrServerFactory(SolrServer solrServer) {
		List<String> coreList = Arrays.asList("collection1");
		MulticoreSolrServerFactory solrFactory = new MulticoreSolrServerFactory(
				solrServer, coreList);
		return solrFactory;
	}

	@Override
	protected SpringApplicationBuilder configure(
			SpringApplicationBuilder application) {
		return application.sources(Application.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
}
