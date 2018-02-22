package controller.service.delete;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.service.Action;
import persistance.BoardDao;
import util.Util;

//게시글(공지사항/과제) 삭제처리
public class DeleteBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDao boardDao = new BoardDao();
		int deleteResult = boardDao.deleteBoardFile(Integer.parseInt(req.getParameter("b_id")));
		String file1 = req.getParameter("file1");
		String file2 = req.getParameter("file2");
		String file3 = req.getParameter("file3");
		if(file1!=null&&!file1.isEmpty()) Util.removeFile(file1);
		if(file2!=null&&!file2.isEmpty()) Util.removeFile(file2);
		if(file3!=null&&!file3.isEmpty()) Util.removeFile(file3);
		System.out.println("보드file 삭제 결과 : "+deleteResult);
		deleteResult = boardDao.deleteBoard(Integer.parseInt(req.getParameter("b_id")));
		System.out.println("보드 삭제 결과 : "+deleteResult);
		return "/fwd?command=GOMNGSTUDY&deleteResult="+deleteResult;
	}

}
