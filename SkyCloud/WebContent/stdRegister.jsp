<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud 스터디 등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" >
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/bootstrap337/css/bootstrap.css"  >
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/datepicker3.css">
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=FCutdjqYcxIgr5S5ObN8&submodules=geocoder"></script> -->

<style>
th label {
	margin-top: 5px;
	font-size: 10pt;
	font-style: 맑은 고딕;
	color: #39d2fd;
}

th { vertical-align: top; }
td { vertical-align: middle;	padding: 0;}

div hr { margin-bottom: 5px;	margin-top: 5px; }

.selectbox {
	padding: 0;
	height: 34px;
    position: relative;
    border: 0.4px solid #39d2fd;
    border-radius: 4px;
    z-index: 1;
}
/* 가상 선택자를 활용 화살표 대체 */
.selectbox:before {
    content: "";
    position: absolute;
    top: 50%;
    right: 5px;
    width: 0;
    height: 0;
    margin-top: -1px;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-top: 5px solid #39d2fd;
}

.selectbox label {
    position: absolute;
    top: -1px;  /* 위치정렬 */
    left: 5px;  /* 위치정렬 */
    padding: .8em .5em;  /* select의 여백 크기 만큼 */
    color: #39d2fd;
    z-index: -1;  /* IE8에서 label이 위치한 곳이 클릭되지 않는 것 해결 */
    font-style: italic;
    font-size: 12px;
}

.selectbox select {
    width: 100%;
    height: 34px;  /* 높이 초기화 */
    line-height: normal;  /* line-height 초기화 */
    font-family: inherit;  /* 폰트 상속 */
    padding: .8em .5em;  /* 여백과 높이 결정 */
    border: 0;
    opacity: 0;  /* 숨기기 */
    filter:alpha(opacity=0);  /* IE8 숨기기 */
    -webkit-appearance: none; /* 네이티브 외형 감추기 */
    -moz-appearance: none;
    appearance: none;
}

.selectbox.focus {
    -webkit-box-shadow: inset 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
    box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
}

table { margin: 50px; }

.weekstyle {
	font-size: 8pt;
} 

.rform-control {
	display: block;
    width: 100%;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border-left: 0px solid rgba(0, 0, 0, 0);
    border-right: 0px solid rgba(0, 0, 0, 0);
    border-top: 0px solid rgba(0, 0, 0, 0);
    border-bottom: 0.4px solid #39d2fd;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0);
    box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

.rform-control-inline {
    height: 34px;
    font-size: 12px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border-left: 0px solid rgba(0, 0, 0, 0);
    border-right: 0px solid rgba(0, 0, 0, 0);
    border-top: 0px solid rgba(0, 0, 0, 0);
    border-bottom: 0.4px solid #39d2fd;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0);
    box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

textarea.rform-control {
	border-bottom: 0.4px solid #39d2fd;
	border-radius: 0 0 4px 0;
}

.input-daterange input {
    width: 100%;
    font-size: 14px;
    line-height: 1.42857143;
    color: #39d2fd	;
    background-color: rgba(0, 0, 0, 0);
    background-image: none;
    border: 0px solid rgba(0, 0, 0, 0);
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0);
    box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

div#dateSeperator { 
	color: #555;
	background-color: rgba(0, 0, 0, 0);
    background-image: none; 
    border: 0px solid rgba(0, 0, 0, 0);
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0);
    box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

#datepicker1 {
    width: 100%;
    padding:0;
	background-color: #fff;
    background-image: none;
}

td.dateTd {
	border-left: 0px solid rgba(0, 0, 0, 0);
    border-right: 0px solid rgba(0, 0, 0, 0);
    border-top: 0px solid rgba(0, 0, 0, 0);
    border-bottom: 0.4px solid #39d2fd;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

.radio-control {
	font-size: 10pt;
	vertical-align: middle;
}

input[type=radio], input[type=checkbox] {
	width:	0px;	height: 0px;
}

input:checked + i.fa { 
	color : #fff;
    background: #39d2fd; 
	border-radius:50px; padding: 12px; font-size: 12px;
}
input + i.fa { color : #39d2fd; padding: 12px; font-size: 12px; }

input:checked + label { 
	color : #fff;
    background: #39d2fd; 
	border-radius:25px; font-size: 12px;
	padding-right: 8px;	padding-left: 8px;
	padding-top: 5px;	padding-bottom: 5px;
}

input + label { 
	color : #39d2fd; font-size: 12px; 	
	padding-right: 8px;	padding-left: 8px;	
	padding-top: 5px;	padding-bottom: 5px; 
}

input#contact_open + label i { visibility: hidden; }
input#contact_open:checked + label i { visibility: visible; }

div.timePlaceDiv {
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
	padding: 6px;	margin-bottom: 8px;
	background: #fff;
}

button.btn.active.focus, button.btn.active:focus, button.btn.focus, button.btn:active.focus,
	button.btn:active:focus, button.btn:focus {
	outline: none;
	outline-offset: 0;
}

button.btn.active, button.btn:active {
	background-image: none;
	outline: none;
	-webkit-box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
	box-shadow: inset 0 0 0 rgba(0, 0, 0, .0);
	background-color: #ffffff;
	color: #39d2fd;
}

button.btn-trans {
	background:none;
	border:none;
	padding:0;
}

button.btn-trans:focus, button.btn-trans:active { outline: none;	}
button.btn-trans:active i { color:	#028bb1; }
button.btn-trans:hover i { text-shadow: 0 0 3px #39d2fd;	background: none;	}

button.btn-white {
	border: 0.4px solid #39d2fd;
	color: #39d2fd;
	background-color: #ffffff;
}

button.btn-white:active, button.btn-white.active, .open>.dropdown-toggle.btn-white 
{
	color: #39d2fd;
	background-color: #ffffff;
	border: 0.4px solid #39d2fd;
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
	outline:none;
}

button.btn-white:hover {	border: 0.4px solid #39d2fd;	color: #39d2fd;	background-color: #fff; }
button.btn-white:focus {	border: 0.4px solid #39d2fd;	color: #39d2fd;	background-color: #fff;	outline:none;	}

button.btn-info:active {
	border: 0.4px solid #39d2fd;
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
	outline:none;
}
button.btn-info{ width: 50%; background-color: #39d2fd; }

input:focus, select:focus {
  outline: none;
}


</style>
</head>
<body>
	<div class="container-fluid" style="width:70%;">
		<div class="row">
			<div class="col-md-12">
				<form class="form-horizontal" role="form" method="post" action="/StudyCloud/main">
					<input type="hidden" name="command" value="REGISTUDY">
					<table>
						<tr>
							<th class="col-sm-2">
								<label>스터디명</label>
							</th>
							<td colspan="2" class="col-sm-10">
								<div class="form-group">
									<div class="selectbox col-sm-2">
										<label for="std_category">대분류</label>
										<select id="std_category" name="std_category">
											<option selected="selected" hidden="hidden" value="select">대분류</option>
											<option value="lang">어학</option>
			 								<option value="job">취업</option>
			  								<option value="cert">자격증</option>
			  								<option value="bea">뷰티</option>
			  								<option value="spt">스포츠</option>
			  								<option value="etc">기타</option>
										</select>
									</div>
									<input type="text" class="rform-control col-sm-10" name="std_name"
										placeholder="등록할 스터디명을 입력">
								</div>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>모집 인원</label>
							</th>
							<td colspan="2" class="col-sm-10">
								<div class="form-group" style="line-height: 35px;">
									<input type="number" class="rform-control col-sm-2" name="std_max" placeholder="인원 수" min="2">
									<div class="col-sm-10">
										<label class="radio-control">
											<input type="radio" value="M" name="std_gender">
											<i class="fa fa-mars"> 남자만</i>
										</label>
										<label class="radio-control">
											<input type="radio"	name="std_gender" value="F">
											<i class="fa fa-venus"> 여자만</i>
										</label>
										<label class="radio-control">
											<input type="radio" name="std_gender" value="B" checked="checked">
											<i class="fa fa-venus-mars"> 성별무관</i>
										</label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>스터디 기간</label>
							</th>
							<td colspan="2" class="col-sm-10 dateTd">
								<div class="input-group input-daterange" id="datepicker1">
								    <input type="text" class="form-control" name="std_start" data-date-start-date="0d" data-date-language="kr" data-date-autoclose="true" placeholder="시작 날짜를 선택해주세요.">
								    <div class="input-group-addon" id="dateSeperator"> ~ </div>
								    <input type="text" class="form-control" name="std_end" data-date-start-date="+7d" data-date-language="kr" data-date-autoclose="true" placeholder="종료 날짜를 선택해주세요.">
								</div>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>장소 및 시간</label>
							</th>
							<td colspan="2" class="col-sm-10" id="timePlaceTd" style="padding:3px;">
								<div class="timePlaceDiv col-sm-12" >
									<div class="col-sm-6" style="padding:0;">
										<input class="rform-control-inline text-info" size="2" type="number" name="std_time_h" min="0" max="23" placeholder="시" style="text-align:center">
										<label style="color:#000; padding:0;">:</label>
										<input class="rform-control-inline text-info" size="2" type="number" name="std_time_m" min="0" max="59" placeholder="분" style="text-align:center">			
										<label style="color:#000; padding:0;">부터&nbsp;</label>
										<input class="rform-control-inline text-info" size="1" type="number" name="std_hour" min="0" max="8" placeholder="몇" style="text-align:center">
										<label style="color:#000; padding:0;">시간</label>
									</div>
									<div class="col-sm-6" style="padding:0; vertical-align: middle;" align="justify">
										<input name="std_day" type="checkbox" id="mon"><label for="mon">월</label>
										<input name="std_day" type="checkbox" id="tue"><label for="tue">화</label>
										<input name="std_day" type="checkbox" id="wed"><label for="wed">수</label>
										<input name="std_day" type="checkbox" id="thur"><label for="thur">목</label>
										<input name="std_day" type="checkbox" id="fri"><label for="fri">금</label>
										<input name="std_day" type="checkbox" id="sat"><label for="sat">토</label>
										<input name="std_day" type="checkbox" id="sun"><label for="sun">일</label>
									</div>
									<div class="col-sm-12" style="padding:0;"><hr></div>
									<div class="col-sm-8" style="padding:0;">
										<input type="text" name="std_addr" class="rform-control" placeholder="도로명 주소나 지번주소를 입력해주세요" id="std_addr0">
									</div>
									<div class="col-sm-2" style="padding:0;">
										<button type="button" class="btn btn-white" onclick="popupMapModal('std_addr0')">위치 확인</button>
									</div>
									<div class="col-sm-2" style="padding:0; line-height:40px;" align="right">
										<button class="btn-trans" type="button" onclick="fnAddPlace()"><i class="fa fa-plus-square-o" style="color:#39d2fd;"></i></button>
									</div>
								</div>
							</td>
						</tr>
						
						<tr>
							<th class="col-sm-2">
								<label>스터디 소개글</label>
							</th>
							<td colspan="2">
								<textarea class="rform-control" style="width: 100%; height: 100px"></textarea>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>스터디 계획</label>
							</th>
							<td colspan="2">
								<textarea class="rform-control" style="width: 100%; height: 100px"></textarea>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>기타사항</label>
							</th>
							<td colspan="2">
								<textarea class="rform-control" style="width: 100%; height: 100px"></textarea>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"></td>
							<td colspan="2" style="padding-top: 5px;">
								<input id="contact_open" name="contact_open" type="checkbox" checked="checked">
								<label class="text-info" for="contact_open">연락처 공개<i class="glyphicon glyphicon-ok"></i></label>
							</td>
						</tr>
					</table>
					<div align="center">
						<button type="submit" class="btn btn-info" style="margin-bottom:100px;">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Map modal -->
			<div class="modal fade" id="mapModal" data-backdrop="static">
				<div class="modal-dialog">
					<div class="modal-content">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<iframe id="myframe" src="/StudyCloud/mapTest.jsp" width="100%" height="500px" style="border:none"></iframe>
						<div align="center">
						<button id="mapCheck">주소 확인</button>
						</div>
					</div>
					
				</div>
			</div>

</body>
<script src="/StudyCloud/lib/js/bootstrap-datepicker.js" ></script>
<script src="/StudyCloud/lib/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
<script>
	var placeIdNum = 1;
	function fnAddPlace() {
		$.post("stdTimePlaceTemplate.jsp",{	stdPlaceNum:placeIdNum++ } , callback);
	}
	
	function callback(data) {
		$("#timePlaceTd").append(data);
	}
	
	function fnRemovePlace(divId) {
		$("#" + divId).remove("");
	}
	
	$(function() {
	    var selectTarget = $('.selectbox select');

		selectTarget.on({
		    'focus': function() {
		      $(this).parent().addClass('focus');
		    },
		    'blur': function() {
		      $(this).parent().removeClass('focus');
		    }
		});
		
		  selectTarget.change(function() {
		    var select_name = $(this).children('option:selected').text();
		    $(this).siblings('label').text(select_name);
		    $(this).parent().removeClass('focus');
		});
	});
	
	// mapModal
	var currentAddrId = "";
	
	function popupMapModal(addrId) {
		currentAddrId = addrId;
		$('#mapModal').modal();
	}
	
	// mapIframe 값 가져오기
	$('#mapCheck').click(function(){
		var frame = document.getElementById("myframe");
	var getval = $("#myframe").contents().find('#address').val();
	$("#"+currentAddrId).val(getval);
	$('#mapModal').modal('hide');
	});
	

	$('.input-daterange input').each(function() {
	    $(this).datepicker('clearDates');
	});

</script>

</html>