package controller.service.read;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import controller.service.Action;
import model.Attendance;
import persistance.AttendanceDao;

//출결 상황 카운트
public class LoadCountAttendaceAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AttendanceDao attendanceDao = new AttendanceDao();
		Attendance att = new Attendance();
		String email = null;
		String status = null;
		int sid1 = Integer.parseInt(req.getParameter("stdId"));
		int attCnt = 0;
		int lateCnt = 0;
		int absCnt = 0;
		int obsCnt = 0;
		String statuscnt = null;
		ArrayList<Attendance> list = (ArrayList<Attendance>) attendanceDao.getAttendenceList(sid1);
		if (list.size() > 0) {
			att = new Attendance();
			if (req.getSession().getAttribute("email") != null)
				email = (String) req.getSession().getAttribute("email");
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
		Gson gson = new Gson();
		JsonObject jobj = new JsonObject();

		jobj.addProperty("attcnt", attCnt);
		jobj.addProperty("latecnt", lateCnt);
		jobj.addProperty("abscnt", absCnt);
		jobj.addProperty("obscnt", obsCnt);

		statuscnt = gson.toJson(jobj);
		return statuscnt;
	}

}
