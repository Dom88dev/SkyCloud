package controller.service.create;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.MemberDao;
import persistance.MessageDao;
import persistance.ReplyDao;

public class InsertReplyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ReplyDao rpDao = new ReplyDao();
		int b_id = Integer.parseInt(req.getParameter("b_id"));
		int std_id = Integer.parseInt(req.getParameter("std_id"));
		String rp_writer = req.getParameter("rp_writer");
		String rp_content= req.getParameter("rp_content");
		String studyLeader = req.getParameter("studyLeader");
		String kind = req.getParameter("board");
		String url = "/fwd?";
		String email = (String)req.getSession().getAttribute("email");
		
		rpDao.insertReply(b_id, rp_content, rp_writer);
		
		if(!studyLeader.equals(email)) {
			Member mem = new MemberDao().getMemberByEmail(email);
			new MessageDao().notiReplyOccured(studyLeader, mem.getName(), kind, b_id, std_id);
		}
		
		if(kind.equals("notice")) {
			url+="command=READNOTICE&b_id="+b_id;
		} else {
			url+="command=READHOMEWORK&b_id="+b_id;
		}
		return url;
	}

}
