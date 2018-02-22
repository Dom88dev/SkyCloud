<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	button.close {
		margin-top: 3px; margin-right: 5px;
	}
</style>
</head>
<body>
	<c:if test="${empty bodyInclude }">

		<c:if test="${empty Loaded }">
			<c:redirect url="/fwd">
				<c:param name="command" value="LOADSTUDYLIST"></c:param>
			</c:redirect>
		</c:if>
	</c:if>
	
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<c:choose>
			<c:when test="${empty sessionScope.email }">
				<jsp:include page="/WEB-INF/templates/navbar/navbarLogOut.jsp"></jsp:include>
			</c:when>
			<c:otherwise>
				<jsp:include page="/WEB-INF/templates/navbar/navbarLogIn.jsp"></jsp:include>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="container-fluid" style="margin-top:50px">
		<div class="row">
	<!--  body -->	
			<div id="body" style="min-height: 700px">
				<jsp:include page="${bodyInclude}"></jsp:include>
			</div>
			
		<!-- footer -->	
			<div id="footer">
				<jsp:include page="/WEB-INF/templates/footer.jsp"></jsp:include>
			</div>
			
		<!-- 로그인 모달창 -->
			<div class="modal fade" id="logInModal" data-backdrop="static">
				<div class="modal-dialog">
					<div class="modal-content">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<iframe src="/StudyCloud/logInOut/logIn.jsp" width="100%" height="500px" style="border:none"></iframe>
					</div>
				</div>
			</div>
			
		<!-- 로그아웃 모달창 -->
			<div class="modal fade" id="logOutModal" data-backdrop="static">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<iframe src="/StudyCloud/logInOut/logOut.jsp" width="100%" height="100px" style="border:none"></iframe>
					</div>
				</div>
			</div>
			
		<!-- 로그아웃 상태시 스터디 등록 모달창 -->	
	 		<div class="modal fade" id="logOutStdModal" data-backdrop="static">
	 			<div class="modal-dialog modal-sm">
	 				<div class="modal-content">
	 					<div class="modal-body">
							<h4 style="text-align: center;color: #6e6e6e">로그인이 필요합니다.</h4>
		 					<div style="text-align: center;padding-top: 20px">
		 						<button class="btn btn-primary" data-dismiss="modal" style="background: #39d2fd;border: 0;">닫기</button>
		 					</div>
		 				</div>
	 				</div>
	 			</div>
	 		</div>
	 		
	 		
	 	<!-- 진행중인 스터디가 없을 시 나의 스터디 모달창 -->	
	 		<div class="modal fade" id="noStdModal" data-backdrop="static">
	 			<div class="modal-dialog modal-sm">
	 				<div class="modal-content">
	 					<div class="modal-body">
							<h4 style="text-align: center;color: #6e6e6e">스터디를 등록하거나 가입하세요.</h4>
		 					<div style="text-align: center;padding-top: 20px">
		 						<button class="btn btn-primary" data-dismiss="modal" style="background: #39d2fd;border: 0;">닫기</button>
		 					</div>
		 				</div>
	 				</div>
	 			</div>
	 		</div>
	 		
		</div>
	</div>
	
	<c:if test="${!(empty havingStudy)}"><script>$("#noStdModal").modal();</script></c:if>
	
</body>
<script>
	window.closeModal = function(){
	    $('#logInModal').modal('hide');
	    $('#logOutModal').modal('hide');
	    $("#HWF_UploadModal").modal("hide");
	};
	
</script>
</html>