package controller.service.read.validity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.MemberDao;

//이메일 중복 검사 Ajax
public class ValidateMemberEmailAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		MemberDao memDao = new MemberDao();
		int result = memDao.getValidEmail(req.getParameter("email"));
		return String.valueOf(result);
	}

}
