<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css"
	href="/StudyCloud/lib/css/boardCss.css">
<link rel="stylesheet" type="text/css"
	href="/StudyCloud/lib/css/stdRegisterCss.css">
<script src="/StudyCloud/lib/ckeditor/ckeditor.js"></script>
<jsp:useBean id="toDay" class="java.util.Date" />
<div class="col-md-12">
	<h2 class="boardLabel">
		<c:choose>
			<c:when test="${boardKind == 'message'}">
				쪽지 작성
			</c:when>
		</c:choose>
	</h2>
	<div class="col-md-12">
		<form action="/StudyCloud/multi" method="post"
			enctype="multipart/form-data">
			<c:choose>
				<c:when test="${boardKind == 'message'}">
					<input type="hidden" name="command" value="POSTMSG">
				</c:when>
			</c:choose>
			<input type="hidden" name="msgId" value="${msgId}">
			<input type="hidden" name="sender" value="${email}">
			<div class="col-md-2" align="center"
				style="margin-top: 0.8em; margin-bottom: 0.8em;">
				<label style="font-size: 1em; line-height: 2em; color: #39d2fd;">받는
					사람</label>
			</div>
			<div class="col-md-10"
				style="margin-top: 0.8em; margin-bottom: 0.8em;">
				<input type="text" name="reciever" class=" rform-control">
			</div>
			<c:choose>
				<c:when test="${boardKind == 'message'}">
					<div class="col-md-12">
						<textarea id="message_content_area" name="msgContent" rows="10"
							cols="50" class="form-control"></textarea>
					</div>
				</c:when>
			</c:choose>
			<div class="col-md-12"
				style="margin-top: 0.8em; margin-bottom: 0.8em;">
				<button type="submit" class="btn btn-info" style="width: 30%;">쪽지 보내기</button>
			</div>
		</form>
	</div>
</div>
