package controller.service.create;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.MemberDao;
import util.Util;

//회원가입 처리 작업
public class RegisterMemberAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Member mem = new Member();
		mem.setMember(req.getParameter("email"), req.getParameter("pw"), req.getParameter("name"), req.getParameter("tel"),
				req.getParameter("gender")==null?"M":"F", Util.transDate(req.getParameter("born")));
		MemberDao memDao = new MemberDao();
		int result = memDao.insertMember(mem);
		req.setAttribute("RegisterResult", result);
		System.out.println("회원가입 처리 작업 : "+result);
		String bodyInclude = "/register.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
