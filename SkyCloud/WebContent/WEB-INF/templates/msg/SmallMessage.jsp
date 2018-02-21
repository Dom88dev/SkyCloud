<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
	var recordsPerPage = 10;
	var currentMPage = 0;
	var beginNumPerMPage = recordsPerPage * currentMPage;
	var msgData = "";
	(function() {
		$.post("/StudyCloud/json", {
			command : "LOADMSG",
			reciever : "${myStdList[index].email}"
		}, function(data) {
			msgData = data;
			fnLoadSmallMsg(data);

		});
	})();

	function fnLoadSmallMsg(data) {
		if (data) {
			var mList = data.msgList;

			var tBody = $("div#mTbody");
			tBody.empty();

			createMsgRecord(mList);

		}
	}
	function createMsgRecord(mList) {
		var Body = $("div#mTbody");
		var recieverDiv = document.createElement("h4");
		var contentDiv = document.createElement("a");

		$(recieverDiv).text(mList[i].reciever);
		$(contentDiv).text(mList[i].reciever);

		$(contentDiv).attr("href",
				"javascript:fnReadMsg('" + msgList.reciever + "')");
		recordDiv.append(recieverDiv);
		recordDiv.append(contentDiv);

		$(Body).append(recordDiv);

	}
	//쪽지 보기
	function fnReadMsg(reciever) {
		$.post("/StudyCloud/fwd", {
			"command" : "READMSG",
			"msg_id" : msg_id
		}, function(code) {
			$("#msgTable").html(code);
		});
	}
</script>
<!-- start message -->
<a href="#">
	<div class="pull-left">
		<!-- User Image -->
		<img src="/StudyCloud/images/icons/noti.png" class="img-circle"
			alt="User Image">
	</div> <!-- Message title and timestamp --> <c:if test="${empty msgList}">
		<p>알림이 없습니다.</p>
	</c:if> <c:if test="${!empty msgList}">
		<div id="mTbody">
			<h4>여기는 이름</h4>
			<!-- The message -->
			<p>여기는 쪽지 내용이나 스터디 신청 현황</p>
		</div>
	</c:if>
</a>