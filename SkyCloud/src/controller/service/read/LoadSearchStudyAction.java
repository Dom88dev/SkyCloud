package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Study;
import persistance.StudyDao;

//스터디 검색 처리
public class LoadSearchStudyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String searchTxt = req.getParameter("searchTxt");
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getSearchStudyListOnNavbar(searchTxt);
		req.setAttribute("stdList", stdList);
		req.setAttribute("Loaded", true);
		String bodyInclude = "/main.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
