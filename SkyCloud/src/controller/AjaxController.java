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
import bean.StudyDao;
import model.Attendance;
import model.Homework;
import model.Member;
import model.Notice;
import model.Study;


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
		String upstatus = request.getParameter("status");
		String email = request.getParameter("email");
		int stdId;
		
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
		Attendance vo;
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getStduyList();
		for(Study s : stdList) {
			System.out.println(s.getStd_id());
		}
		request.setAttribute("stdList", stdList);

		
		switch(command) {
		case "VALIDITYTEST_REGISTER":
			response.setContentType("text/plain");
			break;
			
		case "CHECKATT": //출석버튼 눌렀을때 작업
			
			attendanceDao = new AttendanceDao();
			String status=null;
			String jstatus=null;
			stdId = Integer.parseInt((String) request.getParameter("stdId"));
			try {
				status = attendanceDao.InsertAttStatus(stdId);
				Gson gson = new Gson();
				JsonObject obj = new JsonObject();
				
				obj.addProperty("status", status);
				
				jstatus = gson.toJson(obj);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			out.println(jstatus);
			break;
		
		case "CNTSTATUS":	//출결 상황 카운트
			attendanceDao = new AttendanceDao();
			stdId = Integer.parseInt((String) request.getParameter("stdId"));
			int attCnt = 0;
			int lateCnt = 0;
			int absCnt = 0;
			int obsCnt = 0;
			String statuscnt = null;
			ArrayList<Attendance> list = (ArrayList<Attendance>) attendanceDao.getAttendenceList(stdId);
			
			for(Attendance a : list) {
				if(a.getAtd_status().equals("att")) {
					attCnt++;
				}else if(a.getAtd_status().equals("late")) {
					lateCnt++;
				}else if(a.getAtd_status().equals("abs")) {
					absCnt++;
				}else if(a.getAtd_status().equals("obs")) {
					obsCnt++;
				}
			}
			Gson gson = new Gson();
			jobj = new JsonObject();
			
			jobj.addProperty("attcnt", attCnt);
			jobj.addProperty("latecnt", lateCnt);
			jobj.addProperty("abscnt", absCnt);
			jobj.addProperty("obscnt", obsCnt);
			
			statuscnt = gson.toJson(jobj);
			
			out.println(statuscnt);
			break;
			
		case "GET_ATTSTATUS": //출결 가져오기
			vo = new Attendance();
			attendanceDao = new AttendanceDao();
			stdId = Integer.parseInt((String) request.getParameter("stdId"));
			vo.setStd_id(stdId);
			
			String msg1 = attendanceDao.getAttStatus(vo);
			
			if(msg1 != null){
				out.print(msg1);
				out.flush();
			}
			break;
			
		case "UPDATE_STATUS": //출결 업데이트
			attendanceDao = new AttendanceDao();
			int r = attendanceDao.UpdateStatus(upstatus, email);
			
			out.println(r);
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
			stdId = Integer.parseInt(request.getParameter("stdId"));
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
