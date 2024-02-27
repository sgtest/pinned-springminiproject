package org.webservice.service_1;

import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;

@Service
public class etcserviceImpl implements etcservice{
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public int createcertification() {
		int valienum= (int) (Math.random()*(9000000))+1000000;
		return valienum;
	}
	
	@Override
	public JavaMailSender createjms() {
		return mailSender;
	}
}
