package demo;

import java.util.UUID;

import models.FAQ;

import org.apache.solr.client.solrj.response.UpdateResponse;
import org.apache.solr.common.SolrInputDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.solr.core.SolrTemplate;
import org.springframework.data.solr.core.query.SimpleQuery;
import org.springframework.data.solr.core.query.SimpleStringCriteria;
import org.springframework.data.solr.server.support.MulticoreSolrServerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private MulticoreSolrServerFactory solrServerFactory;
	@Value("${solr.collection}")
	private String solrCollection;

	@RequestMapping(value = "/editFAQ")
	public String editFAQ(@RequestParam(required = false) String id, Model model) {
		if (!StringUtils.isEmpty(id)) {
			SolrTemplate solrTemplate = new SolrTemplate(solrServerFactory.getSolrServer(solrCollection));
			FAQ faq = solrTemplate.queryForObject(new SimpleQuery(new SimpleStringCriteria("id:" + id)), FAQ.class);
			if (faq != null) {
				model.addAttribute("question", faq.getQuestion());
				model.addAttribute("answer", faq.getAnswer());
				model.addAttribute("sId", faq.getId());
			}
		}
		return "editFAQ";
	}
	
	@RequestMapping(value = "")
	public String admin() {
		return "admin";
	}

	@RequestMapping(value = "/faq", method = RequestMethod.DELETE)
	@ResponseBody
	public int deleteFaq(@RequestParam String id) {
		SolrTemplate solrTemplate = new SolrTemplate(solrServerFactory.getSolrServer("collection1"));
		UpdateResponse resp = solrTemplate.deleteById(id);
		solrTemplate.commit();
		return resp.getStatus();
	}

	@RequestMapping(value = "/faq", method = RequestMethod.POST)
	public ResponseEntity<FAQ> add(@RequestBody FAQ faq) {
		SolrTemplate solrTemplate = new SolrTemplate(solrServerFactory.getSolrServer("collection1"));
		SolrInputDocument doc = new SolrInputDocument();
		doc.setField("question", faq.getQuestion());
		doc.setField("answer", faq.getAnswer());
		if (StringUtils.isEmpty(faq.getId())) {
			doc.setField("id", UUID.randomUUID().toString());
		} else {
			doc.setField("id", faq.getId());
		}
		UpdateResponse resp = solrTemplate.saveDocument(doc);
		solrTemplate.commit();
		if (resp.getStatus() == 0) {
			return new ResponseEntity<>(faq, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
}
