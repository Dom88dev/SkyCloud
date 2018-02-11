package controller.service.delete;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.MemberDao;

//회원 탈퇴 처리
public class DeleteMemberAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Member mem = new Member();
		mem.setEmail(req.getParameter("email"));

		MemberDao memDao = new MemberDao();
		int res = memDao.UpdateMemInfo(mem);
		req.setAttribute("delInfoResult", res);
		String bodyInclude = "/delMemInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
