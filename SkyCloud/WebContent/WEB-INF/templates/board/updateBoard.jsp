<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/boardCss.css">
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/stdRegisterCss.css">
<script src="/StudyCloud/lib/ckeditor/ckeditor.js"></script>
<jsp:useBean id="regiDate" class="java.util.Date" />
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
				공지사항 수정
				<c:set value="${notice}" var="board"/>
			</c:when>
			<c:otherwise>
				과제 수정
				<c:set value="${homework}" var="board"/>
			</c:otherwise>
		</c:choose>
	</h2>
	<div class="col-md-12">
		<form action="/StudyCloud/ajax" method="post" enctype="multipart/form-data">
			<c:choose>
				<c:when test="${boardKind == 'notice'}">
					<input type="hidden" name="command" value="UPDATENOTICE">
				</c:when>
				<c:otherwise>
					<input type="hidden" name="command" value="UPDATEHOMEWORK">
				</c:otherwise>
			</c:choose>
			<input type="hidden" name="bId" value="${board.b_id}">
			<div class="col-md-2" align="center" style="margin-top:0.8em;margin-bottom:0.8em;">
				<label style="font-size: 1em;line-height:2em;color: #39d2fd;">제목</label>
			</div>
			<div class="col-md-10" style="margin-top:0.8em;margin-bottom:0.8em;">
				<input type="text" name="title" class=" rform-control" value="${board.title}">
			</div>
			<div class="col-md-12" align="left" style="margin-top:0.8em;margin-bottom:0.8em;">
				<div class="col-md-4">
					<button type="button" class="btn-white btn-upload">파일 선택<i class="glyphicon glyphicon-paperclip"></i></button><label class="upload_file_name">${board.files.b_file1_name}</label>
					<input type="file" name="file1" class="file_Upload" onchange="fnChangeFile(this.value, 1)"><input type="hidden" name="isChangedFile1" value="false"/>
				</div>
				<div class="col-md-4">
					<button type="button" class="btn-white btn-upload">파일 선택<i class="glyphicon glyphicon-paperclip"></i></button><label class="upload_file_name">${board.files.b_file2_name}</label>
					<input type="file" name="file2" class="file_Upload" onchange="fnChangeFile(this.value, 2)"><input type="hidden" name="isChangedFile2" value="false"/>
				</div>
				<div class="col-md-4">
					<button type="button" class="btn-white btn-upload">파일 선택<i class="glyphicon glyphicon-paperclip"></i></button><label class="upload_file_name">${board.files.b_file3_name}</label>
					<input type="file" name="file3" class="file_Upload" onchange="fnChangeFile(this.value, 3)"><input type="hidden" name="isChangedFile3" value="false"/>
				</div>
			</div>
			<c:choose>
				<c:when test="${boardKind == 'notice'}">
					<div class="col-md-12">
						<textarea id="notice_modify_content_area" name="content" rows="10" cols="50" class="form-control">${board.content}</textarea>
						<script>
		       				CKEDITOR.replace( 'notice_modify_content_area', {
		       					'filebrowserUploadUrl':'/StudyCloud/lib/ckeditor/upload.jsp?'
		       					    +'realUrl=/StudyCloud/images/boardUploadImg/'
		       					    +'&realDir=images/boardUploadImg'
		       				} );
		   				</script>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-md-12" style="margin-top:0.8em;margin-bottom:0.8em;" align="left">
						<c:set target="${regiDate}" property="time" value="${board.b_datetime}"/>
						<i style="color:#39d2fd;"><fmt:formatDate value="${regiDate}" pattern="yyyy-MM-dd"/></i>로부터 <input class="rform-control-inline text-info" type="number" name="daysToduedate" size="1" min="0" max="90" value="${(board.duedate-board.b_datetime)/24/60/60/1000 }">일
						<input type="hidden" name="datetime" value="${board.b_datetime}">
					</div>
					<div class="col-md-12">
						<textarea id="homework_modify_content_area" name="content" rows="10" cols="50" class="form-control">${board.content}</textarea>
						<script>
			      				CKEDITOR.replace( 'homework_modify_content_area', {
			      					'filebrowserUploadUrl':'/StudyCloud/lib/ckeditor/upload.jsp?'
			      					    +'realUrl=/StudyCloud/images/boardUploadImg/'
			      					    +'&realDir=images/boardUploadImg'
			      				} );
			  				</script>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="col-md-12" style="margin-top:0.8em;margin-bottom:0.8em;">
				<button type="submit" class="btn btn-info" style="width:30%;">수정</button>
			</div>
		</form>
	</div>
</div>
<script>
function fnChangeFile(value, i) {
	var fileName = value.slice(value.lastIndexOf("\\")+1);
	$("input[name='file"+i+"']").prev().text(fileName);
	$("input[name='isChangedFile"+i+"']").val("true");
}
</script>
