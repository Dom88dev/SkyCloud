<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='/StudyCloud/lib/bootstrap337/css/fullcalendar.min.css'
	rel='stylesheet' />
<link href='/StudyCloud/lib/bootstrap337/css/fullcalendar.print.min.css'
	rel='stylesheet' media='print' />
<link href='/StudyCloud/lib/bootstrap337/css/scheduler.min.css'
	rel='stylesheet' />
<link href='/StudyCloud/lib/bootstrap337/css/fullcalendar.min.css'
	rel='stylesheet' />
<link href='/StudyCloud/lib/bootstrap337/css/bootstrap.min.css'
	rel='stylesheet' />
<link
	href='/StudyCloud/lib/bootstrap337/css/bootstrap-datetimepicker.min.css'
	rel='stylesheet' />
<script src='/StudyCloud/lib/bootstrap337/js/moment.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/jquery.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/jquery-ui.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/fullcalendar.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/bootstrap.min.js'></script>
<script
	src='/StudyCloud/lib/bootstrap337/js/bootstrap-datetimepicker.min.js'></script>
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
		$('#calendar').fullCalendar({
			now : new Date(y, m, d),
			editable : false,
			aspectRatio : 1.8,
			height : "auto",
			scrollTime : '00:00',
			header : {
				left : 'today',
				center : 'prev title next',
				right : 'myAttendButton'
			},
			events : function(start, end, timezone, callback) {
				$.ajax({
					url : "/StudyCloud/ajax",
					type : "GET",
					data : {
						command : "CNTSTATUS",
						stdId:"${myStdList[index].std_id}",
					},
					dataType : "json",
					success : function(data) {

						//var jData = $.parseJSON(data);
						var events = [];
						if (data) {
							$(data).each(function(i, obj) {
								var titleStr;

								if (data.attcnt != null) {
									titleStr = "출석 [" + data.attcnt + "]건";
								} else if (data.latecnt != null) {
									titleStr = "지각 [" + data.latecnt + "]건";
								} else if (data.abscnt != null) {
									titleStr = "결석 [" + data.abscnt + "]건";
								} else{
									titleStr = "공결 [" + data.obscnt + "]건";
								}

								events.push({
									start : new Date(y, m, d),
									title : titleStr
								});
							});
							callback(events);
						}
					},
				});
			},
			eventAfterRender : function(event, element, view) {
			},
			buttonText : {
				today : "오늘",
			},
			selectable : true,
			selectHelper : true,
			select : function(start, end) {
				$('#calmodal').modal('show');
			},
			eventClick : function(event, element) {
				var s = null;
				$.ajax({
					url : "/StudyCloud/ajax",
					type : "GET",
					data : {
						command : "GET_ATTSTATUS",
						stdId:"${myStdList[index].std_id}",
						email : "${email}"
					},
					async: false,
					success : function(data) {
						if(data!=null){
							var tag = "<tr>";
							for(var i=0;i<data.atd_status.length;i++){
								tag += "<td>"+ data[i].email+ "</td>";
								tag +="<td><select class='rselect' name='status_select'><option value='"+data[i].atd_status+"'>"+ atdstatus + "</option></select></td>";
								tag +="</tr>";
							}
							tag += "<tr>";
							document.getElementById("att-table").innerHTML = tag;
						}
					}
				});
				
				$('#calmodal').modal('show');
				$('#calmodal').find('#title').val(event.title);
			},
			//editable : true,
			eventLimit : true,
			eventRender : function(event, element) {
				$(element).find(".fc-time").remove();
			},
			schedulerLicenseKey : 'GPL-My-Project-Is-Open-Source'
		});
		// Whenever the user clicks on the "save" button om the dialog
		$('#save-event').on('click', function() {
			var title = $('.rselect option:selected').val();
			//$('#calendar').fullCalendar('removeEvents', event.title);
			$.ajax({
				url : "/StudyCloud/ajax",
				type : "GET",
				data : {
					command : "UPDATE_STATUS",
					status : "$('.rselect option:selected').val()"
				},
				success : function(data) {
					alert('출결이 정상적으로 수정되었습니다.');
				}
			});
			if (title) {
				var eventData = {
					title : $('.rselect> option:selected').val(),
					start : new Date(y, m, d)
				};
				$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
			}
			$('#calendar').fullCalendar('unselect');

			// Clear modal inputs
			$('#calmodal').find('input').val('');

			// hide modal
			$('#calmodal').modal('hide');
		});
	});
	function showAttStatus(data) {
		var tab = document.querySelector('#att-table');
		alert(tab);
		var atdstatus;
		for (var i = 0; i < data.length; i++) {
			if (data[i].atd_status=='att') {
				alert(data[i].atd_status);
				atdstatus = "출석";
			} else if (data[i].atd_status=='late') {
				atdstatus = "지각";
			} else if (data[i].atd_status=='abs') {
				atdstatus = "결석";
			} else {
				alert(data[i].atd_status);
				atdstatus = "공결";
			}
			html += '<tr><td>'+ data[i].email+ '</td><td><select class="rselect" name="status_select"><option value="'+data[i].atd_status+'">'+ atdstatus + '</option>' + '</select></td></tr>';
			tab.innerHTML = html;
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
	/*float: right;*/
	width: 100%;
}

.fc-event, .fc-event:hover {
	text-align: center;
	color: #000;
	/*text-decoration: none;*/
}

.fc-row .fc-widget-header {
	background-color: #39d2fd;
	color: #fff;
	border-color: #39d2fd;
}

.fc-unthemed .fc-content, .fc-unthemed .fc-divider, .fc-unthemed .fc-list-heading td,
	.fc-unthemed .fc-list-view, .fc-unthemed .fc-popover, .fc-unthemed .fc-row,
	.fc-unthemed tbody, .fc-unthemed td, .fc-unthemed th, .fc-unthemed thead
	{
	border-color: #03c6fc;
}
</style>
</head>
<body>
	<div id='wrap'>
		<div id='calendar'></div>
		<div id='datepicker'></div>
		<c:set var="command" value="UPDATE_ATTSTATUS"></c:set>
		<div id="calmodal" class="modal fade" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">출결 관리</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12">
								<form action="/StudyCloud/AtdCalStdleader" method="post">
									<table class="table">
										<thead>
											<tr>
												<th class="text-center">이름</th>
												<th class="text-center">출결 현황</th>
											</tr>
										</thead>
										<tbody id="att-table">

										</tbody>
									</table>
								</form>
							</div>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						<button type="submit" class="btn btn-primary" id="save-event">출결
							수정</button>

					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<div style='clear: both'></div>
	</div>
</body>
</html>