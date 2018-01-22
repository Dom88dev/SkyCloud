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
		
		MemberDao memDao;
		Member mem;
		StudyDao stdDao;
		
		switch(command){
		
		case "LOADSTUDYLIST":
			stdDao = new StudyDao();
			ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getStduyList();
			request.setAttribute("stdList", stdList);
			request.setAttribute("Loaded", true);
			url = "/index.jsp";
			break;
		case "REGIMEMBER":
			mem = new Member();
			mem.setMember(request.getParameter("email"), request.getParameter("pw"), request.getParameter("name"), request.getParameter("tel"), request.getParameter("gender")==null?"M":"F", Util.transDate(request.getParameter("born")));
			memDao = new MemberDao();
			int result = memDao.insertMember(mem);
			request.setAttribute("RegisterResult", result);
			url = "/register.jsp";
			break;
		case "LOGIN":
			memDao = new MemberDao();
			mem = memDao.getMemberByEmail(request.getParameter("email"));
			if(mem.getPw()!=null) {
				if(mem.getPw().equals(request.getParameter("pw"))) {
					request.getSession().setAttribute("email", mem.getEmail());
					request.setAttribute("logInResult", "success");
				} else {
					request.setAttribute("logInResult", "wrongPw");
				}
			} else {
				request.setAttribute("logInResult", "noMember");
			}
			url = "/logInOut/logIn.jsp";
			break;
		case "LOGOUT":
			request.getSession().removeAttribute("email");
			request.setAttribute("logout", true);
			url = "/logInOut/logOut.jsp";
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
