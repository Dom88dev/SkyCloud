package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ApplyDao;
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
		String email = null;
		if(request.getSession().getAttribute("email") != null) email = (String) request.getSession().getAttribute("email");
		
		MemberDao memDao;
		Member mem;
		StudyDao stdDao;
		Study std;
		StudyTimePlace stp;
		ApplyDao applyDao;
		
		switch(command){
		
		case "LOADSTUDYLIST"://메인페이지에 스터디 목록 로딩 작업
			stdDao = new StudyDao();
			ArrayList<Study> stdList = (ArrayList<Study>)stdDao.getStduyList();
			for(Study s : stdList) {
				System.out.println(s.getStd_id());
			}
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
			
		case "GOSTDREGISTER"://스터디등록화면으로 이동
			bodyInclude = "/WEB-INF/study/stdRegister.jsp";
			break;
			
		case "REGISTUDY"://스터디 등록 처리 작업
			stdDao = new StudyDao();
			Map<String, String[]> params = request.getParameterMap();
			Enumeration<String> paramEnums = request.getParameterNames();
			ArrayList<String> paramNames = new ArrayList<>();//파라미터 이름들을 받을 어레이리슽트
			ArrayList<String[]> stdDays = new ArrayList<>();//요일값들을 나눠 담아놓을 어레이 리스트
			while(paramEnums.hasMoreElements()) {//파라미터 이름들을 어레이 리스트에 답아준다.
				String str = paramEnums.nextElement();
				paramNames.add(str);
				System.out.println(str+" = " + params.get(str)[0]);
			}
			for(String n : paramNames) {//요일에 해당하는 String[]을 어레이 리스트에 담아준다.
				if(n.contains("std_day")) stdDays.add(params.get(n));
			}
			
			std = new Study();
			std.setStudy(params.get("std_name")[0], Integer.parseInt(params.get("std_max")[0]), Util.transDate(params.get("std_start")[0]), 
					Util.transDate(params.get("std_end")[0]), params.get("std_info")[0], params.get("std_plan")[0], params.get("std_etc")[0], 
					params.get("std_gender")[0], params.get("std_category")[0], email);
			//Study table에 스터디를 등록
			int stdId = stdDao.insertStudy(std);
			
			String[] stdTimes1=params.get("std_time_h"), stdTimes2=params.get("std_time_m"), stdHours=params.get("std_hour"), 
					stdAddrs=params.get("std_addr");
			
			result = 0;
			//Study_timeplace table에 위에서 넣은 Study의 장소와 시간을 갯수만틈 삽입
			for(int i=0; i<stdTimes1.length;i++){
				for(int j=0; j<stdDays.get(i).length; j++) {
					stp = new StudyTimePlace();
					stp.setStudyTimePlace(stdId, 
							(stdTimes1[i].length()==2?stdTimes1[i]:"0"+stdTimes1[i])+(stdTimes2[i].length()==2?stdTimes2[i]:"0"+stdTimes2[i]), 
							Integer.parseInt(stdHours[i]), stdAddrs[i], stdDays.get(i)[j]);
					result += stdDao.insertStudyTimePlace(stp);
				}	
			}
			applyDao = new ApplyDao();
			//위에 만든 스터디의 스터디장을 applies table에 accept 상태로 삽입
			if(result>0) result = applyDao.insertApply(email, stdId, "accept", "study leader", System.currentTimeMillis());
			
			request.setAttribute("RegisterStudyResult", result);
			bodyInclude = "/WEB-INF/study/stdRegister.jsp";
			break;
			
		case "GETSTUDYINFO":
			
			break;
			

		case "SEARCHSTUDY"://스터디 검색 처리
			String searchTxt = request.getParameter("searchTxt");
			stdDao = new StudyDao();
			stdList = (ArrayList<Study>)stdDao.getSearchStudyListOnNavbar(searchTxt);
			request.setAttribute("stdList", stdList);
			request.setAttribute("Loaded", true);
			bodyInclude = "/main.jsp";
			break;
			
		case "GOMNGSTUDY"://스터디 매니징 클라우드로 이동
			bodyInclude = "/WEB-INF/study/manager.jsp";

			break;
			
		case "UPDATEINFO": //회원 수정 처리
			mem = new Member();

			mem.setPw(request.getParameter("pw"));
			mem.setName(request.getParameter("name"));
			mem.setTel(request.getParameter("tel"));

			memDao = new MemberDao();
			int rs = memDao.UpdateMemInfo(mem);
			request.setAttribute("upInfoResult", rs);
			bodyInclude = "/upMemInfo.jsp";
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
