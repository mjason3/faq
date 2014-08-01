package demo;

import java.util.List;
import java.util.UUID;

import models.FAQ;

import org.apache.solr.client.solrj.response.UpdateResponse;
import org.apache.solr.common.SolrInputDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.Criteria;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.SimpleStringCriteria;
import org.springframework.data.solr.core.query.result.ScoredPage;
import org.springframework.data.solr.server.support.MulticoreSolrServerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/bot")
@RestController
public class BotController {
	@Autowired
	private MulticoreSolrServerFactory solrServerFactory;

	@RequestMapping(value = "/ask", method = RequestMethod.GET)
	public ResponseEntity<List<FAQ>> ask(@RequestParam String q) {
		SolrTemplate solrTemplate = new SolrTemplate(
				solrServerFactory.getSolrServer("collection1"));
		Criteria criteria = new SimpleStringCriteria("question:" + q + " ")
				.or(new SimpleStringCriteria("answer:" + q));
		System.out.println(criteria.toString());
		SimpleQuery solrExpression = new SimpleQuery(criteria)
				.setPageRequest(new PageRequest(0, 10));
		System.out.println(solrExpression.toString());
		ScoredPage<FAQ> faqPage = solrTemplate.queryForPage(solrExpression,
				FAQ.class);
		if (faqPage.hasContent()) {
			int end = faqPage.getContent().size() > 5 ? 5 : faqPage.getContent().size();
			return new ResponseEntity<List<FAQ>>(faqPage.getContent().subList(
					0, end), HttpStatus.OK);
		} else {
			return new ResponseEntity<List<FAQ>>(HttpStatus.NOT_FOUND);
		}
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<FAQ> add(@RequestBody FAQ faq) {
		SolrTemplate solrTemplate = new SolrTemplate(
				solrServerFactory.getSolrServer("collection1"));
		SolrInputDocument doc = new SolrInputDocument();
		doc.setField("question", faq.getQuestion());
		doc.setField("answer", faq.getAnswer());
		doc.setField("id", UUID.randomUUID().toString());
		UpdateResponse resp = solrTemplate.saveDocument(doc);
		solrTemplate.commit();
		if (resp.getStatus() == 0) {
			return new ResponseEntity<>(faq, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
}
