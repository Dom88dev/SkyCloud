package controller.service.create;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Study;
import model.StudyTimePlace;
import persistance.ApplyDao;
import persistance.StudyDao;
import util.Util;

//스터디 등록 처리 작업
public class RegisterStudyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = (String)req.getSession().getAttribute("email");
		StudyDao stdDao = new StudyDao();
		Map<String, String[]> params = req.getParameterMap();
		Enumeration<String> paramEnums = req.getParameterNames();
		ArrayList<String> paramNames = new ArrayList<>();//파라미터 이름들을 받을 어레이리슽트
		ArrayList<String[]> stdDays = new ArrayList<>();//요일값들을 나눠 담아놓을 어레이 리스트
		while(paramEnums.hasMoreElements()) {//파라미터 이름들을 어레이 리스트에 답아준다.
			String str = paramEnums.nextElement();
			paramNames.add(str);
		}
		for(String n : paramNames) {//요일에 해당하는 String[]을 어레이 리스트에 담아준다.
			if(n.contains("std_day")) stdDays.add(params.get(n));
		}
		
		Study std = new Study();
		std.setStudy(params.get("std_name")[0], Integer.parseInt(params.get("std_max")[0]), Util.transDate(params.get("std_start")[0]), 
				Util.transDate(params.get("std_end")[0]), params.get("std_info")[0], params.get("std_plan")[0], params.get("std_etc")[0], 
				params.get("std_gender")[0], params.get("std_category")[0], email);
		//Study table에 스터디를 등록
		int stdId = stdDao.insertStudy(std);
		
		String[] stdTimes1=params.get("std_time_h"), stdTimes2=params.get("std_time_m"), stdHours=params.get("std_hour"), 
				stdAddrs=params.get("std_addr");
		
		int result = 0;
		//Study_timeplace table에 위에서 넣은 Study의 장소와 시간을 갯수만틈 삽입
		for(int i=0; i<stdTimes1.length;i++){
			for(int j=0; j<stdDays.get(i).length; j++) {
				StudyTimePlace stp = new StudyTimePlace();
				stp.setStudyTimePlace(stdId, 
						(stdTimes1[i].length()==2?stdTimes1[i]:"0"+stdTimes1[i])+(stdTimes2[i].length()==2?stdTimes2[i]:"0"+stdTimes2[i]), 
						Integer.parseInt(stdHours[i]), stdAddrs[i], stdDays.get(i)[j]);
				result += stdDao.insertStudyTimePlace(stp);
			}	
		}
		ApplyDao applyDao = new ApplyDao();
		//위에 만든 스터디의 스터디장을 applies table에 accept 상태로 삽입
		if(result>0) result = applyDao.insertApply(email, stdId, "accept", "study leader", System.currentTimeMillis());
		
		req.setAttribute("RegisterStudyResult", result);
		String bodyInclude = "/WEB-INF/study/stdRegister.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
