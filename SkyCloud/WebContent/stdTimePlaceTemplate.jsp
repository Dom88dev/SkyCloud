<%@ page contentType="text/html; charset=UTF-8"%>
<div class="timePlaceDiv col-sm-12" id="${param.stdPlaceDivId}">
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
		<input type="text" name="std_addr" class="rform-control" placeholder="도로명 주소나 지번주소를 입력해주세요" id="address">
	</div>
	<div class="col-sm-2" style="padding:0;">
		<button type="button" class="btn btn-white" id="submit">위치 확인</button>
	</div>
	<div class="col-sm-2" style="padding:0; line-height:40px;" align="right">
		<button class="btn-trans" type="button" onclick="fnRemovePlace('${param.stdPlaceDivId}')"><i class="fa fa-minus-square-o" style="color:#39d2fd;"></i></button>
		<button class="btn-trans" type="button" onclick="fnAddPlace()"><i class="fa fa-plus-square-o" style="color:#39d2fd;"></i></button>
	</div>
</div>