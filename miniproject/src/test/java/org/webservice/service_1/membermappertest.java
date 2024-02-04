package org.webservice.service_1;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.webservice.domain.member;
import org.webservice.mapper.membermapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class membermappertest {
	
	@Setter(onMethod_=@Autowired)
	private membermapper mapper;
	
	@Test
	public void testread() {
		member m=mapper.readmember("master");
		log.info(m.getUserpw());
		
	}
}
