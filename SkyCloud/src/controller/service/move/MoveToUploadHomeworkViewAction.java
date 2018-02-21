package controller.service.move;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;

public class MoveToUploadHomeworkViewAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("b_id", req.getParameter("b_id"));
		if(req.getParameter("uploadHfileResult") != null) {
			req.setAttribute("uploadHfileResult", req.getParameter("uploadHfileResult"));
		}
		return "/WEB-INF/templates/board/uploadHomeworkFile.jsp";
	}

}
