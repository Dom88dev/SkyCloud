<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/StudyCloud/lib/dist/css/AdminLTE.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/alt/AdminLTE-bootstrap-social.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/StudyCloud/lib/dist/js/adminlte.js"></script>
<style>
#message {
	color: #39d2fd;
}

nav {
	background-color: white
}

.nav-search-input {
	background-color: none;
	border: none;
}

.nav-search-input:focus {
	background-color: none;
	border: none;
	outline: none;
}

.rbtn-default {
	color: #333;
	background-color: #fff;
	border-color: white;
}

.dropdown-submenu {
	position: relative;
}

.dropdown-submenu .dropdown-menu {
	top: 0;
	left: 100%;
	margin-top: -1px;
}

.rdropdown-menu {
	position: absolute;
	top: 100%;
	left: 28%;
	z-index: 1000;
	display: none;
	float: left;
	min-width: 160px;
	padding: 5px 0;
	margin: 2px 0 0;
	font-size: 14px;
	text-align: left;
	list-style: none;
	background-color: #fff;
	-webkit-background-clip: padding-box;
	background-clip: padding-box;
	border: 1px solid #ccc;
	border: 1px solid rgba(0, 0, 0, .15);
	border-radius: 4px;
	-webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
	box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
}

div.uiheader {
	background-clip: padding-box;
	background-color: #fff;
	border-bottom: solid 1px #dddfe2;
	border-top-left-radius: 3px;
	border-top-right-radius: 3px;
	padding: 1px 12px 1px;
	position: relative;
	z-index: 100;
}

.line {
	background-color: #fff;
	border-bottom: 1px solid #dddfe2;
	overflow: hidden;
	position: relative;
}
</style>
<script>
	function fnLogOut() {
		$("#logOutModal").modal();
	}

	$(document).ready(function() {
		$('.dropdown-menu').on("click", function(e) {
			$(this).next('ul').toggle();
			e.stopPropagation();
			e.preventDefault();
		});
		$('#myMsgModal').on('click', function(e) {
			$('#msgmodal').modal('show');
			//$('msgBoxDiv').html('/StudyCloud/WEB-INF/templates/msg/msgBox.jsp');
		});
	});
</script>
<!-- navbar -->
<nav class="navbar navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="/StudyCloud/index.jsp"> <img
				alt="Brand" src="/StudyCloud/images/icons/navbar_logo.png"
				height="100%">
			</a>
		</div>
		<form class="navbar-form navbar-left" action="/StudyCloud/fwd"
			method="post">
			<input type="hidden" name="command" value="SEARCHSTUDY" /> <input
				type="hidden" name="command" value="LOADMSG" />
			<div class="form-group form-control">
				<input type="search" class="nav-search-input"
					placeholder="검색할 스터디를 입력하세요" name="searchTxt" /> <a
					style="color: sky" href="javascript:fnSearchStudy();"><span
					class="glyphicon glyphicon-search"></span></a>
			</div>
		</form>
		<ul class="nav navbar-nav">
			<!-- Messages: style can be found in dropdown.less-->
			<li class="dropdown messages-menu open">
				<!-- Menu toggle button --> <a href="#" class="dropdown-toggle"
				data-toggle="dropdown"> <span id="message"
					class="glyphicon glyphicon-envelope"></span> <span
					class="label label-info">4</span>
			</a>
				<ul class="dropdown-menu">
					<li class="header">알림</li>
					<li>
						<!-- inner menu: contains the messages -->
						<ul class="menu">
							<li>
								<jsp:include page="/WEB-INF/templates/msg/SmallMessage.jsp"></jsp:include>
							</li>
							<!-- end message -->
						</ul> <!-- /.menu -->
					</li>
					<li class="footer"><a href="#" id="myMsgModal">쪽지함</a></li>
					<div class="modal" id="msgmodal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="">
						<jsp:include page="/WEB-INF/templates/msg/message.jsp"></jsp:include>
					</div>

				</ul>
			</li>
			<!-- /.messages-menu -->
		</ul>


		<div class="navbar-inner">
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li class="text-info"><a
						href="/StudyCloud/fwd?command=GOSTDREGISTER">스터디 등록</a></li>
					<li class="text-info"><a
						href="/StudyCloud/fwd?command=GOMNGSTUDY">나의 스터디</a></li>
					<li class="text-info"><a href="javascript:fnLogOut();">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</div>
</nav>
