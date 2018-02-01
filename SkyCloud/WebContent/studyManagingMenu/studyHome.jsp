<%@ page contentType="text/html; charset=UTF-8"%>
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
		color:#02b2e3;
	}
</style>
<div class="col-md-12" align="center">
	<div id="studyTitleDiv">
		<h2>${myStdList[index].std_name}</h2>
		<div>
			<i class="fa fa-calendar">${myStdList[index].std_start} ~ ${myStdList[index].std_end}</i>&nbsp;<i class="fa fa-users" id="numOfMem">/${myStdList[index].std_max}</i><br>
			<i class="glyphicon glyphicon-tower" id="leaderName"></i>&nbsp;<i class="glyphicon glyphicon-phone" id="leaderPhone"></i>
		</div>
	</div>
	<div class="col-md-10">
		<div class="col-md-6">
			
		</div>
		<div class="col-md-6">
		
		</div>
	</div>
	<div class="col-md-2">
	
	</div>
</div>
