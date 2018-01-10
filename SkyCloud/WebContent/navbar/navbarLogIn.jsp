<%@page import="java.net.InetAddress"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>navbar before logging in</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../bootstrap337/css/bootstrap.min.css" />
<script src="../bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="../bootstrap337/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:useBean id="refer" class="references.References"/>
<%
	InetAddress inet = InetAddress.getLocalHost();
	String svrIP = inet.getHostAddress();
	int svrPort = request.getServerPort();
	String ipPort = svrIP+":"+svrPort;
%>
<jsp:setProperty property="path" name="refer" value="<%=ipPort %>"/>
	<!-- navbar -->
	<nav class="navbar navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="<%=refer.getPath()%>index.jsp">
					<img alt="Brand" src="<%=refer.getImg_path() %>logo_wh_2.png" height="100%">
				</a>
			</div>
			<form class="navbar-form navbar-left">
				<div class="form-group has-feedback">
					<a style="color:sky" onclick=""><span class="glyphicon glyphicon-search form-control-feedback"></span></a>
					<input type="search" class="form-control" placeholder="input the words you wanna search here"/>
				</div>
			</form>
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a class="navbar-brand dropdown-toggle" data-toggle="dropdown" href="#">
						<img alt="Brand" src="<%=refer.IMG_PATH %>messages.png" height="100%">
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
						<li><a href="#">스터디 등록</a></li>
						<li><a href="#">나의 스터디</a></li>
						<li><a href="#">로그아웃</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>