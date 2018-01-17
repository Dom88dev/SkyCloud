<%@page import="java.net.InetAddress"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>navbar before logging in</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/SkyCloud/bootstrap337/css/bootstrap.min.css" />
<script src="/SkyCloud/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/SkyCloud/bootstrap337/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- navbar -->
	<nav class="navbar navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/SkyCloud/index.jsp">
					<img alt="Brand" src="/SkyCloud/WEB-INF/images/icons/navbar_logo.png" height="100%">
				</a>
			</div>
			<form class="navbar-form navbar-left">
				<div class="form-group has-feedback">
					<a style="color:sky" onclick=""><span class="glyphicon glyphicon-search form-control-feedback"></span></a>
					<input type="search" class="form-control" placeholder="검색할 스터디를 입력하세요"/>
				</div>
			</form>
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a class="navbar-brand dropdown-toggle" data-toggle="dropdown" href="#">
						<img alt="Brand" src="/SkyCloud/WEB-INF/images/icons/message.png" height="100%">
					</a>
					<ul class="dropdown-menu" >
						<li><a href="#">쪽지1</a></li>
						<li><a href="#">쪽지2</a></li>
						<li><a href="#">쪽지3</a></li>
					</ul>
				</li>
			</ul>
			<a href="#" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</a>
			<div class="navbar-inner">
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="text-info"><a href="#">스터디 등록</a></li>
						<li class="text-info"><a href="#">나의 스터디</a></li>
						<li class="text-info"><a href="#">로그아웃</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>