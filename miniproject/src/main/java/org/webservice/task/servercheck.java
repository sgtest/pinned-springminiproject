package org.webservice.task;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.webservice.domain.banuser;
import org.webservice.mapper.boardmapper;
import org.webservice.service_1.boardservice;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class servercheck {
	@Autowired
	boardmapper bmapper;
	@Autowired
	boardservice bservice;
	//매일 확인 
	//벤 리스트 정보를 전부 가져와서 기간 지난것들을 전부 해제
	@Scheduled(fixedRate = 24 * 60 * 60 * 1000)
	public void checkban() {
		DateFormat datefmt=new SimpleDateFormat("yyyy-MM-dd");
		Date currentdate=new Date();
		List<banuser> banlist=bmapper.getbanlist();
		
		for(banuser user: banlist) {
			String streddate=user.getEnddate();
			try {
				Date eddate=datefmt.parse(streddate);
				if(currentdate.after(eddate)) {
					bservice.userbanrelease(user.getUserid());
				}
			} catch (Exception e) {
				System.out.println("차단 체크 메소드가 비정상 실행되었습니다.");
			}
			
		}

		log.info("정기 차단 해제");
	}
}
