package controller.service.move;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.service.Action;
import model.Study;
import persistance.StudyDao;

//스터디 매니징 클라우드로 이동
public class MoveStudyManagerAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bodyInclude = "/WEB-INF/study/manager.jsp";
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>) stdDao.getMyStudy((String)req.getSession().getAttribute("email"));
		HttpSession session = req.getSession();
		session.setAttribute("myStdList", stdList);
		session.setAttribute("index", session.getAttribute("index")==null?0:session.getAttribute("index"));
		session.setAttribute("includeStdMenu", session.getAttribute("includeStdMenu")==null?"stdHome":session.getAttribute("includeStdMenu"));
		session.setAttribute("includeApplyMenu", "applyList.jsp");
		req.setAttribute("postResult", req.getParameter("postResult")==null?null:req.getParameter("postResult"));
		req.setAttribute("updateResult", req.getParameter("updateResult")==null?null:req.getParameter("updateResult"));
		req.setAttribute("deleteResult", req.getParameter("deleteResult")==null?null:req.getParameter("deleteResult"));
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
