package controller.service.update;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.ReplyDao;

public class UpdateReplyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int rp_id = Integer.parseInt(req.getParameter("rp_id"));
		String rp_content = req.getParameter("rp_content");
		String kind = req.getParameter("board");
		int b_id = Integer.parseInt(req.getParameter("b_id"));
		String url = "/fwd?";
		
		ReplyDao rpDao = new ReplyDao();
		rpDao.updateReply(rp_id, rp_content);
		
		if(kind.equals("notice")) {
			url+="command=READNOTICE&b_id="+b_id;
		} else {
			url+="command=READHOMEWORK&b_id="+b_id;
		}
		return url;
	}

}
