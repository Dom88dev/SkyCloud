package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.reflect.TypeToken;

import controller.service.Action;
import model.Attendance;
import model.Message;
import persistance.AttendanceDao;

//출결 가져오기
public class LoadAttendanceStatusAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		AttendanceDao attendanceDao = new AttendanceDao();
		int sid = Integer.parseInt(req.getParameter("stdId"));
		ArrayList<Attendance> aList = (ArrayList<Attendance>) attendanceDao.getAttStatus(sid);
		JsonArray jarrayNList = (JsonArray) new Gson().toJsonTree(aList, new TypeToken<List<Message>>() {
		}.getType());
		String jsonData = new Gson().toJson(jarrayNList);
		System.out.println(jsonData);
		return jsonData;
	}

}
