<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/boardCss.css">
<style>
div.content-box {
	border-radius: 15px;
	color: #39d2fd;
	background-color: #ffffff;
	border: 0.4px solid #39d2fd;
	padding: 1.8em;
	margin-top: 2em;
}

button.btn-red {
	border: 0.4px solid #ff4d4d;
	color: #ff4d4d;
	background-color: #ffffff;
	border-radius: 3em;
}

button.btn-red:active, button.btn-red.active, .open>.dropdown-toggle.btn-red 
{
	color: #ff4d4d;
	background-color: #ffffff;
	border: 0.4px solid #ff4d4d;
	box-shadow: 0 4px 8px 0 rgba(255, 77, 77, 0.2), 0 6px 20px 0 rgba(255, 77, 77, 0.19);
	outline:none;
}

button.btn-red:hover {	border: 0.4px solid #ff4d4d;	color: #ff4d4d;	background-color: #fff; }
button.btn-red:focus {	border: 0.4px solid #ff4d4d;	color: #ff4d4d;	background-color: #fff;	outline:none;	}

</style>
<div class="col-md-12" align="center">
	<c:choose>
		<c:when test="${empty notice}">
			<c:set value="${homework}" var="board"/>
			<c:set value="homework" var ="kind"/>
		</c:when>
		<c:otherwise>
			<c:set value="${notice}" var="board"/>
			<c:set value="notice" var ="kind"/>
		</c:otherwise>
	</c:choose>
	<div class="col-md-12" align="right">
		<c:if test="${email == myStdList[index].email }">
			<button class="btn-white" onclick="fnGoToModify('${board.b_id}','${kind}')"><i class="fa fa-pencil-square-o">수정</i></button>
			<button class="btn-red" onclick="fnDeleteBoard('${board.b_id}')"><i class="	fa fa-trash-o">삭제</i></button>
		</c:if>
	</div>
	<h2 class="boardLabel">${board.title}</h2>
	<jsp:useBean id="regiDate" class="java.util.Date"/>
	<c:set target="${regiDate}" property="time" value="${board.b_datetime}"/>
	<h4 style="margin-bottom:2em;">
		<fmt:formatDate value="${regiDate}" pattern="yyyy-MM-dd"/><c:if test="${!(empty homework) }"> ~ <c:set target="${regiDate}" property="time" value="${homework.duedate}"/><fmt:formatDate value="${regiDate}" pattern="yyyy-MM-dd"/></c:if>
	</h4>
	<div class="col-md-12" align="justify">
		<div class="col-md-4">
			<a class="btn-white" id="file1"><i class="glyphicon glyphicon-paperclip">${board.files.b_file1_name}</i></a>
		</div>
		<div class="col-md-4">
			<a class="btn-white" id="file2"><i class="glyphicon glyphicon-paperclip">${board.files.b_file2_name}</i></a>
		</div>
		<div class="col-md-4">
			<a class="btn-white" id="file3"><i class="glyphicon glyphicon-paperclip">${board.files.b_file3_name}</i></a>
		</div>
	</div>
	<div class="col-md-12 content-box" align="left">
		${board.content}
	</div>
</div>

<!-- 삭제 확인 modal -->
<div class="modal fade" id="deleteBoardConfirmModal" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body">
						정말 삭제하시겠습니까?
					</div>
					<div class="modal-footer">
						<button id="deleteCommit" class="btn btn-danger">네</button><button class="btn btn-red" data-dismiss="modal">아니오</button>
					</div>
				</div>
			</div>
		</div>

<script>
(function() {
	if("${ !(empty board.files.b_file1)}"){
		$("#file1").attr("href", "/StudyCloud"+"${board.files.b_file1}");
	}
	if("${ !(empty board.files.b_file2)}") {
		$("#file2").attr("href", "/StudyCloud"+"${board.files.b_file2}");
	}
	if("${ !(empty board.files.b_file3)}") {
		$("#file3").attr("href", "/StudyCloud"+"${board.files.b_file3}");
	}
})();

function fnDeleteBoard(b_id) {
	$("#deleteCommit").click(function() {
		$("#deleteBoardConfirmModal").modal('hide');
		$.post("/StudyCloud/fwd", {"b_id":b_id, "command":"DELETEBOARD"}, 
				function(code) {
					$("#${includeStdMenu}").html(code);
			});
	});
	$("#deleteBoardConfirmModal").modal();
}

function fnGoToModify(b_id, kind) {
	$.post("/StudyCloud/fwd", {"b_id":b_id, "command":"UPDATEBOARD", "board":kind}, 
			function(code) {
				$("#${includeStdMenu}").html(code);
		});
}
</script>