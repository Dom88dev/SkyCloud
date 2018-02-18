package controller.service.create;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Apply;
import persistance.ApplyDao;

public class InsertStudyApplyAction implements Action{

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = (String)req.getSession().getAttribute("email");
		int studyId = Integer.parseInt(req.getParameter("stdId"));
		String applyContent = req.getParameter("apply_content");
		System.out.println(applyContent);
		ApplyDao applyDao = new ApplyDao();
		int result = applyDao.insertApply(email, studyId, "apply", applyContent, System.currentTimeMillis());
		
		if(result>0) {
			return "/WEB-INF/templates/studyApply/studyApplyComplete.jsp";
		}else {
			return "/studyInfo.jsp";
		}
		
	}
	
}
