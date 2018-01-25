<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
td { vertical-align: middle;}


select {
	display: block;
    width: 100%;
    height: 34px;
	color: #555;
    background-color: #fff;
    background-image: none;
    border: 0.4px solid #39d2fd;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
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

textarea.rform-control {
	border-bottom: 0.4px solid #39d2fd;
	border-radius: 0 0 4px 0;
}

#sdate1, #edate1 {
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
	border-radius:25px; padding: 12px; font-size: 12px;
	width:auto; height: auto;
}

input + label { color : #39d2fd; padding: 12px; font-size: 12px; width:auto; height: auto; }

div.timePlaceDiv {
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
}

button.btn-trans {
	background:none;
	border:none;
}


</style>
</head>
<body>
	<!-- 오늘 날짜 객체 생성 -->
	<jsp:useBean id="date" class="java.util.Date"/>
	<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="today"/>

	<div class="container-fluid" style="width:70%;">
		<div class="row">
			<div class="col-md-12">
				<form class="form-horizontal" role="form">
				<table>
					<tr>
						<th class="col-sm-2">
							<label>스터디명</label>
						</th>
						<td colspan="2" class="col-sm-10">
							<div class="form-group">
								<select name="std_category" class="control-label col-sm-2">
									<option selected="selected" hidden="hidden" value="select">대분류</option>
									<option value="lang">어학</option>
	 								<option value="job">취업</option>
	  								<option value="cert">자격증</option>
	  								<option value="bea">뷰티</option>
	  								<option value="spt">스포츠</option>
	  								<option value="etc">기타</option>
								</select>
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
							    <input type="text" class="form-control" id="sdate1" name="std_start">
							    <div class="input-group-addon" id="dateSeperator"> ~ </div>
							    <input type="text" class="form-control" id="edate1" name="std_end">
							</div>
						</td>
					</tr>
					<tr>
						<th class="col-sm-2">
							<label>장소 및 시간</label>
						</th>
						<td colspan="2" class="col-sm-10" id="timePlaceTd">
							<div class="timePlaceDiv col-sm-12" >
								<div class="col-sm-6">
									<input size="2" type="number" name="std_time_h" min="0" max="23" placeholder="시" style="text-align:center">
									<input size="2" type="number" name="std_time_m" min="0" max="59" placeholder="분" style="text-align:center">			
									<label style="color:#000">부터&nbsp;&nbsp;&nbsp;</label>
									<input size="1" type="number" name="std_hour" min="0" max="8" placeholder="몇" style="text-align:center">
									<label style="color:#000">시간</label>
								</div>
								<div class="col-sm-6">
									<input name="std_day" type="checkbox" id="mon"><label for="mon">월</label>
									<input name="std_day" type="checkbox" id="tue"><label for="tue">화</label>
									<input name="std_day" type="checkbox" id="wed"><label for="wed">수</label>
									<input name="std_day" type="checkbox" id="thur"><label for="thur">목</label>
									<input name="std_day" type="checkbox" id="fri"><label for="fri">금</label>
									<input name="std_day" type="checkbox" id="sat"><label for="sat">토</label>
									<input name="std_day" type="checkbox" id="sun"><label for="sun">일</label>
								</div>
								<hr>
								<div class="col-sm-8">
									<input type="text" name="std_addr" class="rform-control" placeholder="도로명 주소나 지번주소를 입력해주세요" id="address">
								</div>
								<div class="col-sm-2">
									<button type="button" class="btn btn-default" id="submit">위치 확인</button>
								</div>
								<div class="col-sm-2">
									<button class="btn-trans" type="button"><i class="fa fa-minus-square-o" style="color:#39d2fd;"></i></button>
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
						<td colspan="2">
							<label>연락처 공개</label> <input type="checkbox">
						</td>
					</tr>
					<tr>
						<td colspan="3" align="center">
							<button type="submit" class="btn btn-info">등록</button>
						</td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	</div>
	<!-- footer -->	
			<div id="footer">
				<jsp:include page="/WEB-INF/templates/footer.jsp"></jsp:include>
			</div>
</body>
<script type="text/javascript" src="/StudyCloud/lib/js/bootstrap-datepicker.js" ></script>
<script type="text/javascript" src="/StudyCloud/lib/js/bootstrap-datepicker.kr.js"  charset="UTF-8"></script>
<script>
	var placeIdNum = 1;
	function fnAddPlace() {
		var param = "timePlace"+placeIdNum++;
		$.post("stdTimePlaceTemplate.jsp",{	stdPlaceDivId:param } , callback);
	}
	
	function callback(data) {
		$("#timePlaceTd").append(data);
	}
	
	function fnRemovePlace(divId) {
		$("#" + divId).remove("");
	}
</script>

</html>