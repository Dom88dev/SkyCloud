<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	#myCarousel { height: 500px }
	.item { background:#39d2fd }
	a.right.carousel-control, a.left.carousel-control {
	    background-image: none;
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
		</div>
	</div>
</body>	
</html>