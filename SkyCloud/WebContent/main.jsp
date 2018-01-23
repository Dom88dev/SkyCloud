<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
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

	<div class="container-fluid">
		<div class="row">
			
		<!-- CAROUSEL -->
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner">
					<div class="item active" align="center">
						<img src="/StudyCloud/images/icons/logo_Sky.png" alt="Logo"
							style="height: 400;">
					</div>

					<div class="item" align="center">
						<img src="/StudyCloud/images/icons/logoCloud_Sky.png" alt="Chicago"
							style="height: 400;">
					</div>

					<div class="item" align="center">
						<img src="/StudyCloud/images/icons/logo_Sky.png" alt="New york"
							style="height: 400;">
					</div>
				</div>

				<!-- Left and right controls -->
				<a class="left carousel-control" href="#myCarousel"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
			
		<!-- study list -->
			<h2 class="text-center"><ins class="text-info">STUDY</ins></h2>
			<div id="studyList" style="min-height: 500px" align="center">
				<c:choose>
					<c:when test="${empty stdList }">
						<br><br><br><br><br><br>
						<h3 class="text-center">현재 모집중인 스터디가 없습니다.</h3>
					</c:when>
					<c:otherwise>
						<jsp:include page="/WEB-INF/templates/studyList/studyList.jsp"></jsp:include>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</body>
</html>