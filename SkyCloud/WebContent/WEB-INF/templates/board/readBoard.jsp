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
button.btn {border-radius: 3em;}

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
			<button class="btn-red" onclick="fnDeleteBoard()"><i class="	fa fa-trash-o">삭제</i></button>
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
		<div>
			${board.content}
			<div align="right">
				<a href="javascript:fnReplyShowUp();" style="color: #39d2fd;">댓글 보기</a>
			</div>
		</div>
		<div id="replyPostBox">
			<!-- 댓글 입력창 -->
			<form>
				<input type="hidden" name="rp_pos" value="0">
				<input type="hidden" name="rp_reciever">
				<div id="rrp_indicator" align="right"><span></span>에게 대댓글<button type="button" class="close" onclick="fnResetRereply()">&times;</button></div>
				<div class="input-group">
					<input type="text" id="replyContent" class="form-control" name="rp_content">
					<span class="input-group-addon" style="background: white; color: #39d2fd; border: none;" onclick="fnReply()">댓글 달기</span>
				</div>
			</form>
		</div>
		<div id="replyBox">
			댓글
			<!-- 댓글을 가진 replies객체를 el을 이용해 뿌린다. -->
			<c:forEach items="${replies}" var="reply">
				<div>
					<c:set target="${regiDate}" property="time" value="${reply.rp_datetime}"/>
					<span>${reply.writer}</span><fmt:formatDate value="${regiDate}" pattern="yyyy-MM-dd HH:mm"/>
					<c:if test="${reply.rp_writer ne email}">
						<span onclick="fnSetRereply('${reply.rp_pos}', '${reply.rp_writer}', '${reply.writer}')">댓글달기</span>
					</c:if>
					<c:if test="${reply.rp_writer eq email}">
						<span onclick="fnModifyReply('${reply.rp_id}', '${reply.rp_content}')">댓글수정</span>
					</c:if>
					<br>
					<span>${reply.reciever}</span><span>${reply.rp_content}</span>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<form id="deleteBForm" method="post" action="/StudyCloud/fwd">
<input type="hidden" name="command" value="DELETEBOARD">
<input type="hidden" name="b_id" value="${board.b_id}">
</form>
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
	$("#replyBox").hide();
	$("#rrp_indicator").hide();
})();

function fnDeleteBoard() {
	$("#deleteCommit").click(function() {
		$("#deleteBoardConfirmModal").modal('hide');
		$("#deleteBForm").submit();
	});
	$("#deleteBoardConfirmModal").modal();
}

function fnGoToModify(b_id, kind) {
	$.post("/StudyCloud/fwd", {"b_id":b_id, "command":"UPDATEBOARD", "board":kind}, 
			function(code) {
				$("#${includeStdMenu}").html(code);
		});
}

function fnReplyShowUp() {
	$("#replyBox").toggle();
}

function fnSetRereply(pos, reciever, rcv) {
	$("input[name='rp_pos']").val(pos);
	$("input[name='rp_reciever']").val(reciever);
	$("#rrp_indicator span").text(rcv);
	$("#rrp_indicator").show();
	$("#replyContent").focus();
}

function fnResetRereply() {
	$("input[name='rp_pos']").val("0");
	$("#rrp_indicator").hide();
}

function fnReply() {
	var content = $("#replyContent").val();
	var pos = $("input[name='rp_pos']").val();
	var b_id = '${board.b_id}';
	if(pos == "0") {
		$.post("/StudyCloud/fwd", {"b_id":b_id, "command":"REPLY", "rp_writer":"${email}", "rp_content":content, "board":'${kind}'}, 
				function(code) {
					$("#${includeStdMenu}").html(code);
			});
	} else {
		var reciever = $("input[name='rp_reciever']").val();
		$.post("/StudyCloud/fwd", {"b_id":b_id, "command":"REREPLY", "rp_writer":"${email}", "rp_content":content, "rp_pos":pos, "rp_reciever":reciever, "board":'${kind}'}, 
				function(code) {
					$("#${includeStdMenu}").html(code);
			});
	}
}

function fnModifyReply(rp_id, rp_content) {
	//모달로 띄워서 수정. 모달 만들어야 함.
}
</script>