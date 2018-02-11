package controller.service.read;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Homework;
import persistance.BoardDao;

//특정 과제글 읽기
public class ReadStudyHomeworkAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDao boardDao = new BoardDao();
		Homework homework = boardDao.getHomework(Integer.parseInt(req.getParameter("b_id")));
		req.setAttribute("homework", homework);
		return "/WEB-INF/templates/board/readBoard.jsp";
	}

}
