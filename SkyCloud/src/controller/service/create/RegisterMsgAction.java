package controller.service.create;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;

import controller.service.Action;
import controller.service.MultipartAction;
import model.BoardFile;
import model.Member;
import model.Message;
import model.Notice;
import persistance.BoardDao;
import persistance.MemberDao;
import persistance.MessageDao;
import util.Util;

public class RegisterMsgAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Message message = new Message(0, null, null, 0, null, null);

		message.setReciever(req.getParameter("reciever"));
		message.setMsg_datetime(System.currentTimeMillis());
		message.setMsg_id(Integer.parseInt(req.getParameter("msgId")));
		
		message.setMsg_content(req.getParameter("msgContent"));
		message.setSender(req.getParameter("sender"));
		
		String who = message.getReciever();
		
		MessageDao messageDao = new MessageDao();
		int result = messageDao.insertMessage(message);
		if(result>0) {
			result = messageDao.getMsg_IdFromMessage(message);
		}
		
		return who;
	}


}
