package controller.service;

import controller.service.create.InsertAttendaceAction;
import controller.service.create.InsertReplyAction;
import controller.service.create.InsertRereplyAction;
import controller.service.create.InsertStudyApplyAction;
import controller.service.create.RegisterHomeworkAction;
import controller.service.create.RegisterMemberAction;
import controller.service.create.RegisterNoticeAction;
import controller.service.create.RegisterStudyAction;
import controller.service.delete.DeleteBoardAction;
import controller.service.delete.DeleteMemberAction;
import controller.service.delete.DeleteReplyAction;
import controller.service.move.ChangeManagerStudyMenuAction;
import controller.service.move.LogOutAction;
import controller.service.move.MoveBoardRegisterAction;
import controller.service.move.MoveBoardUpdateAction;
import controller.service.move.MoveLeaderCalendarAction;
import controller.service.move.MoveMemberCalendarAction;
import controller.service.move.MoveMemberRegisterAction;
import controller.service.move.MoveReadBoardByMessageAction;
import controller.service.move.MoveStudyManagerAction;
import controller.service.move.MoveStudyRegisterAction;
import controller.service.move.MoveStudyUpdateAction;
import controller.service.read.LoadAttendanceImageAction;
import controller.service.read.LoadAttendanceStatusAction;
import controller.service.read.LoadCountAttendaceAction;
import controller.service.read.LoadHomeworksForStudyHomeworkAction;
import controller.service.read.LoadLogInInfoAction;
import controller.service.read.LoadNoticesForStudyNoticeAction;
import controller.service.read.LoadRecentStudyListAction;
import controller.service.read.LoadSearchStudyAction;
import controller.service.read.LoadStudyInfoAction;
import controller.service.read.LoadStudyInfoForStudyHomeAction;
import controller.service.read.ReadStudyHomeworkAction;
import controller.service.read.ReadStudyNoticeAction;
import controller.service.read.validity.ValidateMemberEmailAction;
import controller.service.read.validity.ValidateMemberNameAction;
import controller.service.read.validity.ValidateMemberTelAction;
import controller.service.read.validity.ValidateStudyNameAction;
import controller.service.update.UpdateAttendanceAction;
import controller.service.update.UpdateHomeworkAction;
import controller.service.update.UpdateMemberAction;
import controller.service.update.UpdateNoticeAction;
import controller.service.update.UpdateReplyAction;
import controller.service.update.UpdateStudyAction;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();
	
	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		switch(command) {
		case "LOADSTUDYLIST"://메인페이지에 스터디 목록 로딩 작업
			action = new LoadRecentStudyListAction();
			break;
		case "GOREGISTER"://회원가입화면으로 이동
			action = new MoveMemberRegisterAction();
			break;
		case "REGIMEMBER"://회원가입 처리 작업
			action = new RegisterMemberAction();
			break;
		case "LOGIN"://로그인 처리 작업
			action = new LoadLogInInfoAction();
			break;
		case "LOGOUT"://로그아웃 처리 작업 - modal이기 때문에 url을 변경
			action = new LogOutAction();
			break;
		case "GOSTDREGISTER"://스터디등록화면으로 이동
			action = new MoveStudyRegisterAction();
			break;
		case "REGISTUDY"://스터디 등록 처리 작업
			action = new RegisterStudyAction();
			break;
		case "GETSTUDYINFO"://스터디 상세 정보 처리
			action = new LoadStudyInfoAction();
			break;
		case "SEARCHSTUDY"://스터디 검색 처리
			action = new LoadSearchStudyAction();
			break;
		case "GOMNGSTUDY"://스터디 매니징 클라우드로 이동
			action = new MoveStudyManagerAction();
			break;
		case "UPDATEMEM": //회원 수정 처리 - 미완성
			action = new UpdateMemberAction();
			break;
		case "DELETEMEM": //회원 탈퇴 처리 - 미완성
			action = new DeleteMemberAction();
			break;
		case "STUDYUPDATEINFO": // 스터디 수정 페이지 이동 및 값 전달 처리
			action = new MoveStudyUpdateAction();
			break;
		case "STUDYUPDATE": //스터디 수정 처리
			action = new UpdateStudyAction();
			break;
		case "VALIDITYTEST_REGISTER_EMAIL":// 이메일 중복 검사 Ajax
			action = new ValidateMemberEmailAction();
			break;
		case "VALIDITYTEST_REGISTER_NAME":// 닉네임 중복 검사 Ajax
			action = new ValidateMemberNameAction();
			break;
		case "VALIDITYTEST_REGISTER_TEL":// 연락처 중복 검사 Ajax
			action = new ValidateMemberTelAction();
			break;
		case "STD_VALID_REGISTER_STDNAME":// 스터디 등록 시 이메일를 이용하여 스터디명 중복 검사 Ajax
			action = new ValidateStudyNameAction();
			break;
		case "CHECKATT": // 출석버튼 눌렀을때 작업
			action = new InsertAttendaceAction();
			break;
		case "CNTSTATUS": // 출결 상황 카운트
			action = new LoadCountAttendaceAction();
			break;
		case "GET_ATTSTATUS": // 출결 가져오기
			action = new LoadAttendanceStatusAction();
			break;
		case "UPDATE_STATUS": // 출결 업데이트
			action = new UpdateAttendanceAction();
			break;
		case "LOADSTATUSIMG": // 멤버 캘린더 출석이미지
			action = new LoadAttendanceImageAction();
			break;
		case "MNG_CHANGESTUDY"://매니저 메뉴의 선택된 스터디메뉴가 변경될 시
			action = new ChangeManagerStudyMenuAction();
			break;
		case "LOADSTUDYINFO"://매니저 스터디홈 화면 선택시
			action = new LoadStudyInfoForStudyHomeAction();
			break;
		case "LOADNOTICE"://매니저 공지사항 화면 선택시
			action = new LoadNoticesForStudyNoticeAction();
			break;
		case "LOADHOMEWORK"://매니저 과제화면 선택시
			action = new LoadHomeworksForStudyHomeworkAction();
			break;
		case "WRITEBOARD":// 게시판(공지사항/과제) 등록 화면으로 이동
			action = new MoveBoardRegisterAction();
			break;
		case "UPDATEBOARD":// 게시글(공지사항/과제) 수정
			action = new MoveBoardUpdateAction();
			break;
		case "DELETEBOARD":// 게시글(공지사항/과제) 삭제처리
			action = new DeleteBoardAction();
			break;
		case "READNOTICE": //특정 공지사항 읽기
			action = new ReadStudyNoticeAction();
			break;
		case "READHOMEWORK": //특정 과제글 읽기
			action = new ReadStudyHomeworkAction();
			break;
		case "LOADLEADERCALENDAR"://스터디 출석화면 로드(스터디장)
			action = new MoveLeaderCalendarAction();
			break;
		case "LOADMEMCALENDAR"://스터디 출석화면 로드(스터디원)
			action = new MoveMemberCalendarAction();
			break;
		case "POSTNOTICE":// 공지사항 등록
			action = new RegisterNoticeAction();
			break;
		case "POSTHOMEWORK":// 과제 등록
			action = new RegisterHomeworkAction();
			break;
		case "UPDATENOTICE":// 공지사항 수정
			action = new UpdateNoticeAction();
			break;
		case "UPDATEHOMEWORK":// 과제글 수정
			action = new UpdateHomeworkAction();
			break;
		case "STUDYAPPLY":// 스터디 신청
			action = new InsertStudyApplyAction();
			break;
		case "REPLY"://댓글달기
			action = new InsertReplyAction();
			break;
		case "REREPLY"://대댓글달기
			action = new InsertRereplyAction();
			break;
		case "MODIFYREPLY"://댓글 수정
			action = new UpdateReplyAction();
			break;
		case "DELETEREPLY"://댓글 삭제
			action = new DeleteReplyAction();
			break;
		case "GOTOBOARD"://쪽지에서 댓글알림 클릭시 해당 보드 화면으로 이동
			action = new MoveReadBoardByMessageAction();
			break;
		}
		return action;
	}
}
