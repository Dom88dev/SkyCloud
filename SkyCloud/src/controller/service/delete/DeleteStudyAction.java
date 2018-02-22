package controller.service.delete;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.ApplyDao;
import persistance.StudyDao;

public class DeleteStudyAction implements Action{

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int stdId = Integer.parseInt(req.getParameter("std_id"));
		
		ApplyDao applydao = new ApplyDao();
		StudyDao studydao = new StudyDao();
		
		studydao.deleteStudyTimeplace(stdId);
		applydao.deleteApply(stdId);
		studydao.deleteStudy(stdId);
		
		return "/index.jsp";
	}
	
}
