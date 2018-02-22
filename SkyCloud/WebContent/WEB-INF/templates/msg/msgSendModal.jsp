<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/StudyCloud/lib/dist/css/AdminLTE.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/alt/AdminLTE-bootstrap-social.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/StudyCloud/lib/dist/js/adminlte.js"></script>
<script>
	function fncloseModal(){
		$(this).modal('hide');
	}
</script>
<div class="box box-info direct-chat direct-chat-info">
	<!-- /.box-header -->
	<div class="box-body">
		<!-- Conversations are loaded here -->
		<div class="direct-chat-messages">
			<div class="col-md-12">
				<form action="/StudyCloud/json" method="get">
					<input type="hidden" name="command" value="POSTMSG"> <input
						type="hidden" name="sender" value="${mem.email}">
					<div class="col-md-3" align="center"
						style="margin-top: 0.8em; margin-bottom: 0.8em;">
						<label style="font-size: 1em; line-height: 2em; color: #39d2fd;">받는
							사람</label>
					</div>
					<div class="col-md-9"
						style="margin-top: 0.8em; margin-bottom: 0.8em;">
						<input type="text" name="reciever" class="form-control">
					</div>
					<div class="col-md-12">
					<div class="col-md-2">
						<label style="font-size: 1em; line-height: 2em; color: #39d2fd;">내용</label>
					</div>	
					<div class="col-md-10">
						<textarea id="message_content_area" name="msgContent" rows="10"
							cols="50" class="form-control"></textarea>
					</div>
					</div>
					<div class="col-md-12" style="margin-top: 0.8em; margin-bottom: 0.8em; float: right;">
						<button type="submit" class="btn btn-info" style="width: 30%;">전송</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>