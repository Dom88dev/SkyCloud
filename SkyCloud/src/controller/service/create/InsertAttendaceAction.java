package controller.service.create;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import controller.service.Action;
import persistance.AttendanceDao;

//출석버튼 눌렀을때 작업
public class InsertAttendaceAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AttendanceDao attendanceDao = new AttendanceDao();
		String status = null;
		String jstatus = null;
		String email = null;
		int sid = Integer.parseInt(req.getParameter("stdId"));
		if (req.getSession().getAttribute("email") != null)
			email = (String) req.getSession().getAttribute("email");
		status = attendanceDao.InsertAttStatus(sid, email);
		System.out.println("ajax 받은 출결" + status);
		Gson gson = new Gson();
		JsonObject obj = new JsonObject();

		obj.addProperty("status", status);

		jstatus = gson.toJson(obj);
		System.out.println("json 받은 출결" + jstatus);
		return jstatus;
	}

}
