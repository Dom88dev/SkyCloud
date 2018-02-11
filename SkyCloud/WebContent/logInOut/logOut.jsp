<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Study Cloud 로그아웃</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	#no { background:white; color:#39d2fd; }
	button{margin:5px}
</style>
<script>
	function fnCancelLogout(){
		window.parent.closeModal();
	}
	
	function fnConfirmLogOut() {
		window.parent.closeModal();
		window.parent.location = "/StudyCloud/index.jsp";
	}
</script>
</head>
<body>
	<c:if test="${! (empty logout) }">
		<c:if test="${logout}">
			<script>fnConfirmLogOut();</script>
		</c:if>
	</c:if>
	<div class="container-fluid">
		<div class="row" align="center">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<div>
					<h5 class="text-info">정말 로그아웃 하시겠습니까?</h5>
				</div>
				<div>
					<form action="/StudyCloud/fwd" method="post" class="form-horizontal">
						<input type="hidden" name="command" value="LOGOUT">
						<button id="yes" type="submit" class="btn btn-info">네</button>
						<button id="no" type="button" class="btn" onclick="fnCancelLogout()">아니오</button>
					</form>
				</div>
			</div>
			<div class="col-sm-2"></div>
		</div>	
	</div>
</body>
</html>