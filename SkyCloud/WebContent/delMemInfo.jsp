<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel='stylesheet' href="/StudyCloud/lib/bootstrap337/css/form-con.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>

td, tr {
    padding: 10px;
    vertical-align: text-top;
    
  }

.container {
	max-width: 100%
}

.mfont-size {
	font-size: 15px;
}

.mform {
	width: 500px;
	height: auto;
	margin:auto;
}
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
<script>		

	//회원 수정 결과 모달 처리 function
	function fnMemUpdateResultModal(result) {
		if (result > 0) {//성공
			$("#updateMemBtn").click(function() {
				window.location.href = "/StudyCloud/index.jsp";
			});
		} else {//실패
			$("#MemUpdateResultModal div.modal-body")[0].innerHTML = "회원수정 중 문제가 발생했습니다. 잠시 후 다시 등록해 주십시오.";
			$("#MemUpdateResultModal div.modal-footer button").removeClass(
					"btn-info");
			$("#MemUpdateResultModal div.modal-footer button").addClass(
					"btn-danger");
			$("#updateMemBtn").click(function() {
				$("#MemUpdateResultModal").modal("hide");
			});
		}

		$('#MemUpdateResultModal').modal();
	}
	
	
</script>
</head>
<body>
		
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<jsp:include page="/WEB-INF/templates/navbar/navbarLogIn.jsp"></jsp:include>
	</div>
	
	<div class="container" style="margin-top:100px;">
		<div class="row">
		
		<!-- 회원가입 폼 -->
			<form id="updateForm" action="/StudyCloud/fwd" class="form-horizontal" method="post">
				<input type="hidden" name="command" value="DELETEMEM">
				<div class="container">
					<div class="container">
						<div class="mform">
							<div>
							
						<!-- 로고  -->
						
								<div>
									<div style="border: 0">
										<div align="center">
											<img alt="로고" src="/StudyCloud/images/icons/navbar_logo.png">
										</div>
									</div>
								</div>
								
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
						<!-- 비밀번호 확인 입력란 -->	
						
								<div class="form-group has-success has-feedback">
									<div align="center" style="margin-top:10px;margin-bottom:10px">
										회원탈퇴를 원하시면 비밀번호를 입력하신 후 회원탈퇴 버튼을 클릭해 주세요.<br>
										탈퇴하시면 회원정보가 데이터베이스에서 완전히 삭제됩니다.
									</div>
								</div>
								
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
		
						
						<!-- 비밀번호 입력란 -->	
								
								<div class="form-group has-success has-feedback">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">비밀번호</strong></label>
									</div>
									<div class="col-sm-9">
										<input type="password" id="pw" name="pw" class="mform-control" style="width: 100%;font-size:15px; border: 1px solid #39d2fd;"  required="required"/>
										<div id="pwValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
								</div>
								
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								
											
						<!-- 회원 탈퇴 버튼  -->		
								
								<div>
									<div align="center">
										<button id="registerbtn" type="submit" style="width: 100%;height: 50px; border: 0;background-color:#39d2fd;color: white;margin: auto;">회원 탈퇴</button>
									</div>
								</div>
								
								<div>
									<div>
									<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px double #ffffff"></div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
</div>
		
		<!-- 회원 수정 결과 모달창 -->
			<div class="modal fade" id="MemUpdateResultModal" data-backdrop="static">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<i class="fa fa-cloud" style="font-size:24px;color:#39d2fd"><strong>회원 수정</strong></i>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							회원 정보 수정에 성공하셨습니다.
						</div>
						<div class="modal-footer">
							<button class="btn btn-info" id="updateMemBtn">확인</button>
						</div>
					</div>
				</div>
			</div>
	<!-- 회원가입 결과 처리 -->
	<c:if test="${!(empty upInfoResult)}">
		<script>fnMemUpdateResultModal('${upInfoResult}');</script>
	</c:if>
	
</body>
</html>
























