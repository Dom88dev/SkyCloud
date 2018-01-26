<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='/StudyCloud/lib/bootstrap337/css/fullcalendar.min.css' rel='stylesheet' />
<link href='/StudyCloud/lib/bootstrap337/css/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<link href='/StudyCloud/lib/bootstrap337/css/scheduler.min.css' rel='stylesheet' />
<link href='/StudyCloud/lib/bootstrap337/css/bootstrap.css' rel='stylesheet' />
<script src='/StudyCloud/lib/bootstrap337/js/moment.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/jquery.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/jquery-ui.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/fullcalendar.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/scheduler.min.js'></script>
<script>
	$(function() { 
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#external-events .fc-event').each(function() {
			$(this).data('event', {
				title : $.trim($(this).text()),
				stick : true
			});

		});
		$('#calendar')
				.fullCalendar(
						{
							now : new Date(y, m, d),
							editable : false,
							aspectRatio : 1.8,
							/*customButtons : {
								myAttendButton : {
									text : '출석',
									click : function() {
										alert('출석 완료!');
										$('div.fc-bg')
												.find('td.fc-today')
												.prepend(
														"<img src='/StudyCloud/images/icons/atd.png' width='100' height='80' align='center'>");
										$('div.fc-right')
												.find(
														'button.fc-myAttendButton-button')
												.css('display', 'none');
									}
								}
							},*/
							header : {
								left : 'today',
								center : 'prev title next',
								right : 'myAttendButton'
							},
							buttonText: {
							    today : "오늘",
							   },
							schedulerLicenseKey : 'GPL-My-Project-Is-Open-Source'
						});
		$('.mybutton').click(function(){
			var param;
			$.post("/ajax",{AttStatus:param},callback);
		});
	});
	
	function callback(data){
		if(data=="att"){
			alert('출석 완료!');
			$('div.fc-bg')
					.find('td.fc-today')
					.prepend(
							"<img src='/StudyCloud/images/icons/atd.png' width='100' height='80' align='center'>");
			$('div.fc-right')
					.find(
							'button.fc-myAttendButton-button')
					.css('display', 'none');
		}else if(date=="late"){
			alert('지각입니다.');
			$('div.fc-bg')
					.find('td.fc-today')
					.prepend(
							"<img src='/StudyCloud/images/icons/atd.png' width='100' height='80' align='center'>");
			$('div.fc-right')
					.find(
							'button.fc-myAttendButton-button')
					.css('display', 'none');
		}
	}
</script>
<style>
body {
	margin-top: 40px;
	text-align: center;
	font-size: 14px;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
}

#wrap {
	width: 1100px;
	margin: 0 auto;
}

#calendar {
	float: right;
	width: 100%;
}
.fc-row .fc-widget-header{
	background-color: #39d2fd;
	color: #fff;
	border-color: #39d2fd;
}
.fc-unthemed .fc-content, .fc-unthemed .fc-divider, .fc-unthemed .fc-list-heading td, .fc-unthemed .fc-list-view, .fc-unthemed .fc-popover, .fc-unthemed .fc-row, .fc-unthemed tbody, .fc-unthemed td, .fc-unthemed th, .fc-unthemed thead {
    border-color: #03c6fc;
}
</style>
</head>
<body>
	<div id='wrap'>
		<div id=mybutton>
			<button type=button class="btn" style="float: right">출석</button>
		</div>
		<div id='calendar'></div>
		<div style='clear: both'></div>
	</div>
</body>
</html>
