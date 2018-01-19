<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/SkyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/SkyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/SkyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	#myCarousel { height: 500px }
	.item { background:#39d2fd }
</style>
</head>
<body>	
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<jsp:include page="/WEB-INF/templates/navbar/navbarLogOut.jsp"></jsp:include>
	</div>


	<!--  body -->
	<div class="container-fluid" style="margin-top:50px">
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
						<img src="/SkyCloud/images/icons/logo_Sky.png" alt="Logo"
							style="height: 400;">
					</div>

					<div class="item" align="center">
						<img src="/SkyCloud/images/icons/logoCloud_Sky.png" alt="Chicago"
							style="height: 400;">
					</div>

					<div class="item" align="center">
						<img src="/SkyCloud/images/icons/logo_Sky.png" alt="New york"
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
			<div id="studyList" style="min-height: 500px">
				<jsp:include page="/WEB-INF/templates/studyList/studybrief.jsp"></jsp:include>
			</div>
			
		<!-- footer -->	
			<div id="footer">
				<jsp:include page="/WEB-INF/templates/footer.jsp"></jsp:include>
			</div>
		</div>
	</div>
</body>
</html>