package controller.service.delete;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.BoardDao;

//게시글(공지사항/과제) 삭제처리
public class DeleteBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDao boardDao = new BoardDao();
		int deleteResult = boardDao.deleteBoardFile(Integer.parseInt(req.getParameter("b_id")));
		System.out.println("보드file 삭제 결과 : "+deleteResult);
		deleteResult = boardDao.deleteBoard(Integer.parseInt(req.getParameter("b_id")));
		System.out.println("보드 삭제 결과 : "+deleteResult);
		return "/fwd?command=GOMNGSTUDY&deleteResult="+deleteResult;
	}

}
