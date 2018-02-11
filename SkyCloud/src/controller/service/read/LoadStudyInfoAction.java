package controller.service.read;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		String leaderEmail = req.getParameter("email");
		StudyDao stdDao = new StudyDao();
		MemberDao memDao = new MemberDao();
		ApplyDao applyDao = new ApplyDao();
		Member mem = memDao.getMemberByEmail(leaderEmail);
		Study std = stdDao.getStudyInfo(studyId);
		int currentMember = applyDao.getCurrentMembersNum(studyId);
		req.setAttribute("currentMember", currentMember);
		req.setAttribute("std", std);
		req.setAttribute("mem", mem);
		String bodyInclude = "/studyInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}
	
}
