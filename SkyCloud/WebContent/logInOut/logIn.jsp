<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Study Cloud 로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	i { color:#39d2fd }
	.input-group-addon, button.text-info { background:none; border: none; }
	div.input-group { padding: 5px; }
	
</style>
<script>
	function fnLogIn() {
		window.parent.closeModal();
		window.parent.location.reload();
	}

	function fnPopupFailReason(reason) {
		if(reason == 'noMember') {
			$("div.modal-body")[0].innerHTML = "가입하지 않은 email입니다.";
		} else {
			$("div.modal-body")[0].innerHTML = "비밀번호를 잘못 입력했습니다.";
		}
		$("#failLogIn").modal();
	}
</script>
</head>
<body>	
	<div class="container-fluid" style="margin-top:50px">
		<div class="row" align="center">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<form action="/StudyCloud/main" method="post" class="form-horizontal">
					<input type="hidden" name="command" value="LOGIN">
					<div style="padding:10px">
						<img alt="logo" src="/StudyCloud/images/icons/navbar_logo.png">
					</div>
					<div class="input-group">
						<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
						<input id="email" type="text" class="form-control" name="email" placeholder="이메일을 입력하세요">
				    </div>
				    <div class="input-group">
				      	<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
				      	<input id="pw" type="password" class="form-control" name="pw" placeholder="비밀번호를 입력하세요">
				    </div>
				    <div class="form-group">
				    	<label class="text-info">
				    		<input type="checkbox" name="rememberEmail">이메일 기억하기
				    	</label>
				    </div>
				    <div class="form-group">
				    	<button class="btn btn-info" type="submit">로그인</button>
				    </div>
				    <div class="form-group">
				    	<button type="button" class="text-info">비밀번호 찾기</button>
				    </div>
				</form>
			</div>
			<div class="col-md-2"></div>
		</div>
		
		<!-- 로그인 실패 결과 확인 모달 -->
		<div class="modal fade" id="failLogIn" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<i class="fa fa-cloud" style="font-size:24px;color:#39d2fd"><strong>로그인</strong></i>
					</div>
					<div class="modal-body">
						가입하지 않은 email입니다.
					</div>
					<div class="modal-footer">
						<button class="btn btn-danger" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 로그인 결과 처리 -->
		<c:if test="${! (empty logInResult)}">
			<c:choose>
				<c:when test="${logInResult == 'success'}">
					<script>fnLogIn();</script>
				</c:when>
				<c:otherwise>
					<script>fnPopupFailReason('${logInResult}');</script>
				</c:otherwise>
			</c:choose>
		</c:if>
			
	</div>
</body>

</html>