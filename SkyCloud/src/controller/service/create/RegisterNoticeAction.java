package controller.service.create;

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

public class RegisterNoticeAction implements MultipartAction {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String execute(MultipartRequest multi) throws ServletException, IOException {
		Notice notice = new Notice();
		BoardFile bf = new BoardFile();
		notice.setB_datetime(System.currentTimeMillis());
		notice.setStd_id(Integer.parseInt(multi.getParameter("stdId")));
		notice.setTitle(multi.getParameter("title"));
		notice.setContent(multi.getParameter("content"));
		Enumeration<?> fileNames = multi.getFileNames();
		int fileNum = 0;
		while (fileNames.hasMoreElements()) {
			String fName = (String) fileNames.nextElement();
			fileNum++;
			if (fName == null || fName.equals(""))
				continue;
			if (fileNum == 1) {
				bf.setB_file1_name(multi.getOriginalFileName(fName));
				bf.setB_file1("/upload" + multi.getFilesystemName(fName));
			} else if (fileNum == 2) {
				bf.setB_file2_name(multi.getOriginalFileName(fName));
				bf.setB_file2("/upload" + multi.getFilesystemName(fName));
			} else if (fileNum == 3) {
				bf.setB_file3_name(multi.getOriginalFileName(fName));
				bf.setB_file3("/upload" + multi.getFilesystemName(fName));
			}
		}
		BoardDao boardDao = new BoardDao();
		int postResult = boardDao.insertNotice(notice);
		if(postResult>0) {
			postResult = boardDao.getB_IdFromNotice(notice);
		}
		postResult = boardDao.insertBoardFile(postResult, bf);
		return "/main?command=GOMNGSTUDY&postResult="+postResult;
	}

}
