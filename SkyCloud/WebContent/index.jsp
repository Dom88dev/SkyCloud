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
			<c:redirect url="/main">
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
			<div id="body">
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
			
		</div>
	</div>
</body>
<script>
	window.closeModal = function(){
	    $('#logInModal').modal('hide');
	    $('#logOutModal').modal('hide');
	};
	
</script>
</html>