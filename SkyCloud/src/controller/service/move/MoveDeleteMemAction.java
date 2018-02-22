package controller.service.move;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;

public class MoveDeleteMemAction implements Action{

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bodyInclude = "/delMemInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}
	
}
