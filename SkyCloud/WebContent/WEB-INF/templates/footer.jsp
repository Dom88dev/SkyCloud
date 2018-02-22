<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>footer</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<body>
 	<footer class="text-center" style="color: white;">
       <div class="container" style="background-color: #737373; width: 100%;" >
          <div class="row">
             <div class="col-sm-3" >
                <h3>COMPANY </h3>
                <p>
                   	서비스소개<br>
                   	블로그<br>
                   	언론보도
                </p>
             </div>
             <div class="col-sm-3">
                <h3>POLICIES</h3>
                <p>
                  	이용약관<br>
                   	개인정보취급방침<br>
                </p>
             </div>
             <div class="col-sm-3">
                <h3>SUPPORT</h3>
                <p>
                   	FAQ<br>
                   	스터디클라우드센터<br>
                </p>
             </div>
             
             <div class="col-sm-3">
                <h3>MEMBER</h3>
                	<form id="frm" method="post" action="/StudyCloud/fwd">
                	<input type="hidden" name="command" value="GOUPDATEMEM">
                   	<a href="#" onclick="document.getElementById('frm').submit();" style="color: white;"><b>회원수정</b></a><br>
                   	</form>
                   	<form id="frm2" method="post" action="/StudyCloud/fwd">
                	<input type="hidden" name="command" value="GODELETEMEM">
                   	<a href="#" onclick="document.getElementById('frm2').submit();" style="color: white;"><b>회원탈퇴</b></a><br>
                   	</form>  
                   	
             </div>
          </div>
       </div>
    </footer>
</body>
</html>
