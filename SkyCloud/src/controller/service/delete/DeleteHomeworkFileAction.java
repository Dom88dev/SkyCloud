package controller.service.delete;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.HomeworkFileDao;

public class DeleteHomeworkFileAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int b_id = Integer.parseInt(req.getParameter("b_id"));
		String fileName = req.getParameter("realFileName");
		String email = (String) req.getSession().getAttribute("email");
		HomeworkFileDao hfDao = new HomeworkFileDao();
		int result = hfDao.deleteHomeworkFile(b_id, email, fileName);
		req.setAttribute("hFileDelResult", result);
		return "/studyManagingMenu/homeworkBoard.jsp";
	}

}
