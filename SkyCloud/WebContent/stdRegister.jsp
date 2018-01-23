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
<!-- <link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/checkbox.css"> -->
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=FCutdjqYcxIgr5S5ObN8&submodules=geocoder"></script> -->

<style>
label, select {
	padding: 3px;
	font-size: 12pt;
	font-style: 맑은 고딕;
	color: #39d2fd;
}

.radio-control {
	font-size: 10pt;
}

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
    border: 2.3px solid #39d2fd;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
i { color : #39d2fd}

.search {
    position: absolute;
    z-index: 1000;
    top: 20px;
    left: 20px;
	}
</style>
</head>
<body>
	<!-- navbar -->
	<div id="navbar" class="navbar navbar-fixed-top">
		<jsp:include page="/WEB-INF/templates/navbar/navbarLogOut.jsp"></jsp:include>
	</div>

	<div class="container" style="width:63%; margin-top: 100px">
		<div class="row">
			<div class="col-md-12">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">스터디명</label>
						</div>
						<div class="col-sm-10">
							<input type="text" class="rform-control" id="stdName"
								placeholder="등록할 스터디명을 입력">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">스터디 종류</label>
						</div>
						<div class="col-sm-2">
							<select>
								<option selected="selected" hidden="hidden">대분류</option>
								<option>어학</option>
 								<option>취업</option>
  								<option>자격증</option>
  								<option>뷰티</option>
  								<option>스포츠</option>
  								<option>기타</option>
							</select>
						</div>
						<div class="col-sm-8">
							<input type="text" class="rform-control" id="stdKind"
								placeholder="세부 분류는 직접 입력">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">모집 인원</label>
						</div>
						<div class="col-sm-2">
							<input type="text" class="rform-control" id="stdMax"
								placeholder="인원 수">
						</div>
						<div class="col-sm-8">
							<label class="radio-control">남성</label> <input type="radio"
								value="male" name="stdGender"> <label
								class="radio-control">여성</label> <input type="radio"
								name="stdGender" value="female" class="radio-control"> <label
								class="radio-control">혼성</label> <input type="radio"
								name="stdGender" value="bothGender" class="radio-control">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">스터디 기간</label>
						</div>
					<div class="input-daterange date" id="datepicker1" style="width: 320px; display: inline-table;">
					<input type="text" class="form-control" id="sdate1"	style="width: 115px;" /> 
					<label class="date-range" for="sdate1">
						<i class="glyphicon glyphicon-calendar"></i>
					</label> 
					<span style="display: table-cell; padding: 0px 10px;"> ~ </span> 
					<input type="text" class="form-control" id="edate1"	style="width: 115px; border-radius: 3px 0 0 3px;" />
					 <label	class="date-range" for="edate1"> 
						 <i	class="glyphicon glyphicon-calendar"></i>
					</label>
				</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">장소 및 시간</label>
						</div>
						<div class="col-sm-10" id="timePlaceDiv">
							<div class="col-sm-12" style="background-color: #cdf4fe">
								<div class="col-sm-5">
									<br>
									<input type="number" name="time" min="0" max="23" placeholder="시" style="text-align:center">
									
									<input type="number" name="time" min="0" max="59" placeholder="분" style="text-align:center">
													
									<label style="color:#000">부터&nbsp;&nbsp;&nbsp;</label>
									<br>
									<input type="number" name="hour" min="0" max="8" placeholder="몇" style="text-align:center">
									<label style="color:#000">시간</label>
								</div>
								<div class="col-sm-5">
									<table class="table">
										<tbody>
											<tr>
												<th>월</th>
												<th>화</th>
												<th>수</th>
												<th>목</th>
												<th>금</th>
												<th>토</th>
												<th>일</th>
											</tr>
											<tr>
												<td><input type="checkbox" value="mon"></td>
												<td><input type="checkbox" value="mon"></td>
												<td><input type="checkbox" value="mon"></td>
												<td><input type="checkbox" value="mon"></td>
												<td><input type="checkbox" value="mon"></td>
												<td><input type="checkbox" value="mon"></td>
												<td><input type="checkbox" value="mon"></td>
											</tr>
										</tbody>
									</table>
								</div>
								<br>
								<div class="col-sm-8">
									<input type="text" class="rform-control" placeholder="도로명 주소나 지번주소를 입력해주세요" id="address">
									<br>
								</div>
								<div class="col-sm-2">
									<button type="submit" class="btn btn-default" id="submit">위치 확인</button>
								</div>
								<div class="col-sm-2">
									<button type="button" class="glyphicon glyphicon-plus" onclick="fnAddPlace()"></button>
									<button type="button" class="glyphicon glyphicon-minus"></button>
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">스터디 소개글</label>
						</div>
						<div class="col-sm-10">
							<textarea class="rform-control" style="width: 100%; height: 100px"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">스터디 계획</label>
						</div>
						<div class="col-sm-10">
							<textarea class="rform-control" style="width: 100%; height: 100px"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 text-center">
							<label class="control-label">기타사항</label>
						</div>
						<div class="col-sm-10">
							<textarea class="rform-control" style="width: 100%; height: 100px"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<label>연락처 공개</label> <input type="checkbox">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-6">
							<button type="submit" class="btn btn-default btn-lg">등록</button>
						</div>
					</div>
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
<script type="text/javascript" src="/StudyCloud/lib/js/ajax.js"></script>
<script>
	var placeIdNum = 1;
	function fnAddPlace() {
		var param = "stdPlaceDivId=timePlace"+placeIdNum++;
		sendRequest("GET", "stdTimePlaceTemplate.jsp", param, callback);
	}
	
	function callback() {
		if(httpRequest.readyState != 4) return;
		if(httpRequest.status != 200) return;
		var addData = httpRequest.responseText;
		document.getElementById("timePlaceDiv").innerHTML+= addData;
	}
	
	function fnRemovePlace(divId) {
		var child = document.getElementById(divId);
		child.parentNode.removeChild(child);
	}
</script>

</html>