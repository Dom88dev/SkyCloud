<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script>
	(function() {
		$.post("/StudyCloud/ajax", {command:"LOADSTUDYINFO", leaderEmail: "${myStdList[index].email}", stdId:"${myStdList[index].std_id}"}, 
			function(data) {
				alert(data);
				var jsonData = $.parseJSON(data);
				if(jsonData){
					var leader = jsonData.leader;
					var nList = jsonData.noticeList;
					var hList = jsonData.homeworkList;
					
					$("#leaderName").text(leader.name);
					$("#leaderPhone").text(leader.tel);
					var memTxt = $("#numOfMem").text();
					$("#numOfMem").text(jsonData.currentMemNum + memTxt);
				}
		});
	})();
</script>
<style>
	div#studyTitleDiv {
		background-image:url('/StudyCloud/images/categories/${myStdList[index].std_category}.png'); 
		width:50%; background-repeat: no-repeat; background-position: center; background-size: 100%; 
		color: white;
    	text-shadow: 1px 1px 2px #02b2e3, 0 0 25px blue, 0 0 5px #39d2fd;
	}
</style>
<div class="col-md-12" align="center">
	<div id="studyTitleDiv">
		<h2>${myStdList[index].std_name}</h2>
		<div>
			<i class="fa fa-calendar">${myStdList[index].std_start} ~ ${myStdList[index].std_end}</i>&nbsp;<i class="fa fa-users" id="numOfMem">/${myStdList[index].std_max}</i><br>
			<i class="glyphicon glyphicon-tower" id="leaderName"></i>&nbsp;<i class="glyphicon glyphicon-phone" id="leaderPhone"></i><br><br>
			<p>${myStdList[index].std_info}</p>
		</div>
	</div>
	<div class="col-md-10">
		<div class="col-md-6">
			<h4>스터디 계획</h4>
			<p>${myStdList[index].std_plan}</p>
			<h4>기타사항</h4>
			<p>${myStdList[index].std_etc}</p>
		</div>
		<div class="col-md-6">
			<h4>시간 및 장소</h4>
			<c:set value="${myStdList[index].timePlaceList}" var="timeplaceList"></c:set>
				<c:forEach begin="0" end="${fn:length(timeplaceList) - 1}" step="1" var="j">
				<div id="studyTimePlaceDiv">
					<i class="glyphicon glyphicon-time">${timeplaceList[j].std_time} ~ ${timeplaceList[j].std_time + (timeplaceList[j].std_hour * 100)}</i><span>${timeplaceList[j].std_day}</span>요일<br>
					<i class="glyphicon glyphicon-map-marker">${timeplaceList[j].std_addr}</i>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="col-md-2">
	
	</div>
</div>
