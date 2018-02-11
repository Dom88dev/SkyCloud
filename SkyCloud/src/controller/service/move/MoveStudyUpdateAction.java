package controller.service.move;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Study;
import persistance.StudyDao;

//스터디 수정 페이지 이동 및 값 전달 처리
public class MoveStudyUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int updateStdId = Integer.parseInt(req.getParameter("stdId"));
		StudyDao stdDao = new StudyDao();
		Study std = stdDao.getStudyInfo(updateStdId);
		req.setAttribute("std", std);
		String bodyInclude = "/stdUpdateRegister.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
