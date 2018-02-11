package controller.service.move;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.BoardDao;

//게시글(공지사항/과제) 수정
public class MoveBoardUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		BoardDao boardDao = new BoardDao();
		String kind = req.getParameter("board");
		if(kind.equals("notice")) {
			req.setAttribute("notice", boardDao.getNotice(Integer.parseInt(req.getParameter("b_id"))));
		} else {
			req.setAttribute("homework", boardDao.getHomework(Integer.parseInt(req.getParameter("b_id"))));
		}
		req.setAttribute("boardKind", req.getParameter("board"));
		return "/WEB-INF/templates/board/updateBoard.jsp";
	}

}
