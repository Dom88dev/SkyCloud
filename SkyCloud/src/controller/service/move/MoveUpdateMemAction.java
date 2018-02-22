package controller.service.move;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.MemberDao;

public class MoveUpdateMemAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = (String)req.getSession().getAttribute("email");
		
		Member member = new Member();
		MemberDao memberDao = new MemberDao();
		
		member = memberDao.getMemberByEmail(email);
		
		req.setAttribute("member", member);
		
		String bodyInclude = "/upMemInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}
	
}
