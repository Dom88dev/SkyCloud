<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap337/css/bootstrap.min.css" />
<script src="bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="bootstrap337/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:useBean id="refer" class="references.References"></jsp:useBean>
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<jsp:include page="navbar/navbarLogOut.jsp"></jsp:include>
	</div>


	<!--  body -->
	<div class="container" style="margin-top:50px">
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
					<div class="item active">
						<img src="<%=refer.IMG_PATH %>logo_wh_2.png" alt="Logo"
							style="width: 100%;">
					</div>

					<div class="item">
						<img src="<%=refer.IMG_PATH %>logo_wh_2.png" alt="Chicago"
							style="width: 100%;">
					</div>

					<div class="item">
						<img src="<%=refer.IMG_PATH %>logo_wh_2.png" alt="New york"
							style="width: 100%;">
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
			<div>
				
			</div>
		</div>
	</div>
</body>
</html>