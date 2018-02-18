<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	/* 버튼 효과 */
button.btn-effect{
  background:#39d2fd;
  color:#fff;
  border:none;
  position:relative;
  height:40px;
  right : 0px;
  font-size:1.4em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
}
button.btn-effect:hover{
  background:#fff;
  color:#39d2fd;
}
button.btn-effect:before,button.btn-effect:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #39d2fd;
  transition:400ms ease all;
}
button.btn-effect:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
button.btn-effect:hover:before,button.btn-effect:hover:after{
  width:100%;
  transition:800ms ease all;
}

#tbl{ border-spacing: 20px;}
#tbl td {padding:20px;}

</style>
</head>
<body>
	<div class="container-fluid" style="width:70%">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12" style="margin-top:50px;">
				<table id="tbl" class="col-md-12 col-sm-12 col-xs-12">
					<tr>
						<td>				
							<img src="/StudyCloud/images/icons/logo_Sky.png" alt="Logo"	style="width:100%; height:300px;"/>
						</td>
					</tr>
					<tr align="center">
						<td><h2>스터디 신청 완료</h2></td>					
					</tr>
					<tr align="center">
						<td> 
							<button class="btn btn-effect" onclick="location.href='/StudyCloud/index.jsp'">확인</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>