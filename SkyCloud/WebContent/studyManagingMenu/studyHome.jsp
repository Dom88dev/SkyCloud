<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/stdRegisterCss.css">
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>

<script>
	(function() {
		$.post("/StudyCloud/json", {command:"LOADSTUDYINFO", leaderEmail: "${myStdList[index].email}", stdId:"${myStdList[index].std_id}"}, 
			function(data) {
				var jsonData = $.parseJSON(data);
				if(jsonData){
					var leader = jsonData.leader;
					var nList = jsonData.noticeList;
					var hList = jsonData.homeworkList;
					
					$("#leaderName").text(leader.name);
					$("#leaderPhone").text(leader.tel);
					var memTxt = $("#numOfMem").text();
					$("#numOfMem").text(jsonData.currentMemNum + memTxt);
					
					if(nList.length > 0) {
						$("#stdHome_notice div.panel-body").empty();
						if(nList.length>4) {
							for(var i=0; i<5; i++) {
								var div = document.createElement("div");
								var a = document.createElement("a");
								$(a).text(nList[i].title);
								$(a).attr("href", "javascript:fnGoToBoard('stdNotice', '"+nList[i].b_id+"');")
								div.append(a);
								$("#stdHome_notice div.panel-body").append(div);
							}
						} else {
							for(var i=0; i<nList.length; i++) {
								var div = document.createElement("div");
								var a = document.createElement("a");
								$(a).text(nList[i].title);
								$(a).attr("href", "javascript:fnGoToBoard('stdNotice', '"+nList[i].b_id+"');")
								div.append(a);
								$("#stdHome_notice div.panel-body").append(div);
							}
						}
					}
					
					if(hList.length > 0) {
						$("#stdHome_homework div.panel-body").empty();
						if(hList.length>4) {
							for(var i=0; i<5; i++) {
								var div = document.createElement("div");
								var a = document.createElement("a");
								$(a).text(hList[i].title);
								$(a).attr("href", "javascript:fnGoToBoard('stdHomework', '"+hList[i].b_id+"');");
								div.append(a);
								$("#stdHome_homework div.panel-body").append(div);
							}
						} else {
							for(var i=0; i<hList.length; i++) {
								var div = document.createElement("div");
								var a = document.createElement("a");
								$(a).text(hList[i].title);
								$(a).attr("href", "javascript:fnGoToBoard('stdHomework', '"+hList[i].b_id+"');");
								div.append(a);
								$("#stdHome_homework div.panel-body").append(div);
							}
						}
						
					}
				}
		});
	})();
	
	//위치확인 모달창 띄우는 function
	function fnMapPopup(addr) {
		$('#mapframe').attr("src","/StudyCloud/studyHomeMap.jsp?addr='"+addr+"'");
		$('#mapModal').modal();
	}
	
	function fnGoToBoard(menu, b_id) {
		currentMenu = menu;
		$.post("/StudyCloud/json", {"command":"MNG_CHANGESTUDY", "index":currentIndex, "includeStdMenu":menu}, 
				function(data) {
					fnNotifyChangeStdMenu(b_id);
					fnRemoveSelectStdMenu();
			});
	}
	
</script>
<style>
	div#studyTitleDiv {
		background-image:url('/StudyCloud/images/categories/${myStdList[index].std_category}.png'); 
		width:50%; background-repeat: no-repeat; background-position: center; background-size: 100%; 
		color: white;
    	text-shadow: 1px 1px 2px #02b2e3, 0 0 10px #39d2fd, 0 0 5px #9ae8fe;
    	margin-bottom: 2%;
	}
	
	div.studyTimePlaceDiv, h4 + p {
		color: #02b2e3;
		font-size: 12px;
	}
	
	div.col-md-6 div {
		border-bottom: 0.7px solid rgba(57, 210, 253, 0.2);
		padding-bottom: 1%;
	}
	
	div.col-md-6 h4 {
		color: white;
   		text-shadow: -1px 0 #39d2fd, 0 1px #39d2fd, 1px 0 #39d2fd, 0 -1px #39d2fd;
	}
	
	button.btn-white {
	border: 0.4px solid #39d2fd;
	color: #39d2fd;
	background-color: #ffffff;
	border-radius: 3em;
}

button.btn-white:active, button.btn-white.active, .open>.dropdown-toggle.btn-white {
	color: #39d2fd;
	background-color: #ffffff;
	border: 0.4px solid #39d2fd;
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
	outline:none;
}

button.btn-white:hover {	border: 0.4px solid #39d2fd;	color: #39d2fd;	background-color: #fff; }
button.btn-white:focus {	border: 0.4px solid #39d2fd;	color: #39d2fd;	background-color: #fff;	outline:none;	}
div.panel-body div a {
	overflow: hidden;
	text-overflow: ellipsis;
	width:100%;
	display: -webkit-box;
	-webkit-line-clamp: 1; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap:break-word; 
	line-height: 1.2em;
	heigt:1.2em;
}
</style>
<div class="col-md-12" align="center">
	<div class="col-md-9">
		<div id="studyTitleDiv">
			<h2 style="padding-top:5%; padding-right:1%; padding-left:1%;">${myStdList[index].std_name}</h2>
			<div style="padding-bottom:2%; padding-right:1%; padding-left:1%;">
				<i class="fa fa-calendar">${myStdList[index].std_start} ~ ${myStdList[index].std_end}</i>&nbsp;<i class="fa fa-users" id="numOfMem">/${myStdList[index].std_max}</i><br>
				<i class="glyphicon glyphicon-tower" id="leaderName"></i>&nbsp;<i class="glyphicon glyphicon-phone" id="leaderPhone"></i><br><br>
				<p>${myStdList[index].std_info}</p>
			</div>
		</div>
		<div class="col-md-6">
			<div>
				<h4>스터디 계획</h4>
				<p>${myStdList[index].std_plan}</p>
			</div>
			<div>
				<h4>기타사항</h4>
				<p>${myStdList[index].std_etc}</p>
			</div>
		</div>
		<div class="col-md-6">
			<h4>시간 및 장소</h4>
			<c:set value="${myStdList[index].timePlaceList}" var="timeplaceList"></c:set>
				<c:forEach begin="0" end="${fn:length(timeplaceList) - 1}" step="1" var="j">
				<div class="studyTimePlaceDiv">
					<i class="glyphicon glyphicon-time">${timeplaceList[j].std_time} ~ ${timeplaceList[j].std_time + (timeplaceList[j].std_hour * 100)}</i>&nbsp;<span>${timeplaceList[j].std_day}</span>요일<br>
					<i class="glyphicon glyphicon-map-marker">${timeplaceList[j].std_addr}</i>&nbsp;<button class="btn-white" onclick="fnMapPopup('${timeplaceList[j].std_addr}')">위치 확인</button>
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="col-md-3">
		<div align="justify" style="margin-bottom: 4%;">
			<button class="btn btn-info">출석 체크</button>
			<c:if test="${email == myStdList[index].email }">
				<form action="/StudyCloud/fwd" method="post">
				<input type="hidden" name="command" value="STUDYUPDATEINFO">
				<input type="hidden" name="stdId" value="${myStdList[index].std_id}">
				<button class="btn btn-white" type="submit">스터디 수정<i class="fa fa-cog"></i></button>
				</form>
			</c:if>
		</div>
		<div class="panel panel-info" id="stdHome_notice">
			<div class="panel-heading">공지 사항</div>
			<div class="panel-body">공지사항이 없습니다.</div>
		</div>
		<div class="panel panel-info" id="stdHome_homework">
			<div class="panel-heading">과제</div>
			<div class="panel-body">과제가 없습니다.</div>
		</div>
	</div>
</div>

<!-- Map modal -->
			<div class="modal fade" id="mapModal" data-backdrop="static">
				<div class="modal-dialog">
					<div class="modal-content">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<iframe id="mapframe"  width="100%" height="500px" style="border:none">
						</iframe>
						<div align="center">
						<button class="btn btn-info" id="mapClose" data-dismiss="modal">닫기</button>
						</div>
					</div>
					
				</div>
			</div>



