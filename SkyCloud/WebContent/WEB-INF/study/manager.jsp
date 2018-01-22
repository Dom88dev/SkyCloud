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
<style>
	.rlist-group-item {
		width: 70%;
		position: relative;
	    display: block;
	    padding: 10px 15px;
	    margin-bottom: -1px;
	    background-color: #fff;
	    border: 0px solid #000;
	}
	.rlist-group-item.active, .rlist-group-item.active:focus, .rlist-group-item.active:hover {
	    z-index: 2;
	    color: #fff;
	    background-color: #39d2fd;
	    border-color: #39d2fd;
	}
	.rlist-group-item:first-child {
	    border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
	.rnav-pills>li.active>a, .rnav-pills>li.active>a:focus, .rnav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: #39d2fd;
	    border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
    body{
     	font-style: 맑은 고딕;
    }
	.name-tag {
		position: relative;
	    display: block;
	    padding: 10px 15px;
	    margin-bottom: -1px;
	    width: 83%;
	    border: 0px solid #000;
		z-index: 2;
		color: #fff;
	    background-color: #39d2fd;
	    border-color: #39d2fd;
		border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
	.rbtn-primary {
	    color: #fff;
	    background-color: #39d2fd;
	    border-color: #03c6fc;
	}
	#footer {
	    width: 100%;
	    bottom: 0;
	}
	
</style>
</head>
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
					<li role="presentation" class="active dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">나의 스터디 <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">미드정복!</a></li>
							<li><a href="#">Another action</a></li>
						</ul>
					</li>
					<li><a href="#">스터디 신청목록</a></li>
				</ul>
			</div>
		</div>
		<!-- nav pills -->
		<div class="row" style="margin-top: 10px">
			<div class="col-md-2" style="border:0px;">
				<ul class="nav rnav-pills nav-stacked text-center">
					<li class="active">
	                <a href="#">스터디 홈</a>
	              </li>
	              <li>
	                <a href="#">공지사항</a>
	              </li>
	              <li>
	                <a href="#">과제</a>
	              </li>
	              <li>
	                <a href="#">출석부</a>
	              </li>
				</ul>
			</div>
			
			<!-- studyHome -->
			<div style="margin-top: 10px">
				<jsp:include page="/studyHome.jsp"></jsp:include>
			</div>
			
		</div>
	</div>
	<!-- footer -->	
			<div id="footer">
				<jsp:include page="/WEB-INF/templates/footer.jsp"></jsp:include>
			</div>
</body>
</html>