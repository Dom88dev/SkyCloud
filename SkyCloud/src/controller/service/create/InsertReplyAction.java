package controller.service.create;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.ReplyDao;

public class InsertReplyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ReplyDao rpDao = new ReplyDao();
		int b_id = Integer.parseInt(req.getParameter("b_id"));
		String rp_writer = req.getParameter("rp_writer");
		String rp_content= req.getParameter("rp_content");
		String kind = req.getParameter("board");
		String url = "/fwd?";
				
		rpDao.insertReply(b_id, rp_content, rp_writer);
		
		if(kind.equals("notice")) {
			url+="command=READNOTICE&b_id="+b_id;
		} else {
			url+="command=READHOMEWORK&b_id="+b_id;
		}
		return url;
	}

}
