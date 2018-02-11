<%@ page contentType="text/html; charset=UTF-8"%>
<style>
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
	function fnPopupLogIn() {
		$("#logInModal").modal();
	}
	
	$("input[type=search]").keypress(function(e) { 
	    if (e.keyCode == 13) fnSearchStudy();
	});
	
	function fnSearchStudy() {
		$("form.navbar-form").submit();
	}
	function fnLogoutStd(){
		$("#logOutStdModal").modal();
	}
</script>
	<!-- navbar -->
	<nav class="navbar navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/StudyCloud/index.jsp">
					<img alt="Brand" src="/StudyCloud/images/icons/navbar_logo.png" height="100%">
				</a>		
			</div>
			<form class="navbar-form navbar-left" action="/StudyCloud/fwd" method="post">
				<input type="hidden" name="command" value="SEARCHSTUDY"/>
				<div class="form-group form-control">
					<input type="search" class="nav-search-input" placeholder="검색할 스터디를 입력하세요" name="searchTxt"/>
					<a style="color:sky" href="javascript:fnSearchStudy();"><span class="glyphicon glyphicon-search"></span></a>
				</div>
			</form>
			<div class="navbar-inner">
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="text-info"><a href="javascript:fnLogoutStd();">스터디 등록</a></li>
						<li class="text-info"><a href="/StudyCloud/fwd?command=GOREGISTER">회원가입</a></li>
						<li class="text-info"><a href="javascript:fnPopupLogIn();">로그인</a></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>