<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>

<link rel='stylesheet' href="/StudyCloud/lib/bootstrap337/css/form-con.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>

td, tr {
    padding: 10px;
    vertical-align: text-top;
    
  }

.container {
	max-width: 100%
}

.mfont-size {
	font-size: 15px;
}

.mform {
	width: 600px;
	height: 600px;
	margin:auto;
}
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
<style type="text/css"></style>
</head>
	<script>
	/*	function toggle_btn(){
			var btn1 = document.getElementById('men');
			var btn2 = document.getElementById('women');
			var box = document.getElementById('box');
			var check = $("input[type='checkbox']");
			alert(check);
			if(check==box){
				alert("true");
				btn2.innerHTML = "";
				btn1.innerHTML = "<img src='../images/male-user.png' alt='남자' align='right'/>";
				
			}
			else{
				alert("false");
				btn1.innerHTML ="";
				btn2.innerHTML = "<img src='../images/business-woman.png' alt='여자'  align='middle' />";
			}
		}
		
		window.onload = function(){
			var btn = document.getElementById("toggle");
			
			btn.addEventListener('click', toggle_btn, false);
		}
		*/
		$('#input').click(
			function(){
				alert("호출1");
				$('#certification').css('style', 'inline');
			}		
		)
		
		function regiResultModal(result) {
			if(result>0){
				$("div.modal-footer button").click(function(){
					window.location.replace("/StudyCloud/index.jsp");
				});
				$("#modal").modal();
			} else {
				$("div.modal-body")[0].innerHTML = "회원가입도중 문제가 발생했습니다.<br>잠시 후 다시 시도해주십시오.";
				$("div.modal-footer button").addClass("btn btn-danger");
				$("#modal").modal();
			}
		}
	</script>
<body>
	<!-- 오늘 날짜 객체 생성 -->
	<jsp:useBean id="date" class="java.util.Date"/>
	<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="today"/>
		
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<jsp:include page="/WEB-INF/templates/navbar/navbarLogOut.jsp"></jsp:include>
	</div>
	
	<div class="container" style="margin-top:100px;">
		<div class="row">
		
		<!-- 회원가입 폼 -->
			<form action="/StudyCloud/main">
				<input type="hidden" name="command" value="REGIMEMBER">
				<div class="container">
					<div class="container">
						<div class="mform">
							<table class="mtable table">
							<tr >
								<td colspan="2" style="border: 0">
									<div align="center">
										<img alt="로고" src="/StudyCloud/images/icons/navbar_logo.png">
									</div>
								</td>
							</tr>
								<tr>
									<th>
										<label class="mtext-info mfont-size" style="padding-top: 15%"><strong>이메일</strong></label>
									</th>
									<td><div style="padding-bottom: 10px">
											<input type="email" name="email" class="mform-control" style="width: 100%" placeholder="이메일 입력"/>
										</div>
										<div>
											<div style="float:left;width:auto;">
												<button type="button" id='input' class="memail-authentication" name="email">  email 인증  </button>
											</div>
											<div style="float:right;width:65%;background:red;">	
												<span id="certification" class="memail-confirm mfont-size" style="display; text-align:center; ;position:absolute ;width:250px;font-size:14px">이메일 인증 확인</span>
											</div>
											<div style='clear:both'></div>
										</div>
									</td>
								</tr>
								
								<tr>
									<th>
										<label class="mtext-info mfont-size" style="padding-top: 5%"><strong>비밀번호</strong></label>
									</th>
									<td>
										<input type="password" name="pw" class="mform-control" style="width: 100%" placeholder="비밀번호는 영문/숫자/특수문자 포함 6자이상"/>
									</td>
								</tr>
								
								<tr>
									<th>
										<label class="mtext-info mfont-size" style="padding-top: 5%"><strong>비밀번호 확인</strong></label>
									</th>
									<td>
										<input type="password" name="pwc" class="mform-control" style="width: 100%" placeholder="비밀번호 재확인"/>
									</td>
								</tr>
								<tr>
									<th>
										<label class="mtext-info mfont-size" style="padding-top: 5%"><strong>닉네임</strong></label>
									</th>
									<td>
										<input type="text" name="name" class="mform-control" style="width: 100%" placeholder="닉네임 입력"/>
									</td>
								</tr>
								<tr>
									<th>
										<label class="mtext-info mfont-size" style="padding-top: 5%"><strong>연락처</strong></label>
									</th>
									<td>
										<input type="tel" name="tel" class="mform-control" style="width: 100%" placeholder="01012345678"/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div>
											<div style="border: 1px solid #ffffff;text-align:r; float: left; width: 20%;">
												<i id="men" class="fa fa-mars" style="font-size:36px;color:#39d2fd;"></i>
											</div>
											<div style="border: 1px solid #ffffff; float: left; width: 55%;text-align:center;">
												<div style="border: 1px solid #ffffff; float: left; width: 31%;text-align:right;color:#6e6e6e;" ><p>남자</p></div>
												<div style="border: 1px solid #ffffff; float: left; width: 40%;">
													<label class="switch">
														<input type="checkbox" id="box" name="gender">
														<span class="slider round" style="background-color: #39d2fd;" id="toggle" ></span>
													</label>
												</div>
												<div style="border: 1px solid #ffffff; float: left; width: 24%;text-align:left;color:#6e6e6e;"><p style="display: none;">여자</p></div>
											</div>
											<div style="border: 1px solid #ffffff;  float: right; width: 20%;">
												<i id="women" class="fa fa-venus" style="font-size:36px;color:#ff6699;display: none;"></i>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>
										<label class="mtext-info mfont-size" style="padding-top: 5%"><strong>생년월일</strong></label>
									</th>
									<td>
										<input type="date" name="born" max="${today}" style="width: 100%" class="mform-control" placeholder="19010131"/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<button type="submit" style="width: 100%;height: 50px; border: 0;background-color:#39d2fd;color: white;">회원 가입</button>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</form>
		</div>
		
		
		<!-- 회원가입결과 확인 모달 -->
		<div class="modal fade" id="modal" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<i class="fa fa-cloud" style="font-size:24px;color:#39d2fd"><strong>회원가입</strong></i>
					</div>
					<div class="modal-body">
						가입을 축하드립니다.
					</div>
					<div class="modal-footer">
						<button class="btn btn-info" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<!-- 회원가입 결과 처리 -->
	<c:if test="${!(empty RegisterResult)}">
		<script>regiResultModal('${RegisterResult}');</script>
	</c:if>
</body>
<script>
	var check = $("#box");
	check.click(function() {
		$("p").toggle();
		$("#women").toggle();
		$("#men").toggle();
	});
</script>
</html>