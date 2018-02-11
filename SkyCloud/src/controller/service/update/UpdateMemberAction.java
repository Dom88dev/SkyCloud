package controller.service.update;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.MemberDao;

//회원 수정 처리
public class UpdateMemberAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Member mem = new Member();

		mem.setPw(req.getParameter("pw"));
		mem.setName(req.getParameter("name"));
		mem.setTel(req.getParameter("tel"));

		MemberDao memDao = new MemberDao();
		int rs = memDao.UpdateMemInfo(mem);
		req.setAttribute("upInfoResult", rs);
		String bodyInclude = "/upMemInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
