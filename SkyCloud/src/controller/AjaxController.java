package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		PrintWriter out = response.getWriter();
		String command = request.getParameter("command");
		
		AttendanceDao attendanceDao;
		
		switch(command) {
		case "VALIDITYTEST_REGISTER":
			response.setContentType("text/plain");
			break;
			
		case "CHECKATT": //출석버튼 눌렀을때 작업
			int att = Integer.parseInt((String) request.getSession().getAttribute("mystd_id"));
			attendanceDao = new AttendanceDao();
			String status=null;
			try {
				status = attendanceDao.InsertAttStatus(att);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			out.println(status);
			break;
			
		case "UPDATE_ATTSTATUS": //출결 수정
			int no = Integer.valueOf(request.getParameter("std_id"));
			Attendance vo = new Attendance();
			AttendanceDao dao = new AttendanceDao();
			vo.setStd_id(no);
			
			String msg = dao.UpdateAttStatus(vo);
			
			if(msg != null){
				out.print(msg);
				out.flush();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
