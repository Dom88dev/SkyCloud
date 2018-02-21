<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/stdRegisterCss.css">
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/uploadButton.css">
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
	<title></title>
<style>
h4.boardLabel {
	color: white;
   	text-shadow: 1px 1px 2px #02b2e3, 0 0 10px #39d2fd, 0 0 5px #9ae8fe;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${empty uploadHfileResult}">
			<h4 class="boardLabel" align="center">과제 업로드</h4><br>
			<form  action="/StudyCloud/multi" method="post" enctype="multipart/form-data">
				<input type="hidden" name="command" value="UPLOAD_HOMEWORK">
				<input type="hidden" name="b_id" value="${b_id}">
				<input type="hidden" name="email" value="${email}">
				<div style="padding-left: 0.8em; padding-right: 0.8em;">
					<button type="button" class="btn-white btn-upload" style="border-radius: 1em;">파일 선택<i class="glyphicon glyphicon-paperclip"></i></button><label class="upload_file_name"></label>
					<input type="file" name="homeworkFile" class="file_Upload" onchange="fnChangeFile(this.value)">
				</div>
				<br>
				<div align="center">
					<button class="btn btn-info" type="submit">과제 업로드</button>
				</div>
			</form>
		</c:when>
		<c:otherwise>
			<div align="center">
				<br>
				<c:choose>
					<c:when test="${uploadHfileResult == 0}">
						<label>과제 파일 업로드에 실패했습니다. 잠시 후 다시 시도해주십시오.</label>
					</c:when>
					<c:otherwise>
						<label>과제 파일을 업로드했습니다.</label>
					</c:otherwise>
				</c:choose>
				<br>
				<button class="btn btn-info" onclick="fnCloseUploadHfile()">확인</button>
			</div>
		</c:otherwise>
	</c:choose>
</body>
<script>
function fnChangeFile(value) {
	var fileName = value.slice(value.lastIndexOf("\\")+1);
	$("input[name='homeworkFile']").prev().text(fileName);
}

function fnCloseUploadHfile() {
	window.parent.closeModal();
	window.parent.location.reload();
}
</script>
</html>