package controller.service.update;

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
import persistance.StudyDao;
import util.Util;

//스터디 수정처리
public class UpdateStudyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StudyDao stdDao = new StudyDao();
		Map<String, String[]> params2 = req.getParameterMap();
		Enumeration<String> paramEnums2 = req.getParameterNames();
		ArrayList<String> paramNames2 = new ArrayList<>();//파라미터 이름들을 받을 어레이리슽트
		ArrayList<String[]> stdDays2 = new ArrayList<>();//요일값들을 나눠 담아놓을 어레이 리스트
		while(paramEnums2.hasMoreElements()) {//파라미터 이름들을 어레이 리스트에 답아준다.
			String str = paramEnums2.nextElement();
			paramNames2.add(str);
		}
		for(String n : paramNames2) {//요일에 해당하는 String[]을 어레이 리스트에 담아준다.
			if(n.contains("std_day")) stdDays2.add(params2.get(n));
		}
		
		Study std = new Study();
		std.setStudy(params2.get("std_name")[0], Integer.parseInt(params2.get("std_max")[0]), Util.transDate(params2.get("std_start")[0]), 
				Util.transDate(params2.get("std_end")[0]), params2.get("std_info")[0], params2.get("std_plan")[0], params2.get("std_etc")[0], 
				params2.get("std_gender")[0], params2.get("std_category")[0], (String)req.getSession().getAttribute("email"));
		//Study table에 스터디를 등록
		int stdId2 = stdDao.updateStudy(std);
		
		String[] stdTimes3=params2.get("std_time_h"), stdTimes4=params2.get("std_time_m"), stdHours1=params2.get("std_hour"), 
				stdAddrs1=params2.get("std_addr");
		
		int result = 0;
		//Study_timeplace table에 위에서 넣은 Study의 장소와 시간을 갯수만틈 삽입
		for(int i=0; i<stdTimes3.length;i++){
			for(int j=0; j<stdDays2.get(i).length; j++) {
				StudyTimePlace stp = new StudyTimePlace();
				stp.setStudyTimePlace(stdId2, 
						(stdTimes3[i].length()==2?stdTimes3[i]:"0"+stdTimes3[i])+(stdTimes4[i].length()==2?stdTimes4[i]:"0"+stdTimes4[i]), 
						Integer.parseInt(stdHours1[i]), stdAddrs1[i], stdDays2.get(i)[j]);
				result += stdDao.updateStudyTimePlace(stp);
			}	
		}
		
		req.setAttribute("updateStudyResult", result);
		String bodyInclude = "/stdUpdateRegister.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
