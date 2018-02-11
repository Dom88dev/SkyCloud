package controller.service.read.validity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.StudyDao;

//스터디 등록 시 이메일를 이용하여 스터디명 중복 검사 Ajax
public class ValidateStudyNameAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		String stdEmail = req.getParameter("email");
		StudyDao stdDao = new StudyDao();
		int result = stdDao.getValidStdEmail(stdEmail);
		return String.valueOf(result);
	}

}
