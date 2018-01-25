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
	width: 500px;
	height: auto;
	margin:auto;
}
</style>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
<script>
	$(document).ready(
		function(){
			$("#input").click(
				function(){
					alert("호출");
				}		
			)
	});
</script>
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
			<form id="registerForm" action="/StudyCloud/main" class="form-horizontal">
				<input type="hidden" name="command" value="REGIMEMBER">
				<div class="container">
					<div class="container">
						<div class="mform">
							<div>
							<div>
								<div style="border: 0">
									<div align="center">
										<img alt="로고" src="/StudyCloud/images/icons/navbar_logo.png">
									</div>
								</div>
							</div>
							<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback" style="border-top : 0;">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">이메일</strong></label>
									</div>
									
									<div class="col-sm-9">
										<div style="padding-bottom: 10px">
											<input type="email" id="email" name="email" class="mform-control" style="width: 100%; font-size:15px; border: 1px solid #39d2fd;" placeholder="이메일 입력" required="required" />
										</div>
										<div>
											<div style="float:left;width:33%;">
												<button type="button" id='input' class="memail-authentication" name="email" >  email 인증  </button>
											</div>
											<div style="float:right;width:63%;background:red;">	
												<span id="certification" class="memail-confirm mfont-size" style="display; text-align:center; ;position:absolute ;width:230px;font-size:14px;">이메일 인증 확인</span>
											</div>
											<div style='clear:both'></div>
										</div>
										<div id="emailValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
									
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">비밀번호</strong></label>
									</div>
									<div class="col-sm-9">
										<input type="password" id="pw" name="pw" class="mform-control" style="width: 100%;font-size:15px; border: 1px solid #39d2fd;" placeholder="비밀번호는 영문/숫자/특수문자 포함 6자이상" required="required"/>
										<div id="pwValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">비밀번호 확인</strong></label>
									</div>
									<div class="col-sm-9">
										<input type="password" id="pwc" name="pwc" class="mform-control" style="width: 100%;font-size:15px;	border: 1px solid #39d2fd;" placeholder="비밀번호 재확인" required="required"/>
										<div id="pwcValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">닉네임</strong></label>
									</div>
									<div class="col-sm-9">
										<input type="text" id="name" name="name" class="mform-control" style="width: 100%;font-size:15px; border: 1px solid #39d2fd;" placeholder="닉네임 입력" required="required"/>
										<div id="nameValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 2px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">연락처</strong></label>
									</div>
									<div class="col-sm-9">
										<input type="tel" id="tel" name="tel" class="mform-control" style="width: 100%;font-size:15px; border: 1px solid #39d2fd;" placeholder="01012345678" required="required"/>
										<div id="telValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback">
									<div>
										<div>
											<div style="border: 1px solid #ffffff;text-align:right; float: left; width: 20%;">
												<i id="men" class="fa fa-mars" style="font-size:36px;color:#39d2fd;padding-right: 10px"></i>
											</div>
											<div style="border: 1px solid #ffffff; float: left; width: 55%;text-align:center;">
												<div style="border: 1px solid #ffffff; float: left; width: 31%;text-align:right;color:#6e6e6e;" ><p style="padding-top: 10%">남자</p></div>
												<div style="border: 1px solid #ffffff; float: left; width: 40%;">
													<label class="switch">
														<input type="checkbox" id="box" name="gender">
														<span class="slider round" style="background-color: #39d2fd;" id="toggle" ></span>
													</label>
												</div>
												<div style="border: 1px solid #ffffff; float: left; width: 24%;text-align:left;color:#6e6e6e;height: 43.64px"><p style="display: none;padding-top: 15%">여자</p></div>
											</div>
											<div style="border: 1px solid #ffffff;  float: right; width: 20%;">
												<i id="women" class="fa fa-venus" style="font-size:36px;color:#ff6699;display: none;height: 37.53px"></i>
											</div>
										</div>
									</div>
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div class="form-group has-success has-feedback">
									<div>
										<label class="mtext-info mfont-size control-label col-sm-3"><strong style="color: #39d2fd">생년월일</strong></label>
									</div>
									<div class="col-sm-9">
										<input type="date" id="born" name="born" max="${today}" style="width: 100%;font-size:15px; border: 1px solid #39d2fd;" class="mform-control" placeholder="19010131" required="required"/>
										<div id="bornValid" style="color: #F56E6E;font-size: 13px;text-align: left;"></div>
									</div>
								</div>
								<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px solid #dcdcdc;"></div>
								<div>
									<div>
										<button type="submit" style="width: 100%;height: 50px; border: 0;background-color:#39d2fd;color: white;margin: auto;">회원 가입</button>
									</div>
								</div>
								<div>
									<div>
									<div style="margin-top: 10px;margin-bottom: 10px;border-top : 1px double #ffffff"></div>
									</div>
								</div>
							</div>
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
<script>
	// 이메일 유효성 검사
	$(document).ready(function(){
		$("#email").focusout(function(){
			
			var val =$(this).val();
			var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			
			if(val==""|val==null){
				$("#emailValid").text("필수 정보입니다.").val();
			}
			else if(!re.test(val)){
				$("#emailValid").text("이메일 입력이 부정확합니다.").val();
			}
			else{
				$("#emailValid").text("사용가능합니다.").val();
			//확인
			}

		})
		// 비밀번호 유효성 검사
			$("#pw").focusout(function(){
			
			var val =$(this).val();
			var re = regex = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,16}$/;
			
			if(val==""|val==null){
				$("#pwValid").text("필수 정보입니다.").val();
			}
			else if(!re.test(val)){
				$("#pwValid").text("6~16자, 숫자 또는 특수문자를 사용하세요.").val();
			//6자리 이상 12자리 이하 영문과 숫자, 특수문자 가능
			}
			else{
				$("#pwValid").text("사용가능합니다.").val();
			//확인
			}

		})
		// 비밀번호 확인 유효성 검사
			$("#pwc").focusout(function(){
				
			var pwOrgin	= $("#pw").val();
			var val =$(this).val();
			
			if(val==""|val==null){
				$("#pwcValid").text("필수 정보입니다.").val();
			}
			else if(val != pwOrgin){
				$("#pwcValid").text("비밀번호가 일치하지 않습니다.").val();
			}
			else{
				$("#pwcValid").text("사용가능합니다.").val();
			//확인
			}

		})
		// 닉네임 유효성 검사.
		$("#name").focusout(function(){
			
			var val =$(this).val();
			
			if(val==""|val==null){
				$("#nameValid").text("필수 정보입니다.").val();
			}
			else if(val != pwOrgin){
				$("#nameValid").text("비밀번호가 일치하지 않습니다.").val();
			}
			else{
				$("#nameValid").text("사용가능합니다.").val();
			//확인
			}

		}) 
		// 연락처 유효성 검사
		$("#tel").focusout(function(){
			
			var val =$(this).val();
			
			if(val==""|val==null){
				$("#telValid").text("필수 정보입니다.").val();
			}
			else if(val != pwOrgin){
				$("#telValid").text("비밀번호가 일치하지 않습니다.").val();
			}
			else{
				$("#telValid").text("사용가능합니다.").val();
			//확인
			}

		}) 
		// 생년월일 유효성 검사
		$("#born").focusout(function(){
			
			var val =$(this).val();
			
			if(val==""|val==null){
				$("#bornValid").text("필수 정보입니다.").val();
			}
			else if(val != pwOrgin){
				$("#bornValid").text("비밀번호가 일치하지 않습니다.").val();
			}
			else{
				$("#bornValid").text("사용가능합니다.").val();
			//확인
			}

		}) 
	});
	
</script>
</html>