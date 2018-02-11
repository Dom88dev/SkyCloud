package controller.service.read;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Notice;
import persistance.BoardDao;

//특정 공지사항 읽기
public class ReadStudyNoticeAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDao boardDao = new BoardDao();
		Notice notice = boardDao.getNotice(Integer.parseInt(req.getParameter("b_id")));
		req.setAttribute("notice", notice);
		return "/WEB-INF/templates/board/readBoard.jsp";
	}

}
