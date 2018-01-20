package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.DBConnectionMgr;
import bean.StudyDao;
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
		String command = request.getParameter("command");
		String url = "";
		
		switch(command){
		
		case "STUDYLIST":
			StudyDao stdDao = new StudyDao();
			ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getStduyList();
			request.setAttribute("stdList", stdList);
			request.setAttribute("Loaded", true);
			url = "/index.jsp";
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
