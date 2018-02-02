<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<style>
	div.table {
		margin: 2%
	}

	div.thead div {
		padding:0.5%;
		font-size: 0.8em;
		color:white;
		background-color:#39d2fd;
	}
	
	div.record div {
		padding:0.5%;
		font-size: 0.8em;
		color:#39d2fd;
	}
	
	div.record {
		border-bottom: 0.5px solid #e8e8e8;
	}
	
	h3#noticeBoardLabel {
		color: white;
    	text-shadow: 1px 1px 2px #02b2e3, 0 0 10px #39d2fd, 0 0 5px #9ae8fe;
	}
</style>
<script>
(function() {
	$.post("/StudyCloud/ajax", {command:"LOADNOTICE", stdId:"${myStdList[index].std_id}"}, 
		function(data) {
			var jsonData = $.parseJSON(data);
			if(jsonData){
				var nList = jsonData.noticeList;
				var tBody = $("div.tbody");
				tBody.empty();
				
				var recordDiv = document.createElement("div");
				$(recordDiv).addClass("record");
				var titleDiv = document.createElement("div");
				$(titleDiv).addClass("col-md-8");
				var dateDiv = document.createElement("div");
				$(dateDiv).addClass("col-md-2");
				var rpNumDiv = document.createElement("div");
				$(rpNumDiv).addClass("col-md-1");
				var viewNumDiv = document.createElement("div");
				$(viewNumDiv).addClass("col-md-1");
				$(titleDiv).text(nList[0].title);
				var d = new Date(nList[0].b_datetime);
				$(dateDiv).text(d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate());
				$(rpNumDiv).text(nList[0].replies_cnt);
				$(viewNumDiv).text(nList[0].view_cnt);
				recordDiv.append(titleDiv);
				recordDiv.append(dateDiv);
				recordDiv.append(rpNumDiv);
				recordDiv.append(viewNumDiv);
				$(tBody).append(recordDiv);
			}
	});
})();
</script>
<c:set value="10" var="recordsPerPage"/>
<c:set value="5" var="pagesPerBlock"/>
<div class="col-md-12" align="center">
	<h3 id="noticeBoardLabel" align="center">공지사항</h3>
	<div class="tableDiv">
		<div class="thead" align="center">
			<div class="col-md-8">제목</div>
			<div class="col-md-2">등록일</div>
			<div class="col-md-1">댓글 수</div>
			<div class="col-md-1">조회 수</div>
		</div>
		<div class="tbody" align="center">
			
		</div>
		<div class="tfoot">
			<div class="col-md-4">
				<ul class="pager">
					<li class="previous"><a href="#">이전</a></li>
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="pagination">
					<li><a href="#">1</a></li>
					<li class="active"><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">5</a></li>
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="pager">
					<li class="next"><a href="#">다음</a></li>
				</ul>
			</div>
		</div>
	</div>
	
</div>
