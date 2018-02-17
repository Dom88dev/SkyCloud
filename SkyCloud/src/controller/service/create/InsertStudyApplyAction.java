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
		String applyContent = (String)req.getAttribute("apply_content");
		
		ApplyDao applyDao = new ApplyDao();
		int result = applyDao.insertApply(email, studyId, "apply", applyContent, System.currentTimeMillis());
		
		req.setAttribute("StudyApplyResult", result);
		String bodyInclude = "/studyInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}
	
}
