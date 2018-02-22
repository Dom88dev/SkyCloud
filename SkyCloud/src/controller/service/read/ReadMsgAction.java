package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Message;
import model.Notice;
import model.Replies;
import persistance.BoardDao;
import persistance.MessageDao;
import persistance.ReplyDao;

//특정 공지사항 읽기
public class ReadMsgAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MessageDao messageDao = new MessageDao();
		System.out.println("gdgd");
		Message message = messageDao.getMsg(Integer.parseInt(req.getParameter("msg_id")));
		System.out.println("메시지"+message);
		req.setAttribute("message", message);

		return "/WEB-INF/templates/message/readMsg.jsp";
	}

}
