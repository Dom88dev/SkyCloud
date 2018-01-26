package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

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
import model.StudyTimePlace;

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
		String url = "/index.jsp";
		String bodyInclude = null;
		
		MemberDao memDao;
		Member mem;
		StudyDao stdDao;
		Study std;
		StudyTimePlace stp;
		
		switch(command){
		
		case "LOADSTUDYLIST"://메인페이지에 스터디 목록 로딩 작업
			stdDao = new StudyDao();
			ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getStduyList();
			request.setAttribute("stdList", stdList);
			request.setAttribute("Loaded", true);
			bodyInclude = "/main.jsp";
			break;
			
		case "GOREGISTER"://회원가입화면으로 이동
			bodyInclude = "/register.jsp";
			break;
			
		case "REGIMEMBER"://회원가입 처리 작업
			mem = new Member();
			mem.setMember(request.getParameter("email"), request.getParameter("pw"), request.getParameter("name"), request.getParameter("tel"),
					request.getParameter("gender")==null?"M":"F", Util.transDate(request.getParameter("born")));
			memDao = new MemberDao();
			int result = memDao.insertMember(mem);
			request.setAttribute("RegisterResult", result);
			bodyInclude = "/register.jsp";
			break;
			
		case "LOGIN"://로그인 처리 작업 - modal이기 때문에 url을 변경
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
			
		case "LOGOUT"://로그아웃 처리 작업 - modal이기 때문에 url을 변경
			request.getSession().removeAttribute("email");
			request.setAttribute("logout", true);
			url = "/logInOut/logOut.jsp";
			break;
			
		case "REGISTUDY"://스터디 등록 처리 작업
			stdDao = new StudyDao();
			HashMap<String, String[]> params = (HashMap<String, String[]>) request.getParameterMap();
			Enumeration<String> paramEnums = request.getParameterNames();
			ArrayList<String> paramNames = new ArrayList<>();//파라미터 이름들을 받을 어레이리슽트
			ArrayList<String[]> stdDays = new ArrayList<>();//요일값들을 나눠 담아놓을 어레이 리스트
			while(paramEnums.hasMoreElements()) {//파라미터 이름들을 어레이 리스트에 답아준다.
				paramNames.add(paramEnums.nextElement());
			}
			for(String n : paramNames) {//요일에 해당하는 String[]을 어레이 리스트에 담아준다.
				if(n.contains("std_day")) stdDays.add(params.get(n));
			}
			
			std = new Study();
			std.setStudy(params.get("std_name")[0], Integer.parseInt(params.get("std_max")[0]), Util.transDate(params.get("std_start")[0]), 
					Util.transDate(params.get("std_end")[0]), params.get("std_info")[0], params.get("std_plan")[0], params.get("std_etc")[0], 
					params.get("std_gender")[0], params.get("std_category")[0], (String)request.getSession().getAttribute("email"));
			
			int stdId = stdDao.insertStudy(std);
			
			String[] stdTimes1=params.get("std_time_h"), stdTimes2=params.get("std_time_m"), stdHours=params.get("std_hour"), 
					stdAddrs=params.get("std_addr");
			
			result = 0;
			for(int i=0; i<stdTimes1.length;i++){
				for(int j=0; j<stdDays.get(i).length; j++) {
					stp = new StudyTimePlace();
					stp.setStudyTimePlace(stdId, stdTimes1[i]+stdTimes2[i], Integer.parseInt(stdHours[i]), stdAddrs[i], stdDays.get(i)[j]);
					result += stdDao.insertStudyTimePlace(stp);
				}	
			}
			
			request.setAttribute("RegisterResult", result);
			bodyInclude = "/stdRegister.jsp";
			break;
			
		}
		request.setAttribute("bodyInclude", bodyInclude);
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
