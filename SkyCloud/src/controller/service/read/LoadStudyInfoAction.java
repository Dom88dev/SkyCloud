package controller.service.read;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.service.Action;
import model.Member;
import model.Study;
import persistance.ApplyDao;
import persistance.MemberDao;
import persistance.StudyDao;

//스터디 상세 정보 처리
public class LoadStudyInfoAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int studyId = Integer.parseInt(req.getParameter("stdId"));
		String applicantEmail = (String)req.getSession().getAttribute("email");
		String leaderEmail = req.getParameter("email");
		
		StudyDao stdDao = new StudyDao();
		MemberDao memDao = new MemberDao();
		ApplyDao applyDao = new ApplyDao();
		HttpSession session = req.getSession();
		
		Member applicantMem = memDao.getMemberByEmail(applicantEmail);
		Member mem = memDao.getMemberByEmail(leaderEmail);
		Study std = stdDao.getStudyInfo(studyId);
		int currentMember = applyDao.getCurrentMembersNum(studyId);
		
		req.setAttribute("currentMember", currentMember);
		session.setAttribute("std", std);
		req.setAttribute("applicantMem", applicantMem);
		req.setAttribute("mem", mem);
		
		String bodyInclude = "/studyInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		
		return "/index.jsp";
	}
	
}
