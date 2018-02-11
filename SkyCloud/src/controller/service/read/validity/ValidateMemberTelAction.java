package controller.service.read.validity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.MemberDao;

//연락처 중복 검사 Ajax
public class ValidateMemberTelAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		String tel = req.getParameter("tel");
		MemberDao memDao = new MemberDao();
		int result = memDao.getValidTel(tel);
		return String.valueOf(result);
	}

}
