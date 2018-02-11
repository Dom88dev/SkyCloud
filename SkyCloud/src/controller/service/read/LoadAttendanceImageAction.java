package controller.service.read;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import controller.service.Action;
import persistance.AttendanceDao;

//멤버 캘린더 출석이미지
public class LoadAttendanceImageAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		String email = null;
		AttendanceDao attendanceDao = new AttendanceDao();
		if (req.getSession().getAttribute("email") != null)
			email = (String) req.getSession().getAttribute("email");
		String atdStatus = attendanceDao.getMemStatus(email);
		Date atdDate = attendanceDao.getMemAtdDate(email);
		SimpleDateFormat str = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = str.format(atdDate);
		String jstatus = null;

		req.getSession().setAttribute("atdStatus", atdStatus);
		req.getSession().setAttribute("atdDate", atdDate);
		Gson gson = new Gson();
		JsonObject obj = new JsonObject();

		obj.addProperty("atdStatus", atdStatus);
		obj.addProperty("start", strDate);

		jstatus = gson.toJson(obj);
		System.out.println("출석상태와 날짜 : " + jstatus);
		return jstatus;
	}

}
