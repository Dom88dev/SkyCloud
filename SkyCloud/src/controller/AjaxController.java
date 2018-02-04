package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.ApplyDao;
import bean.AttendanceDao;
import bean.BoardDao;
import bean.MemberDao;
import bean.StudyDao;
import model.Attendance;
import model.BoardFile;
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		String command = request.getParameter("command");
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
		BoardFile bf;
		String path = getServletContext().getRealPath("upload");
		int maxSize = 50 * 1024 * 1024;
		MultipartRequest multi = null;
		Enumeration<?> fileNames;
		JsonObject jobj;
		Attendance vo;
		StudyDao stdDao = new StudyDao();
		ArrayList<Study> stdList = (ArrayList<Study>) stdDao.getStduyList();
		for (Study s : stdList) {
			System.out.println(s.getStd_id());
			System.out.println(s.getEmail());
		}
		request.setAttribute("stdList", stdList);

		// 파일업로드시 multipart타입으로 파라미터를 받아줘야함으로 command가 null일시 파일업로드를 하는
		// 멀티파트리퀘스트로 판단, multi를 이용해서 다시 받아준다.
		if (command == null) {
			multi = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
			command = multi.getParameter("command");
		}

		switch (command) {
		// 이메일 중복 검사 Ajax
		case "VALIDITYTEST_REGISTER_EMAIL":
			response.setContentType("text/plain");
			memDao = new MemberDao();
			out.print(memDao.getValidEmail(email));
			break;

		// 닉네임 중복 검사 Ajax
		case "VALIDITYTEST_REGISTER_NAME":
			response.setContentType("text/plain");
			String name = request.getParameter("name");
			memDao = new MemberDao();
			out.print(memDao.getValidName(name));
			break;

		// 연락처 중복 검사 Ajax
		case "VALIDITYTEST_REGISTER_TEL":
			response.setContentType("text/plain");
			String tel = request.getParameter("tel");
			memDao = new MemberDao();
			out.print(memDao.getValidTel(tel));
			break;

		case "CHECKATT": // 출석버튼 눌렀을때 작업

			attendanceDao = new AttendanceDao();
			String status = null;
			String jstatus = null;
			int sid = Integer.parseInt(request.getParameter("stdId"));
			if (request.getSession().getAttribute("email") != null)
				email = (String) request.getSession().getAttribute("email");
			status = attendanceDao.InsertAttStatus(sid, email);
			System.out.println("ajax 받은 출결" + status);
			Gson gson = new Gson();
			JsonObject obj = new JsonObject();

			obj.addProperty("status", status);

			jstatus = gson.toJson(obj);
			System.out.println("json 받은 출결" + jstatus);
			out.println(jstatus);
			break;

		// 스터디 등록 시 이메일를 이용하여 스터디명 중복 검사 Ajax
		case "STD_VALID_REGISTER_STDNAME":
			response.setContentType("text/plain");
			String stdEmail = request.getParameter("email");
			stdDao = new StudyDao();
			out.print(stdDao.getValidStdEmail(stdEmail));
			break;

		case "CNTSTATUS": // 출결 상황 카운트
			attendanceDao = new AttendanceDao();
			att = new Attendance();
			int sid1 = Integer.parseInt(request.getParameter("stdId"));
			int attCnt = 0;
			int lateCnt = 0;
			int absCnt = 0;
			int obsCnt = 0;
			String statuscnt = null;
			ArrayList<Attendance> list = (ArrayList<Attendance>) attendanceDao.getAttendenceList(sid1);
			if (list.size() > 0) {
				att = new Attendance();
				if (request.getSession().getAttribute("email") != null)
					email = (String) request.getSession().getAttribute("email");
				status = attendanceDao.InsertAttStatus(sid1, email);
				att.setAtd_status(status);

				if (att.getAtd_status().equals("att")) {
					attCnt++;
				} else if (att.getAtd_status().equals("late")) {
					lateCnt++;
				} else if (att.getAtd_status().equals("abs")) {
					absCnt++;
				} else if (att.getAtd_status().equals("obs")) {
					obsCnt++;
				}

			}
			gson = new Gson();
			jobj = new JsonObject();

			jobj.addProperty("attcnt", attCnt);
			jobj.addProperty("latecnt", lateCnt);
			jobj.addProperty("abscnt", absCnt);
			jobj.addProperty("obscnt", obsCnt);

			statuscnt = gson.toJson(jobj);
			out.println(statuscnt);
			break;

		case "GET_ATTSTATUS": // 출결 가져오기
			vo = new Attendance();
			attendanceDao = new AttendanceDao();
			int sid2 = Integer.parseInt(request.getParameter("stdId"));
			vo.setStd_id(sid2);

			String msg1 = attendanceDao.getAttStatus(vo);
			
			if (msg1 != null) {
				System.out.println(msg1);
				out.print(msg1);
			}
			break;

		case "UPDATE_STATUS": // 출결 업데이트
			attendanceDao = new AttendanceDao();
			status = request.getParameter("status");
			int r = attendanceDao.UpdateStatus(status, email);

			out.println(r);
			break;

		case "MNG_CHANGESTUDY":
			response.setContentType("text/html");
			System.out.println(request.getParameter("index") + "/" + request.getParameter("includeStdMenu"));
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
			JsonArray jarrayNList = (JsonArray) new Gson().toJsonTree(nList, new TypeToken<List<Notice>>() {
			}.getType());
			JsonArray jarrayHList = (JsonArray) new Gson().toJsonTree(hList, new TypeToken<List<Homework>>() {
			}.getType());
			jobj.add("noticeList", jarrayNList);
			jobj.add("homeworkList", jarrayHList);
			apDao = new ApplyDao();
			jobj.addProperty("currentMemNum", apDao.getCurrentMembersNum(stdId));
			String jsonData = new Gson().toJson(jobj);
			out.print(jsonData);
			break;
		case "LOADNOTICE":
			response.setContentType("text/plain");
			jobj = new JsonObject();
			boardDao = new BoardDao();
			stdId = Integer.parseInt(request.getParameter("stdId"));
			nList = (ArrayList<Notice>) boardDao.getNoticeList(stdId);
			jarrayNList = (JsonArray) new Gson().toJsonTree(nList, new TypeToken<List<Notice>>() {
			}.getType());
			jobj.add("noticeList", jarrayNList);
			jobj.addProperty("currentPage", 0);
			jsonData = new Gson().toJson(jobj);
			out.print(jsonData);
			break;
		case "LOADHOMEWORK":
			response.setContentType("text/plain");
			jobj = new JsonObject();
			boardDao = new BoardDao();
			stdId = Integer.parseInt(request.getParameter("stdId"));
			hList = (ArrayList<Homework>) boardDao.getHomeworkList(stdId);
			jarrayHList = (JsonArray) new Gson().toJsonTree(hList, new TypeToken<List<Notice>>() {
			}.getType());
			jobj.add("homeworkList", jarrayHList);
			jobj.addProperty("currentPage", 0);
			jsonData = new Gson().toJson(jobj);
			out.print(jsonData);
			break;
		case "POSTBOARD":// 게시판 등록 화면으로 이동
			response.setContentType("text/html");
			request.setAttribute("stdId", request.getParameter("stdId"));
			request.setAttribute("boardKind", request.getParameter("board"));
			RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/templates/post/postBoard.jsp");
			view.forward(request, response);
			break;
		case "POSTNOTICE":// 공지사항 등록
			notice = new Notice();
			bf = new BoardFile();
			notice.setB_datetime(System.currentTimeMillis());
			notice.setStd_id(Integer.parseInt(multi.getParameter("stdId")));
			notice.setTitle(multi.getParameter("title"));
			notice.setContent(multi.getParameter("content"));
			fileNames = multi.getFileNames();
			int fileNum = 0;
			while (fileNames.hasMoreElements()) {
				String fName = (String) fileNames.nextElement();
				fileNum++;
				if (fName == null || fName.equals(""))
					continue;
				if (fileNum == 1) {
					bf.setB_file1_name(multi.getOriginalFileName(fName));
					bf.setB_file1("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 2) {
					bf.setB_file2_name(multi.getOriginalFileName(fName));
					bf.setB_file2("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 3) {
					bf.setB_file3_name(multi.getOriginalFileName(fName));
					bf.setB_file3("/upload" + multi.getFilesystemName(fName));
				}
			}
			jobj = new JsonObject();
			boardDao = new BoardDao();
			int b_id = boardDao.insertNotice(notice);
			jobj.addProperty("postResult", boardDao.insertBoardFile(b_id, bf));
			jsonData = new Gson().toJson(jobj);
			out.print(jsonData);
			break;
		case "POSTHOMEWORK":// 과제 등록
			homework = new Homework();
			bf = new BoardFile();
			homework.setB_datetime(System.currentTimeMillis());
			long addingTimeForDue = Long.parseLong(multi.getParameter("daysToduedate"))
					* (1000l * 60l * 60l * 60l * 24l);
			homework.setDuedate(homework.getB_datetime() + addingTimeForDue);
			homework.setStd_id(Integer.parseInt(multi.getParameter("stdId")));
			homework.setTitle(multi.getParameter("title"));
			homework.setContent(multi.getParameter("content"));
			fileNames = multi.getFileNames();
			fileNum = 0;
			while (fileNames.hasMoreElements()) {
				String fName = (String) fileNames.nextElement();
				fileNum++;
				if (fName == null || fName.equals(""))
					continue;
				if (fileNum == 1) {
					bf.setB_file1_name(multi.getOriginalFileName(fName));
					bf.setB_file1("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 2) {
					bf.setB_file2_name(multi.getOriginalFileName(fName));
					bf.setB_file2("/upload" + multi.getFilesystemName(fName));
				} else if (fileNum == 3) {
					bf.setB_file3_name(multi.getOriginalFileName(fName));
					bf.setB_file3("/upload" + multi.getFilesystemName(fName));
				}
			}
			jobj = new JsonObject();
			boardDao = new BoardDao();
			b_id = boardDao.insertHomework(homework);
			jobj.addProperty("postResult", boardDao.insertBoardFile(b_id, bf));
			jsonData = new Gson().toJson(jobj);
			out.print(jsonData);
			break;
		case "LOADLEADERCALENDAR":
			response.setContentType("text/plain");
			out.print("/StudyCloud/studyManagingMenu/calendar/AtdCalStdleader.jsp");
			break;

		case "LOADMEMCALENDAR":
			response.setContentType("text/plain");
			out.print("/StudyCloud/studyManagingMenu/calendar/AtdCalStdmem.jsp");
			break;

		case "LOADSTATUSIMG": // 멤버 캘린더 출석이미지
			response.setContentType("text/plain");
			attendanceDao = new AttendanceDao();
			if (request.getSession().getAttribute("email") != null)
				email = (String) request.getSession().getAttribute("email");
			String atdStatus = attendanceDao.getMemStatus(email);
			Date atdDate = attendanceDao.getMemAtdDate(email);
			SimpleDateFormat str = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = str.format(atdDate);
			jstatus = null;

			request.getSession().setAttribute("atdStatus", atdStatus);
			request.getSession().setAttribute("atdDate", atdDate);
			gson = new Gson();
			obj = new JsonObject();

			obj.addProperty("atdStatus", atdStatus);
			obj.addProperty("start", strDate);

			jstatus = gson.toJson(obj);
			System.out.println("출석상태와 날짜 : " + jstatus);
			out.println(jstatus);
			break;
		}
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
