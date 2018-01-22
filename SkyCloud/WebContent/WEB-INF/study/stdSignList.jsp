<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="/StudyCloud/lib/bootstrap337/css/bootstrap.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/jquery.min.js"></script>
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
</head>
<style>
body{
     	font-style: 맑은 고딕;
    }
.rnav-pills>li.active>a, .rnav-pills>li.active>a:focus, .rnav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: #39d2fd;
	    border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
#footer {
	    width: 100%;
	    position: fixed;
	    bottom: 0;
	}
</style>
<body>
<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<jsp:include page="/WEB-INF/templates/navbar/navbarLogOut.jsp"></jsp:include>
	</div>
	
	<div class="container-fluid" style="margin-top: 70px;">
		<!-- nav tabs -->
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs">
					<li role="presentation" class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">나의 스터디 <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">미드정복!</a></li>
							<li><a href="#">Another action</a></li>
						</ul>
					</li>
					<li class="active"><a href="#">스터디 신청목록</a></li>
				</ul>
			</div>
		</div>
		<!-- nav pills -->
		<div class="row" style="margin-top: 10px">
			<div class="col-md-2">
				<ul class="nav rnav-pills nav-stacked text-center">
					<li class="active"><a href="#">스터디 신청 내역</a></li>
					<li><a href="#">스터디원 수락 목록</a></li>
				</ul>
			</div>
			
			<!-- studySignList -->
			<div style="margin-top: 10px">
				<jsp:include page="/WEB-INF/study/signList.jsp"></jsp:include>
			</div>
			
		</div>
	</div>
	<!-- footer -->	
	<div id="footer">
		<jsp:include page="/WEB-INF/templates/footer.jsp"></jsp:include>
	</div>
</body>
</html>