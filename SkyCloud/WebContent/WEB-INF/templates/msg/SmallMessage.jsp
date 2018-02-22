<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- start message -->
<div id="mA">
	<!-- <a href="#">

		<div id="mTbody">

			<h4>여기는 이름</h4>
			The message
			<p>여기는 쪽지 내용이나 스터디 신청 현황</p>
		</div>

	</a> -->
</div>
<script>
	var recordsPerPage = 10;
	var currentMPage = 0;
	var beginNumPerMPage = recordsPerPage * currentMPage;
	var msgData = "";
	$(document).ready(function() {
		$.ajax({
			url : "/StudyCloud/json",
			data : {
				command : "LOADMSG",
				reciever : "${mem.email}"
			},
			success : function(data) {
				var jData = $.parseJSON(data);

				
				var output = '';
				$(jData).each(function(index, num) {
					output += '<div>';
					output += '<a href="/StudyCloud/fwd?command=READMSG?msg_id='+num.msg_id+'">';
					output += '<h4>';
					var msgId = num.msg_id;
					var msgDatetime = num.msg_datetime;
					var msgHref = num.msg_href;
					var msgContent = num.msg_content;
					var msgCheck = num.msg_check;
					var msgReciever = num.reciever;
					var msgSender = num.sender;
					output += msgSender;
					output += '</h4>';
					output += '<p>';
					output += msgContent;
					output += '</p>';
					output += '</a>';
					output += '</div>';
					
				});

				$('#mA').html(output);
			}
		});
	});
	/* (function() {
		 /*  $.post("/StudyCloud/json", {
			command : "LOADMSG",
			reciever : "${mem.email}"
		}, function(data) {
			alert(data);
			$(data).each(function(index, num) {
				var output = '';
				alert(num.msg_id);
				output = '<h4>';
				var msgId = num.msg_id;
				var msgDatetime = num.msg_datetime;
				var msgHref = num.msg_href;
				var msgContent = num.msg_content;
				var msgCheck = num.msg_check;
				var msgReciever = num.reciever;
				var msgSender = num.sender;
				alert(msgId);
				output += msgSender;
				output += '</h4>';
				output += '<p>';
				output += msgContent;
				output += '</p>';
				alert(output);
				$('#mTbody').html(output);
			});
			 msgData = data;
			fnLoadSmallMsg(data); 

		}); */

	/* })(); */

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