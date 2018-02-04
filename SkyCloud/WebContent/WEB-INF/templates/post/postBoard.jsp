<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="/StudyCloud/lib/ckeditor/ckeditor.js"></script>
<div class="col-md-12">
	<h2>
		<c:choose>
			<c:when test="${boardKind == 'notice'}">
				�������� �ۼ�
			</c:when>
			<c:otherwise>
				���� �ۼ�
			</c:otherwise>
		</c:choose>
	</h2>
	<div class="col-md-12">
		<form action="/StudyCloud/main" method="post">
			<c:choose>
				<c:when test="${boardKind == 'notice'}">
					<input type="hidden" name="command" value="POSTNOTICE">
				</c:when>
				<c:otherwise>
					<input type="hidden" name="command" value="POSTHOMEWORK">
				</c:otherwise>
			</c:choose>
			<input type="hidden" name="std_id" value="${stdId}">
			<div class="col-md-2" align="center">
				����
			</div>
			<div class="col-md-10">
				<input type="text" name="title" class="form-control">
			</div>
			<div class="col-md-12">
				<input type="file" name="file1" class="form-control">
			</div>
			<c:choose>
				<c:when test="${boardKind == 'notice'}">
					<div class="col-md-12">
						<textarea id="notice_content_area" name="content" rows="10" cols="50" class="form-control"></textarea>
						<script>
		       				CKEDITOR.replace( 'notice_content_area', {
		       					'filebrowserUploadUrl':'/lib/ckeditor/upload.jsp?'
		       					    +'realUrl=/StudyCloud/images/boardUploadImg'
		       					    +'&realDir=boardUploadImg'
		       				} );
		   				</script>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-md-12">
						<fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>�κ��� 
						<input type="number" name="daysToduedate" size="2" min="0" max="90" class="form-control">��
					</div>
					<div class="col-md-12">
						<textarea id="homework_content_area" name="content" rows="10" cols="50" class="form-control"></textarea>
						<script>
			      				CKEDITOR.replace( 'homework_content_area', {
			      					'filebrowserUploadUrl':'/lib/ckeditor/upload.jsp?'
			      					    +'realUrl=/StudyCloud/images/boardUploadImg'
			      					    +'&realDir=boardUploadImg'
			      				} );
			  				</script>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="col-md-12">
				<button type="submit" class="btn btn-info">�ۼ�</button>
			</div>
		</form>
	</div>
</div>

