package controller.service.move;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;

//매니저 메뉴의 선택된 스터디메뉴가 변경될 시 화면의 변경 처리
public class ChangeManagerStudyMenuAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		System.out.println(req.getParameter("index") + "/" + req.getParameter("includeStdMenu"));
		req.getSession().setAttribute("index", req.getParameter("index"));
		req.getSession().setAttribute("includeStdMenu", req.getParameter("includeStdMenu"));
		return "/StudyCloud/studyManagingMenu/";
	}

}
