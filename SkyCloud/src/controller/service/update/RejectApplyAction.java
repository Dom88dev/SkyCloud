package controller.service.update;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.service.Action;
import persistance.ApplyDao;

public class RejectApplyAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		int apply_id = Integer.parseInt(req.getParameter("apply_id"));
		ApplyDao applyDao = new ApplyDao();
		applyDao.updateApply(apply_id, "reject", "sorry", req.getParameter("apply_email"));
		session.setAttribute("currentTab", "applyList");
		return "/fwd?command=GOMNGSTUDY";
	}

}
