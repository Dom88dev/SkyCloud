<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='/SkyCloud/lib/bootstrap337/css/fullcalendar.min.css'
	rel='stylesheet' />
<link href='/SkyCloud/lib/bootstrap337/css/fullcalendar.print.min.css'
	rel='stylesheet' media='print' />
<link href='/SkyCloud/lib/bootstrap337/css/scheduler.min.css'
	rel='stylesheet' />
<link href='/SkyCloud/lib/bootstrap337/css/fullcalendar.min.css'
	rel='stylesheet' />
<link href='/SkyCloud/lib/bootstrap337/css/bootstrap.min.css'
	rel='stylesheet' />
<link
	href='/SkyCloud/lib/bootstrap337/css/bootstrap-datetimepicker.min.css'
	rel='stylesheet' />
<script src='/SkyCloud/lib/bootstrap337/js/moment.min.js'></script>
<script src='/SkyCloud/lib/bootstrap337/js/jquery.min.js'></script>
<script src='/SkyCloud/lib/bootstrap337/js/jquery-ui.min.js'></script>
<script src='/SkyCloud/lib/bootstrap337/js/fullcalendar.min.js'></script>
<script src='/SkyCloud/lib/bootstrap337/js/bootstrap.min.js'></script>
<script
	src='/SkyCloud/lib/bootstrap337/js/bootstrap-datetimepicker.min.js'></script>
<script src='/SkyCloud/lib/bootstrap337/js/scheduler.min.js'></script>
<script>
	$(function() {
		$('#external-events .fc-event').each(function() {
			$(this).data('event', {
				title : $.trim($(this).text()),
				stick : true
			});
		});
		$('#calendar')
				.fullCalendar(
						{
							now : '2018-01-12',
							editable : false,
							aspectRatio : 1.8,
							height : "auto",
							scrollTime : '00:00',
							header : {
								left : 'today',
								center : 'prev title next',
								right : 'myAttendButton'
							},
							events : [ {
								title : '출석 : ' + '6' + '명\n' +
										'지각 : ' + '2' + '명\n' +
										'결석 : ' + '1' + '명\n' +
										'공결 : ' + '2' + '명\n',
								start : '2018-01-12'
							} ],
							buttonText : {
								today : "오늘",
							},
							selectable : true,
							selectHelper : true,
							/*select : function(start, end) {
								$('.modal').modal('show');
							},*/
							eventClick : function(event, element) {
								$('.modal').modal('show');
								$('.modal').find('#title').val(event.title);
							},
							editable : true,
							eventLimit : true,
							schedulerLicenseKey : 'GPL-My-Project-Is-Open-Source'
						});
		// Whenever the user clicks on the "save" button om the dialog
		$('#save-event').on('click', function() {
			var title = $('#title').val();
			$('#calendar').fullCalendar('removeEvents', event.title);
			if (title) {
				var eventData = {
					title : $('#title').val(),
					start : '2018-01-12'
				};
				$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
			}
			$('#calendar').fullCalendar('unselect');

			// Clear modal inputs
			$('.modal').find('input').val('');

			// hide modal
			$('.modal').modal('hide');
		});
	});
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
</style>
</head>
<body>
	<div id='wrap'>
		<div id='calendar'></div>
		<div id='datepicker'></div>

		<div class="modal fade" tabindex="-1" role="dialog">
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
							<!-- 
							<div class="col-xs-12">
								<label class="col-xs-4" for="title">���</label> 
								<input type="text" name="title" id="title" />
							</div>-->
							<div class="col-md-12">
								<table class="table">
									<thead>
										<tr>
											<th class="text-center">이름</th>
											<th class="text-center">출결 현황</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>Mark</td>
											<td><select>
													<option value="att">출석</option>
													<option value="late">지각</option>
													<option value="abs">결석</option>
													<option value="oaa">공결</option>
											</select></td>
										</tr>
										<tr>
											<td>Jacob</td>
											<td><select>
													<option value="att">출석</option>
													<option value="late">지각</option>
													<option value="abs">결석</option>
													<option value="oaa">공결</option>
											</select></td>
										</tr>
										<tr>
											<td>Larry</td>
											<td><select>
													<option value="att">출석</option>
													<option value="late">지각</option>
													<option value="abs">결석</option>
													<option value="oaa">공결</option>
											</select></td>
										</tr>
										<tr>
											<td>김희진</td>
											<td><select>
													<option value="att">출석</option>
													<option value="late">지각</option>
													<option value="abs">결석</option>
													<option value="oaa">공결</option>
											</select></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
						<button type="button" class="btn btn-primary" id="save-event">���
							����</button>
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
