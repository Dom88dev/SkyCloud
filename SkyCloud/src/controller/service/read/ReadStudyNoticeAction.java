package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Notice;
import model.Replies;
import persistance.BoardDao;
import persistance.ReplyDao;

//특정 공지사항 읽기
public class ReadStudyNoticeAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDao boardDao = new BoardDao();
		boolean countUp = req.getParameter("countUp")==null?false:true;
		int b_id = Integer.parseInt(req.getParameter("b_id"));
		if(countUp) {
			boardDao.boardViewCntUp(b_id);
		}
		Notice notice = boardDao.getNotice(b_id);
		ReplyDao rpDao = new ReplyDao();
		ArrayList<Replies> replies = (ArrayList<Replies>) rpDao.getReplies(Integer.parseInt(req.getParameter("b_id")));
		req.setAttribute("notice", notice);
		req.setAttribute("replies", replies);
		return "/WEB-INF/templates/board/readBoard.jsp";
	}

}
