<%@page import="java.net.InetAddress"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>navbar before logging in</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	#message{color:#39d2fd}
	nav{background-color: white}
	.nav-search-input {
		background-color: none;
		border:none;
	}
	
	.nav-search-input:focus {
		background-color: none;
		border:none;
		outline:none;
	}

</style>
<script>
	function clickMsg() {
		window.open("/WEB-INF/templates/msg/message.jsp", "쪽지함", "width=300, height=400");
	}
	
	function fnLogOut() {
		$("#logOutModal").modal();
	}
</script>
</head>
<body>
	<!-- navbar -->
	<nav class="navbar navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/StudyCloud/index.jsp">
					<img alt="Brand" src="/StudyCloud/images/icons/navbar_logo.png" height="100%">
				</a>
			</div>
			<form class="navbar-form navbar-left" action="/StudyCloud/main" method="post">
				<input type="hidden" name="command" value="SEARCHSTUDY"/>
				<div class="form-group form-control">
					<input type="search" class="nav-search-input" placeholder="검색할 스터디를 입력하세요" name="searchTxt"/>
					<a style="color:sky" href="javascript:fnSearchStudy();"><span class="glyphicon glyphicon-search"></span></a>
				</div>
			</form>
			<a class="navbar-brand" href="javascript:clickMsg()">
				<span id="message" class="glyphicon glyphicon-envelope"></span>
			</a>
			<div class="navbar-inner">
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="text-info"><a href="/StudyCloud/main?command=GOSTDREGISTER">스터디 등록</a></li>
						<li class="text-info"><a href="/StudyCloud/main?command=GOMNGSTUDY">나의 스터디</a></li>
						<li class="text-info"><a href="javascript:fnLogOut();">로그아웃</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>