package controller.service.move;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.service.Action;
import model.Apply;
import model.Study;
import persistance.ApplyDao;
import persistance.StudyDao;

//스터디 매니징 클라우드로 이동
public class MoveStudyManagerAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bodyInclude = "/WEB-INF/study/manager.jsp";
		String email = (String)req.getSession().getAttribute("email");
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>) stdDao.getMyStudy(email);
		ApplyDao applyDao = new ApplyDao();
		ArrayList<Apply> stdApplies = new ArrayList<>();
		for(Study s : stdList) {
			if(s.getEmail().equals(email)) {
				stdApplies.addAll(applyDao.getStudyApplies(s.getStd_id(), email, s.getStd_name()));
			}
		}
		ArrayList<Apply> myApplyList = (ArrayList<Apply>) applyDao.getMyApplyList(email);
		
		if(stdList.size()<1) {
			bodyInclude = "/main.jsp";
			req.setAttribute("havingStudy", "0");
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("myStdList", stdList);
		session.setAttribute("index", session.getAttribute("index")==null?0:session.getAttribute("index"));
		session.setAttribute("includeStdMenu", session.getAttribute("includeStdMenu")==null?"stdHome":session.getAttribute("includeStdMenu"));
		session.setAttribute("includeApplyMenu", session.getAttribute("includeApplyMenu")==null?"stdApplies":session.getAttribute("includeApplyMenu"));
		session.setAttribute("currentTab", session.getAttribute("currentTab")==null?"studyManager":session.getAttribute("currentTab"));
		session.setAttribute("stdApplies", stdApplies);
		session.setAttribute("myApplyList", myApplyList);
		
		req.setAttribute("postResult", req.getParameter("postResult")==null?null:req.getParameter("postResult"));
		req.setAttribute("updateResult", req.getParameter("updateResult")==null?null:req.getParameter("updateResult"));
		req.setAttribute("deleteResult", req.getParameter("deleteResult")==null?null:req.getParameter("deleteResult"));
		req.setAttribute("bodyInclude", bodyInclude);
		
		
		return "/index.jsp";
	}

}
