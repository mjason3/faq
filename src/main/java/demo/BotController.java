package demo;

import java.util.List;

import models.FAQ;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Criteria;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.SimpleStringCriteria;
import org.springframework.data.solr.core.query.result.ScoredPage;
import org.springframework.data.solr.server.support.MulticoreSolrServerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/bot")
@RestController
public class BotController {
	@Autowired
	private MulticoreSolrServerFactory solrServerFactory;
	@Value("${solr.collection}")
	private String solrCollection;

	@RequestMapping(value = "/ask", method = RequestMethod.GET)
	public ResponseEntity<List<FAQ>> ask(@RequestParam String q, @RequestParam(defaultValue = "5") int pageSize,
			@RequestParam int page) {
		if (StringUtils.isEmpty(q)) {
			q = "*:*";
		}
		SolrTemplate solrTemplate = new SolrTemplate(solrServerFactory.getSolrServer(solrCollection));
		Criteria criteria = new SimpleStringCriteria(q);
		SimpleQuery solrExpression = new SimpleQuery(criteria).setPageRequest(new PageRequest(page, pageSize));
		System.out.println(solrExpression.toString());
		ScoredPage<FAQ> faqPage = solrTemplate.queryForPage(solrExpression, FAQ.class);
		HttpHeaders headers = new HttpHeaders();
		headers.add("TotalPageCount", String.valueOf(faqPage.getTotalPages()));
		headers.add("TotalItemsCount", String.valueOf(faqPage.getTotalElements()));
		headers.add("CurrentPage", String.valueOf(page));
		headers.add("PageSize", String.valueOf(pageSize));
		if (faqPage.hasContent()) {
			return new ResponseEntity<List<FAQ>>(faqPage.getContent(), headers, HttpStatus.OK);
		} else {
			return new ResponseEntity<List<FAQ>>(HttpStatus.NOT_FOUND);
		}
	}
}
