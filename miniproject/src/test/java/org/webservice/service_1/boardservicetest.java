package org.webservice.service_1;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.webservice.domain.board;
import org.webservice.mapper.boardmapper;
import org.webservice.mapper.membermapper;
import org.webservice.persis.DataSourceTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class boardservicetest {
//board 서비스와 file 서비스를 테스트 하는 코드입니다
	
	@Setter(onMethod_= {@Autowired})
	public boardmapper bmapper;

	//@Test
	public void testmemberinfo() {
		log.info(bmapper.select_boardaouth("main"));
	}
	
	@Test
	@DisplayName("게시판 생성 테스트")
	public void testregisterboard() {
		bmapper.createboard("main", "master", "this is main board");
	}
	
	//@Test
	public void testinsertboard() {
		
	}
	
	
}
