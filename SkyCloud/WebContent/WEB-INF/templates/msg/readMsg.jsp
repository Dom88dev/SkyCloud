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
	
</script>
<div class="box box-info direct-chat direct-chat-info">
	<!-- /.box-header -->
	<div class="box-body">
		<!-- Conversations are loaded here -->
		<div class="direct-chat-messages">
			<!-- Message. Default to the left-->
			<div class="direct-chat-msg">
				<div class="direct-chat-info clearfix">
					<span class="direct-chat-name pull-left">Alexander Pierce</span> <span
						class="direct-chat-timestamp pull-right">23 Jan 2:00 pm</span>
				</div>
				<!-- /.direct-chat-info -->

				<!-- /.direct-chat-img -->
				<div class="direct-chat-text">안녕ㅎㅎㅎㅎ!</div>
				<!-- /.direct-chat-text -->
			</div>
			<!-- /.direct-chat-msg -->

			<!-- Message to the right -->
			<div class="direct-chat-msg right">
				<div class="direct-chat-info clearfix">
					<span class="direct-chat-name pull-right">김기덕</span> <span
						class="direct-chat-timestamp pull-left">23 Jan 2:05 pm</span>
				</div>
				<!-- /.direct-chat-info -->

				<!-- /.direct-chat-img -->
				<div class="direct-chat-text">스터디 신청합니다!</div>
				<!-- /.direct-chat-text -->
			</div>
			<!-- /.direct-chat-msg -->

		</div>
		<!--/.direct-chat-messages-->
		<!-- /.direct-chat-pane -->
	</div>
	<!-- /.box-body -->

	<div class="box-footer">
		<div class="input-group">
			<input type="text" name="message" placeholder="Type Message ..."
				class="form-control"> <span class="input-group-btn">
				<button type="submit" class="btn btn-info btn-flat">보내기</button>
			</span>
		</div>
	</div>
	<!-- /.box-footer-->
</div>