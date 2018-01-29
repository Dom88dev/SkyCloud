package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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

import bean.AttendanceDao;
import model.Attendance;
import model.StudyTimePlace;



/**
 * Servlet implementation class AjaxController
 */
@WebServlet("/AjaxController")
public class AjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String command = request.getParameter("command");

		AttendanceDao attendanceDao;
		Attendance att;
		MemberDao md = new MemberDao();
				
		

		switch(command) {
		case "VALIDITYTEST_REGISTER_EMAIL":
			response.setContentType("text/plain");
			String email = request.getParameter("email");
			System.out.println(email);
			md = new MemberDao();
			out.print(md.getValidEmail(email));
			break;
			
		case "VALIDITYTEST_REGISTER_NAME":
			response.setContentType("text/plain");
			String name = request.getParameter("name");
			System.out.println(name);
			md = new MemberDao();
			out.print(md.getValidName(name));
			break;
			
		case "VALIDITYTEST_REGISTER_TEL":
			response.setContentType("text/plain");
			String tel = request.getParameter("tel");
			System.out.println(tel);
			md = new MemberDao();
			out.print(md.getValidTel(tel));
			break;

			
			
		case "CHECKATT": //출석버튼 눌렀을때 작업
			int att1 = Integer.parseInt((String) request.getSession().getAttribute("mystd_id"));
			attendanceDao = new AttendanceDao();
			String status=null;
			try {
				status = attendanceDao.InsertAttStatus(att1);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			out.println(status);
			break;

		}
		
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
