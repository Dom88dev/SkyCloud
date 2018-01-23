<%@ page contentType="text/html; charset=UTF-8"%>
<div class="col-sm-12" style="background-color: #cdf4fe" id="${param.stdPlaceDivId}">
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
		<button type="button" class="glyphicon glyphicon-minus" onclick="fnRemovePlace('${param.stdPlaceDivId}')"></button>
	</div>
</div>