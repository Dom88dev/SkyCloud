package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import bean.ApplyDao;
import bean.AttendanceDao;
import bean.BoardDao;
import bean.MemberDao;
import model.Attendance;
import model.Homework;
import model.Member;
import model.Notice;


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
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		String command = request.getParameter("command");
		
		AttendanceDao attendanceDao;
		Attendance att;
		Member mem;
		MemberDao memDao;
		BoardDao boardDao;
		Notice notice;
		ApplyDao apDao;
		ArrayList<Notice> nList;
		Homework homework;
		ArrayList<Homework> hList;
		JsonObject jobj;
		
		switch(command) {
		case "VALIDITYTEST_REGISTER":
			response.setContentType("text/plain");
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
			
		case "MNG_CHANGESTUDY":
			response.setContentType("text/html");
			System.out.println(request.getParameter("index") +"/"+request.getParameter("includeStdMenu"));
			request.getSession().setAttribute("index", request.getParameter("index"));
			request.getSession().setAttribute("includeStdMenu", request.getParameter("includeStdMenu"));
			out.print("/StudyCloud/studyManagingMenu/");
			break;
			
		case "LOADSTUDYINFO":
			response.setContentType("text/plain");
			memDao = new MemberDao();
			mem = memDao.getMemberByEmail(request.getParameter("leaderEmail"));
			jobj = new JsonObject();
			jobj.add("leader", new Gson().toJsonTree(mem));
			boardDao = new BoardDao();
			int stdId = Integer.parseInt(request.getParameter("stdId"));
			nList = (ArrayList<Notice>) boardDao.getNoticeList(stdId);
			hList = (ArrayList<Homework>) boardDao.getHomeworkList(stdId);
			JsonArray jarrayNList = (JsonArray) new Gson().toJsonTree(nList,
		            new TypeToken<List<Notice>>() {
		            }.getType());
			JsonArray jarrayHList = (JsonArray) new Gson().toJsonTree(hList,
		            new TypeToken<List<Homework>>() {
		            }.getType());
			jobj.add("noticeList", jarrayNList);
			jobj.add("homeworkList", jarrayHList);
			apDao = new ApplyDao();
			jobj.addProperty("currentMemNum", apDao.getCurrentMembersNum(stdId));
			String jsonData = new Gson().toJson(jobj);
			out.print(jsonData);
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
