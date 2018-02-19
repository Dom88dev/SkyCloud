package controller.service.create;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.ApplyDao;
import persistance.MessageDao;

public class InsertStudyApplyAction implements Action{

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String applicantEmail = (String)req.getSession().getAttribute("email");
		String name = (String)req.getSession().getAttribute("name");
		int studyId = Integer.parseInt(req.getParameter("std_id"));
		String applyContent = req.getParameter("apply_content");
		String stdName = req.getParameter("std_name");
		String leaderEmail = req.getParameter("leaderEmail");
				
		
		ApplyDao applyDao = new ApplyDao();
		int applyResult = applyDao.insertApply(applicantEmail, studyId, "apply", applyContent, System.currentTimeMillis());
		
		MessageDao messageDao = new MessageDao();
		int msgResult = messageDao.insertNotiStudyApply(System.currentTimeMillis(), "/fwd?command=MOVESTUDYAPPLIES", name+"님이"+ stdName+"스터디에 가입했습니다.", 0, leaderEmail, applicantEmail);
		
		req.setAttribute("applyResult", applyResult);
		req.setAttribute("msgResult", msgResult);
		
		String bodyInclude = "/studyInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
		
		/*
		if(applyResult>0) {
			return "/WEB-INF/templates/studyApply/studyApplyComplete.jsp";
		}else {
			return "/studyInfo.jsp";
		}
		*/
	}
	
}
