package controller.service.move;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;

//게시판(공지사항/과제) 등록 화면으로 이동
public class MoveBoardRegisterAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		req.setAttribute("stdId", req.getParameter("stdId"));
		req.setAttribute("boardKind", req.getParameter("board"));
		return "/WEB-INF/templates/board/postBoard.jsp";
	}

}
