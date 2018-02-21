package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Homework;
import model.Replies;
import persistance.BoardDao;
import persistance.ReplyDao;

//특정 과제글 읽기
public class ReadStudyHomeworkAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDao boardDao = new BoardDao();
		boolean countUp = req.getParameter("countUp")==null?false:true;
		int b_id = Integer.parseInt(req.getParameter("b_id"));
		if(countUp) {
			boardDao.boardViewCntUp(b_id);
		}
		Homework homework = boardDao.getHomework(b_id);
		ReplyDao rpDao = new ReplyDao();
		ArrayList<Replies> replies = (ArrayList<Replies>) rpDao.getReplies(Integer.parseInt(req.getParameter("b_id")));
		req.setAttribute("homework", homework);
		req.setAttribute("replies", replies);
		return "/WEB-INF/templates/board/readBoard.jsp";
	}

}
