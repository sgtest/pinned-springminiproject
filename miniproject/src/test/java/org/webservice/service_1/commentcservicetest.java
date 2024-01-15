package org.webservice.service_1;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.webservice.domain.comment;
import org.webservice.mapper.commentmapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class commentcservicetest {

	@Setter(onMethod_= {@Autowired})
	public commentmapper cmapper;
	
	//@Test
	@DisplayName("댓글 입력 테스트")
	public void testcommentinsert() {
		comment cmt=new comment();
		cmt.setBno(50L);
		cmt.setReplyer("user00");
		cmt.setReply("이것은 테스트용 댓글입니다");
		cmapper.insertcomment(cmt);
	}
	
	//@Test
	@DisplayName("댓글 삭제 테스트")
	public void testcommentdelete() {
		cmapper.deletecomment(1L);
	}

	@Test
	@DisplayName("댓글 수정 테스트")
	public void testcommentupdate() {
		comment cmt=cmapper.readcomment(2L);
		cmt.setReply("수정된 댓글 입니다");
		cmapper.updatecomment(cmt);
	}
}
