<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/StudyCloud/lib/dist/css/AdminLTE.min.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/alt/AdminLTE-bootstrap-social.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/ionicons.min.css" />
<link rel="stylesheet"
	href="/StudyCloud/lib/dist/css/skins/_all-skins.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/StudyCloud/lib/dist/js/adminlte.js"></script>
<style>
	.rlist{
		display: block;
	    white-space: nowrap;
	    border-bottom: 1px solid #f6f6f6;
	   	margin: 0;
    	padding: 10px 10px;
	}
	#rh{
		padding: 0;
	    margin: 0 0 0 45px;
	    color: #444444;
	    font-size: 15px;
	    position: relative;
	}
	#rp{
		margin: 0 0 0 45px;
	    font-size: 12px;
	    color: #888888;
	}
	.rimg{
		margin: auto 10px auto auto;
	    width: 40px;
	    height: 40px;
	}
</style>
<!-- start message -->

<li>
	<div id="mA">
		<!-- <a href="#">

		<div id="mTbody">

			<h4>여기는 이름</h4>
			The message
			<p>여기는 쪽지 내용이나 스터디 신청 현황</p>
		</div>

	</a> -->
	</div>
</li>
<script>
	var recordsPerPage = 10;
	var currentMPage = 0;
	var beginNumPerMPage = recordsPerPage * currentMPage;
	var msgData = "";
	$(document)
			.ready(
					function() {
						$
								.ajax({
									url : "/StudyCloud/json",
									data : {
										command : "LOADMSG",
										reciever : "${mem.email}"
									},
									success : function(data) {
										var jData = $.parseJSON(data);

										var output = '';
										$(jData)
												.each(
														function(index, num) {
															output += '<div>';
															output += '<a class="rlist" href="/StudyCloud/fwd?command=READMSG?msg_id='
																	+ num.msg_id
																	+ '">';
															output += '<div class="pull-left"><img src="/StudyCloud/images/icons/noti.png" class="img-circle rimg" alt="User Image"></div>';
															output += '<h4 id="rh">';
															var msgId = num.msg_id;
															var msgDatetime = num.msg_datetime;
															var msgHref = num.msg_href;
															var msgContent = num.msg_content;
															var msgCheck = num.msg_check;
															var msgReciever = num.reciever;
															var msgSender = num.sender;
															output += msgSender;
															output += '</h4>';
															output += '<p id="rp">';
															output += msgContent;
															output += '</p>';
															output += '</a>';
															output += '</div>';

														});

										$('#mA').html(output);
									}
								});
					});
</script>