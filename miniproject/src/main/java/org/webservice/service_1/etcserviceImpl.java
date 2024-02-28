package org.webservice.service_1;

import java.io.InputStream;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.eclipse.angus.mail.util.logging.MailHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;


@Service
public class etcserviceImpl implements etcservice{
	
	@Autowired
	private JavaMailSender mailSender;
	private static int varifynum;
	private static final String sender="springwebservice3131@gmail.com";
	/*
    
	boolean auth = true;
    boolean starttls = true;
    boolean sslTrust = true;
    boolean ssl = false;
    */
	@Override
	public int createcertification() {
		int valienum= (int) (Math.random()*(9000000))+1000000;
		return valienum;
	}
	
	@Override
	public MimeMessage createmessage(String email, String title, String text) {
		MimeMessage msg=mailSender.createMimeMessage();
		try {
			msg.setFrom(new InternetAddress(sender));
			msg.setRecipients(MimeMessage.RecipientType.TO, email);
			msg.setSubject(title);
			msg.setText(text, "UTF-8", "html");
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return msg;
	}
	/*
	public JavaMailSender javasnd() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setUsername(sender);
        mailSender.setPassword("pyqe czva ejxj qgbf");
 
        Properties props = mailSender.getJavaMailProperties();
        props.setProperty("mail.transport.protocol", "smtp");
 
        props.setProperty("mail.smtp.auth", String.valueOf(auth));
        if (starttls)
            props.setProperty("mail.smtp.starttls.enable", "true");
        if (sslTrust)
            props.setProperty("mail.smtp.ssl.trust", "*");
        if (ssl)
            props.setProperty("mail.smtp.ssl.enable", "true");
        return mailSender;
	}
	*/
	@Override
	public void createjms(String email, int number) {
        /*JavaMailSender sendertest = javasnd();*/
		this.varifynum=number;
		String title="웹서비스 인증 메일입니다.";
		String text;
		text="<div>"+"<div><h1>웹서비스로 부터 인증메일이 왔습니다. 아래의 숫자를 확인하고 사이트에 입력해주세요</h1></div><br>"
			 +"<div><h4>인증번호</h4>"+"<h1>"+number+"</h1></div><br>"
			 +"<div><h4>관리자 이메일: springwebservice3131@gmail.com </h4></div>"
			 +"</div>";
		
		MimeMessage msg=createmessage(email,title,text);
		mailSender.send(msg);
	}
	
	@Override
	public boolean varify(int number) {
		if(number==varifynum) {
			return true;
		}else {
			return false;
		}
	}

}
