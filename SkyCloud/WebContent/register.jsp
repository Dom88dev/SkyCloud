<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	td{vertical-align: text-top;}

table{
	border: 1px solid red;
	border-collapse: collapse;
	border-spacing: 15px 12px;
} 

th, td {
    border: 1px solid red;
    padding: 10px;
  } 
  
body {
	font-size: 25px;
}

.mform-control {
	width: 300px;
	height: 35px;
	padding: 6px 12px;
	font-size: 15px;
	line-height: 1.42857143;
	color: #555;
	background-color: #fff;
	background-image: none;
	border: 5px solid #39d2fd;
	border-radius: 30px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
	-webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow
		ease-in-out .15s;
	-o-transition: border-color ease-in-out .15s, box-shadow ease-in-out
		.15s;
	transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s
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
	</script>
<body>
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<c:choose>
			<c:when test="${empty sessionScope.email }">
				<jsp:include page="/WEB-INF/templates/navbar/navbarLogOut.jsp"></jsp:include>
			</c:when>
			<c:otherwise>
				<jsp:include page="/WEB-INF/templates/navbar/navbarLogIn.jsp"></jsp:include>
			</c:otherwise>
		</c:choose>
	</div>
		
	<div class="container" style="margin-top:50px">
		<div class="row">
			<form action="/StudyCloud/main">
				<input type="hidden" name="command" value="REGIMEMBER">
				<div class="mform-group">
					<div class="mform-group"></div>
					
					<div class="mlayer">
						<table class="mtable">
							<tr>
								<th>
									<label class="mtext-info mfont-size"><strong>이메일</strong></label>
								</th>
								<td>
									<input type="text" name="email" class="mform-control" placeholder="이메일 입력"/>
									<div>
										<div style="float:left;width:130px">
											<button type="button" id='input' class="memail-authentication mfont-size" name="email">  email 인증  </button>
										</div>
										<div style="float:right;width:130px;">	
											<span id="certification" class="memail-confirm mfont-size" style="display: none;border: 1px solid #39d2fd">이메일 인증 확인</span>
										</div>
										<div style='clear:both'></div>
									</div>
								</td>
							</tr>
							
							<tr>
								<th>
									<label class="mtext-info mfont-size"><strong>비밀번호</strong></label>
								</th>
								<td>
									<input type="password" name="pw" class="mform-control mfont-size" placeholder="비밀번호는 영문/숫자/특수문자 포함 6자이상"/>
								</td>
							</tr>
							
							<tr>
								<th>
									<label class="mtext-info mfont-size"><strong>비밀번호 확인</strong></label>
								</th>
								<td>
									<input type="password" name="pwc" class="mform-control" placeholder="비밀번호 재확인"/>
								</td>
							</tr>
							<tr>
								<th>
									<label class="mtext-info mfont-size"><strong>닉네임</strong></label>
								</th>
								<td>
									<input type="text" name="name" class="mform-control" placeholder="닉네임 입력"/>
								</td>
							</tr>
							<tr>
								<th>
									<label class="mtext-info mfont-size"><strong>연락처</strong></label>
								</th>
								<td>
									<input type="tel" name="tel" class="mform-control" placeholder="01012345678"/>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div>
										<div style="border: 1px solid #ffffff; float: left; width: 20%; padding-left: 5px">
											<img id="men" src="../images/male-user.png" alt="남자" align="right"/>
										</div>
										<div style="border: 1px solid #ffffff; float: left; width: 55%;text-align:center;">
											<div style="border: 1px solid #ffffff; float: left; width: 31%;text-align:right;color:#6e6e6e;" ><p>남자</p></div>
											<div style="border: 1px solid #ffffff; float: left; width: 40%;">
												<label class="switch">
													<input type="checkbox" id="box" name="gender">
													<span class="slider round" id="toggle" ></span>
												</label>
											</div>
											<div style="border: 1px solid #ffffff; float: left; width: 24%;text-align:left;color:#6e6e6e;"><p style="display: none;">여자</p></div>
										</div>
										<div style="border: 1px solid #ffffff;  float: right; width: 20%;">
											<img id="women" src="../images/business-woman.png" alt="여자"  align="middle" style="display: none;"/>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>
									<label class="mtext-info mfont-size"><strong>생년월일</strong></label>
								</th>
								<td>
									<input type="date" name="born" class="mform-control" placeholder="19010131"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	var check = $("input[type='checkbox']");
	check.click(function() {
		$("p").toggle();
		$("#women").toggle();
		$("#men").toggle();
	});
</script>
</html>