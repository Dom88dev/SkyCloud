package controller.service.read.validity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.MemberDao;

//닉네임 중복 검사 Ajax
public class ValidateMemberNameAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		String name = req.getParameter("name");
		MemberDao memDao = new MemberDao();
		int result = memDao.getValidName(name);
		return String.valueOf(result);
	}

}
