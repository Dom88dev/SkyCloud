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

public class MoveReadBoardByMessageAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bodyInclude = "/WEB-INF/study/manager.jsp";
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>) stdDao.getMyStudy((String)req.getSession().getAttribute("email"));
		HttpSession session = req.getSession();
		session.setAttribute("myStdList", stdList);
		for(int i=0; i<stdList.size();i++) {
			if(stdList.get(i).getStd_id() == Integer.parseInt(req.getParameter("std_id"))) {
				session.setAttribute("index", i);
			}
		}
		session.setAttribute("includeStdMenu", req.getParameter("board")=="notice"?"stdNotice":"stdHomework");
		session.setAttribute("includeApplyMenu", "applyList.jsp");
		req.setAttribute("bodyInclude", bodyInclude);
		req.setAttribute("readBoard_id", Integer.parseInt(req.getParameter("b_id")));
		return "/index.jsp";
	}

}
