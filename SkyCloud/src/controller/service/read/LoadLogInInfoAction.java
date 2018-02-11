package controller.service.read;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.MemberDao;

//로그인 처리 작업 - modal이기 때문에 url을 변경
public class LoadLogInInfoAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDao memDao = new MemberDao();
		Member mem = memDao.getMemberByEmail(req.getParameter("email"));
		if(mem.getPw()!=null) {
			if(mem.getPw().equals(req.getParameter("pw"))) {
				req.getSession().setAttribute("email", mem.getEmail());
				req.setAttribute("logInResult", "success");
			} else {
				req.setAttribute("logInResult", "wrongPw");
			}
		} else {
			req.setAttribute("logInResult", "noMember");
		}
		return "/logInOut/logIn.jsp";
	}

}
