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
	    position: fixed;
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
		<div class="row" style="margin-top: 10px">
			<div class="col-md-2" style="border:0px">
				<ul class="list-group text-center">
					<li class="rlist-group-item active">스터디 홈</li>
					<li class="rlist-group-item"><a href="#">공지사항</a></li>
					<li class="rlist-group-item"><a href="#">과제</a></li>
					<li class="rlist-group-item"><a href="#">출석부</a></li>
				</ul>
			</div>
			<div class="col-md-7">
				<div class="col-md-3">
					<h4 class="name-tag">
						<span class="glyphicon glyphicon-cloud"></span>미드 홀릭
					</h4>
					<h5>010-1234-5678</h5>
				</div>
				<div class="col-md-9 text-center">
					<h2>[어학]미드 정복 !</h2>
					<h5>
						2018.01.03~2018.04.08 <small>&nbsp;1/10명</small>
					</h5>
				</div>
				<div class="col-md-6 ">
					<h3>소개</h3>
					<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
						Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque
						penatibus et magnis dis parturient montes, nascetur ridiculus
						mus..</p>
				</div>
				<div class="col-md-6">
					<h3>장소 및 시간</h3>
					<p>
						Lorem ipsum dolor sit amet, consectetur adipisici elit, <br>sed
						eiusmod tempor incidunt ut labore et dolore magna aliqua. <br>Ut
						enim ad minim veniam, quis nostrud
					</p>
				</div>
				<div class="col-md-6">
					<h3>스터디 계획</h3>
					<p>
						Lorem ipsum dolor sit amet, consectetur adipisici elit, <br>sed
						eiusmod tempor incidunt ut labore et dolore magna aliqua. <br>Ut
						enim ad minim veniam, quis nostrud
					</p>
				</div>
				<div class="col-md-6">
					<h3>참고 사항</h3>
					<p>
						Lorem ipsum dolor sit amet, consectetur adipisici elit, <br>sed
						eiusmod tempor incidunt ut labore et dolore magna aliqua. <br>Ut
						enim ad minim veniam, quis nostrud
					</p>
				</div>
			</div>
			<div class="col-md-3">
				<div class="col-md-12 ">
					<a class="btn btn-lg rbtn-primary">출석체크</a>
				</div>
				<div class="col-md-12 ">
					<br>
					<ul class="list-group">
						<li class="rlist-group-item active">공지사항
						</li>
						<li class="rlist-group-item ">공지사항 1</li>
						<li class="rlist-group-item ">공지사항 2</li>
						<li class="rlist-group-item ">공지사항 3</li>
					</ul>
				</div>
				<div class="col-md-12 ">
					<ul class="list-group ">
						<li class="rlist-group-item active">과제 </li>
						<li class="rlist-group-item ">과제 1</li>
						<li class="rlist-group-item ">과제 2</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- footer -->	
			<div id="footer">
				<jsp:include page="/WEB-INF/templates/footer.jsp"></jsp:include>
			</div>
</body>
</html>