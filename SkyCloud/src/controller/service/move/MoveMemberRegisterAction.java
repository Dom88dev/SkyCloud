package controller.service.move;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;

//회원가입화면으로 이동
public class MoveMemberRegisterAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bodyInclude = "/register.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
