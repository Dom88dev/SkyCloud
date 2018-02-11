package controller.service.read;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Attendance;
import persistance.AttendanceDao;

//출결 가져오기
public class LoadAttendanceStatusAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Attendance vo = new Attendance();
		AttendanceDao attendanceDao = new AttendanceDao();
		int sid2 = Integer.parseInt(req.getParameter("stdId"));
		vo.setStd_id(sid2);

		String msg1 = attendanceDao.getAttStatus(vo);
		System.out.println(msg1);
		return msg1;
	}

}
