package controller.service.delete;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import model.Member;
import persistance.ApplyDao;
import persistance.AttendanceDao;
import persistance.MemberDao;
import persistance.ReplyDao;
import persistance.StudyDao;

//회원 탈퇴 처리
public class DeleteMemberAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDao memDao = new MemberDao();
		Member mem = new Member();
		ApplyDao applyDao = new ApplyDao();
		AttendanceDao attendanceDao = new AttendanceDao();
		ReplyDao replyDao = new ReplyDao();
		StudyDao studyDao = new StudyDao();
		
		String email = (String)req.getSession().getAttribute("email");
		String pwd = req.getParameter("pw");
		mem.setEmail(email);
		
		int pwdResult = memDao.getPwd(pwd);
		
		if(pwdResult==1){
			applyDao.deleteApplyByEmail(email);
			attendanceDao.deleteAttendanceByEmail(email);
			replyDao.deleteReplyByWriter(email);
			studyDao.deleteStudyByEmail(email);
			int res = memDao.deleteMem(mem);
			req.setAttribute("delInfoResult", res);
		}else{
			req.setAttribute("delInfoResult", 0);
		}

		String bodyInclude = "/delMemInfo.jsp";
		req.setAttribute("bodyInclude", bodyInclude);
		return "/index.jsp";
	}

}
