package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.MemberDao;
import bean.StudyDao;
import bean.Util;
import model.Member;
import model.Study;

/**
 * Servlet implementation class IntroController
 */
@WebServlet("/IntroController")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String command = request.getParameter("command");
		String url = "";
		
		switch(command){
		
		case "LOADSTUDYLIST":
			StudyDao stdDao = new StudyDao();
			ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getStduyList();
			request.setAttribute("stdList", stdList);
			request.setAttribute("Loaded", true);
			url = "/index.jsp";
			break;
		case "REGIMEMBER":
			Member mem = new Member();
			mem.setMember(request.getParameter("email"), request.getParameter("pw"), request.getParameter("name"), request.getParameter("tel"), request.getParameter("gender")==null?"M":"F", Util.transDate(request.getParameter("born")));
			MemberDao memDao = new MemberDao();
			int result = memDao.insertMember(mem);
			request.setAttribute("RegisterResult", result);
			url = "/register.jsp";
			break;
			
		}
		
		RequestDispatcher view = request.getRequestDispatcher(url);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
