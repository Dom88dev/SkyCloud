<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Study Cloud �α׾ƿ�</title>
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
		self.close();
	}
	
	function fnConfirmLogOut() {
		opener.parent.location.reload();
		window.close();
	}
</script>
</head>
<body>
	<c:if test="${! (empty logout) }">
		<c:if test="${logout}">
			<script>fnConfirmLogOut();</script>
		</c:if>
	</c:if>
	<div class="container-fluid" style="margin-top:50px">
		<div class="row" align="center">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div>
					<h5 class="text-info">���� �α׾ƿ� �Ͻðڽ��ϱ�?</h5>
				</div>
				<div>
					<form action="/StudyCloud/main" method="post" class="form-horizontal">
						<input type="hidden" name="command" value="LOGOUT">
						<button id="yes" type="submit" class="btn btn-info">��</button>
						<button id="no" type="button" class="btn" onclick="fnCancelLogout()">�ƴϿ�</button>
					</form>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>	
	</div>
</body>
</html>