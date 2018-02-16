package controller.service.update;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import controller.service.MultipartAction;
import model.BoardFile;
import model.Notice;
import persistance.BoardDao;

// 공지사항 수정
public class UpdateNoticeAction implements MultipartAction {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute(MultipartRequest multi) throws ServletException, IOException {
		Notice notice = new Notice();
		notice.setB_id(Integer.parseInt(multi.getParameter("bId")));
		notice.setContent(multi.getParameter("content"));
		notice.setTitle(multi.getParameter("title"));
		BoardFile bf = new BoardFile();
		boolean b1 = multi.getParameter("isChangedFile1").equals("true");
		boolean b2 = multi.getParameter("isChangedFile2").equals("true");
		boolean b3 = multi.getParameter("isChangedFile3").equals("true");
		Enumeration<?> fileNames = multi.getFileNames();
		int fileNum = 4;
		while(fileNames.hasMoreElements()) {
			String fName = (String)fileNames.nextElement();
			fileNum--;
			if(fName == null || fName.equals("")) continue;
			if(fileNum==1) {
				if(b1) {
					bf.setB_file1_name(multi.getOriginalFileName(fName));
					bf.setB_file1(multi.getFilesystemName(fName));
				}						
			} else if (fileNum==2) {
				if(b2) {
					bf.setB_file2_name(multi.getOriginalFileName(fName));
					bf.setB_file2(multi.getFilesystemName(fName));
				}
			} else if(fileNum==3) {
				if(b3) {
					bf.setB_file3_name(multi.getOriginalFileName(fName));
					bf.setB_file3(multi.getFilesystemName(fName));
				}
			}
		}
		bf.setB_id(notice.getB_id());
		BoardDao boardDao = new BoardDao();
		int updateResult = boardDao.updateNotice(notice);
		if(updateResult>0) updateResult = boardDao.updateBoardFile(bf, b1, b2, b3);
		System.out.println("보드파일 수정 결과 : "+updateResult);
		return "/fwd?command=GOMNGSTUDY&updateResult="+updateResult;
	}

}
