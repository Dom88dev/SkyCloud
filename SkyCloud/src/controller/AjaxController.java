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
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import bean.AttendanceDao;

import model.Attendance;


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
		String upstatus = request.getParameter("status");
		String email = request.getParameter("email");
		int att = Integer.parseInt((String) request.getParameter("stdId"));
		
		AttendanceDao attendanceDao;
		Attendance vo;
		switch(command) {
		case "VALIDITYTEST_REGISTER":
			response.setContentType("text/plain");
			break;
			
		case "CHECKATT": //출석버튼 눌렀을때 작업
			
			attendanceDao = new AttendanceDao();
			String status=null;
			String jstatus=null;

			try {
				status = attendanceDao.InsertAttStatus(att);
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
			int attCnt = 0;
			int lateCnt = 0;
			int absCnt = 0;
			int obsCnt = 0;
			String statuscnt = null;
			ArrayList<Attendance> list = (ArrayList<Attendance>) attendanceDao.getAttendenceList(att);
			
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
			JsonObject obj = new JsonObject();
			
			obj.addProperty("attcnt", attCnt);
			obj.addProperty("latecnt", lateCnt);
			obj.addProperty("abscnt", absCnt);
			obj.addProperty("obscnt", obsCnt);
			
			statuscnt = gson.toJson(obj);
			
			out.println(statuscnt);
			break;
			
		case "GET_ATTSTATUS": //출결 가져오기
			vo = new Attendance();
			attendanceDao = new AttendanceDao();
			vo.setStd_id(att);
			
			String msg1 = attendanceDao.getAttStatus(vo);
			
			if(msg1 != null){
				out.print(msg1);
				out.flush();
			}
			
		case "UPDATE_STATUS": //출결 업데이트
			attendanceDao = new AttendanceDao();
			attendanceDao.UpdateStatus(upstatus, email);
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
