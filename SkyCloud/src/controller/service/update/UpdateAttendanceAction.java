package controller.service.update;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.AttendanceDao;

//출결 업데이트
public class UpdateAttendanceAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		AttendanceDao attendanceDao = new AttendanceDao();
		String status = req.getParameter("status");
		String email = req.getParameter("email");
		int r = attendanceDao.UpdateStatus(status, email);
		return String.valueOf(r);
	}

}
