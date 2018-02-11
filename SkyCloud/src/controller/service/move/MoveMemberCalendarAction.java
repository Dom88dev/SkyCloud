package controller.service.move;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;

//스터디 출석화면 로드(스터디원)
public class MoveMemberCalendarAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		return "/StudyCloud/studyManagingMenu/calendar/AtdCalStdmem.jsp";
	}

}
