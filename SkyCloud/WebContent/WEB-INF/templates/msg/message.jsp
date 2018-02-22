<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<!-- Bootstrap 3.3.7 -->
<link rel="stylesheet"
	href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="/StudyCloud/lib/dist/css/ionicons.css">
<!-- Theme style -->
<link rel="stylesheet" href="/StudyCloud/lib/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/skins/_all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/plugins/iCheck/flat/blue.css">
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<link rel="stylesheet" href="/StudyCloud/lib/dist/css/AdminLTE.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/alt/AdminLTE-bootstrap-social.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/StudyCloud/lib/dist/js/adminlte.js"></script>
<style>
</style>
<script>
	var recordsPerPage = 10;
	var currentMPage = 0;
	var beginNumPerMPage = recordsPerPage * currentMPage;
	
	var msgData = "";
	
	(function() {
		$.post("/StudyCloud/json", {
			command : "LOADMSG",
			reciever : "${mem.email}"
		}, function(data) {
			$.each(data, function(index, num) {
				var msgId = num.msg_id;
				var msgDatetime = num.msg_datetime;
				var msgHref = num.msg_href;
				var msgContent = num.msg_content;
				var msgCheck = num.msg_check;
				var msgReciever = num.reciever;
				var msgSender = num.sender;
			})
			/* alert(data);
			msgData = data;
			fnLoadMsg(data); */
		});
	})();

	function fnLoadMsg(data) {
		var jsonData = $.parseJSON(data);
		if (jsonData) {
			var mList = jsonData.msgList;
			var tBody = $("div#msgTable");
			var sendBtn = $("button#btnSendMessage");

			tBody.empty();

			createMsgRecord(mList);

		}
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

	//쪽지 작성화면으로 넘기는 function
	function fnPostMsg() {
		$.post("/StudyCloud/fwd", {
			"email" : '${mem.email}',
			"command" : "SENDMSG"
		}, function(code) {
			$("#msgTable").html(code);
		});
	}
</script>
</head>
<body>
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span><span class="sr-only">Close</span>
				</button>
				<div class="modal-body">
					<div class="box box-body">
						<div class="box-header with-border">
							<div class="col-md-9">
								<h3 class="box-title">쪽지 보내기</h3>
							</div>
							<div class="col-md-3">
								<button type="submit" class="btn btn-default"
									id="btnSendMessage" onclick='fnPostMsg()'>쪽지 보내기</button>
							</div>
							<!-- /.box-tools -->
						</div>
						<!-- /.box-header -->
						<div class="box-body no-padding">
							<div class="table-responsive mailbox-messages" id="msgTable">

								<!-- /.table -->
							</div>
							<!-- /.mail-box-messages -->
						</div>
					</div>
					<!-- /. box -->
				</div>
			</div>
		</div>
	</div>

</body>
</html>