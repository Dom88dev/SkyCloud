<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/boardCss.css">
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/stdRegisterCss.css">
<script src="/StudyCloud/lib/ckeditor/ckeditor.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<style>
input.file_Upload {  
  opacity: 0;       /*input type="file" tag 투명하게 처리*/
  position: relative;
  width:100%;
}
::-webkit-file-upload-button { cursor:pointer; }
button.btn-upload {
	width:30%;
	position: absolute;
	cursor: pointer;
}
label.upload_file_name {
	width:60%;
	left:35%;
	color: #b3eefe;
	font-size: 0.8em;
	text-overflow:ellipsis;
	line-height:2em;
	position: absolute;
	cursor: pointer;
}
</style>
<div class="col-md-12">
	<h2 class="boardLabel">
		<c:choose>
			<c:when test="${boardKind == 'notice'}">
				공지사항 작성
			</c:when>
			<c:otherwise>
				과제 작성
			</c:otherwise>
		</c:choose>
	</h2>
	<div class="col-md-12">
		<form action="/StudyCloud/ajax" method="post" enctype="multipart/form-data">
			<c:choose>
				<c:when test="${boardKind == 'notice'}">
					<input type="hidden" name="command" value="POSTNOTICE">
				</c:when>
				<c:otherwise>
					<input type="hidden" name="command" value="POSTHOMEWORK">
				</c:otherwise>
			</c:choose>
			<input type="hidden" name="stdId" value="${stdId}">
			<div class="col-md-2" align="center" style="margin-top:0.8em;margin-bottom:0.8em;">
				<label style="font-size: 1em;line-height:2em;color: #39d2fd;">제목</label>
			</div>
			<div class="col-md-10" style="margin-top:0.8em;margin-bottom:0.8em;">
				<input type="text" name="title" class=" rform-control">
			</div>
			<div class="col-md-12" align="left" style="margin-top:0.8em;margin-bottom:0.8em;">
				<div class="col-md-4">
					<button type="button" class="btn-white btn-upload">파일 선택<i class="fa fa-file-o"></i></button><label class="upload_file_name"></label>
					<input type="file" name="file1" class="file_Upload" onchange="fnChangeFile(this.value, 1)">
				</div>
				<div class="col-md-4">
					<button type="button" class="btn-white btn-upload">파일 선택<i class="fa fa-file-o"></i></button><label class="upload_file_name"></label>
					<input type="file" name="file2" class="file_Upload" onchange="fnChangeFile(this.value, 2)">
				</div>
				<div class="col-md-4">
					<button type="button" class="btn-white btn-upload">파일 선택<i class="fa fa-file-o"></i></button><label class="upload_file_name"></label>
					<input type="file" name="file3" class="file_Upload" onchange="fnChangeFile(this.value, 3)">
				</div>
			</div>
			<c:choose>
				<c:when test="${boardKind == 'notice'}">
					<div class="col-md-12">
						<textarea id="notice_content_area" name="content" rows="10" cols="50" class="form-control"></textarea>
						<script>
		       				CKEDITOR.replace( 'notice_content_area', {
		       					'filebrowserUploadUrl':'/StudyCloud/lib/ckeditor/upload.jsp?'
		       					    +'realUrl=/StudyCloud/images/boardUploadImg/'
		       					    +'&realDir=images/boardUploadImg'
		       				} );
		   				</script>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-md-12" style="margin-top:0.8em;margin-bottom:0.8em;" align="left">
						<i style="color:#39d2fd;"><fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd"/></i>로부터 <input class="rform-control-inline text-info" type="number" name="daysToduedate" size="1" min="0" max="90">일
					</div>
					<div class="col-md-12">
						<textarea id="homework_content_area" name="content" rows="10" cols="50" class="form-control"></textarea>
						<script>
			      				CKEDITOR.replace( 'homework_content_area', {
			      					'filebrowserUploadUrl':'/StudyCloud/lib/ckeditor/upload.jsp?'
			      					    +'realUrl=/StudyCloud/images/boardUploadImg/'
			      					    +'&realDir=images/boardUploadImg'
			      				} );
			  				</script>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="col-md-12" style="margin-top:0.8em;margin-bottom:0.8em;">
				<button type="submit" class="btn btn-info" style="width:30%;">작성</button>
			</div>
		</form>
	</div>
</div>
<script>
function fnChangeFile(value, i) {
	var fileName = value.slice(value.lastIndexOf("\\")+1);
	$("input[name='file"+i+"']").prev().text(fileName);
}
</script>
