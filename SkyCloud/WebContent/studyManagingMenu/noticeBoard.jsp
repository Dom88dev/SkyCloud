<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<c:set value="10" var="recordsPerPage"/>
<c:set value="5" var="pagesPerBlock"/>
<c:choose>
	<c:when test="${empty currentNoticePage}">
		<c:set value="0" var="currentPage"/>
	</c:when>
	<c:otherwise>
		<c:set value="${currentNoticePage}" var="currentPage"/>
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${empty currentNoticeBlock}">
		<c:set value="0" var="currentBlock"/>
	</c:when>
	<c:otherwise>
		<c:set value="${currentNoticeBlock}" var="currentBlock"/>
	</c:otherwise>
</c:choose>
<c:set value="${recordsPerPage * currentPage}" var="beginNumPerPage"/>
<c:set value="${pagesPerBlock * currentBlock}" var="beginNumPerBlock"/>
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
		color:#02b2e3;
	}
	
	h3#noticeBoardLabel {
		color: white;
    	text-shadow: 1px 1px 2px #02b2e3, 0 0 10px #39d2fd, 0 0 5px #9ae8fe;
	}
	
	li.previous a, li.next a, ul.pagination li a {
		color:#39d2fd;
	}
	
	ul.pagination li a:hover {
		color:#02b2e3;
	}
	
	ul.pagination li.active a {
		background-color: #39d2fd;
		border-color: #02b2e3;
	}
	
	ul.pagination li.active a:hover {
		background-color: #02b2e3;
	}
	
	hr.hr {
		margin-top: 0.1em;
		margin-bottom: 0.1em;
		padding: 0;
	}
	
	li.previous a.disabledPager, li.next a.disabledPager {
		background-color:#eee;
	}
</style>
<script>
(function() {
	$.post("/StudyCloud/ajax", {command:"LOADNOTICE", stdId:"${myStdList[index].std_id}"}, 
		function(data) {
			fnLoadNotice(data);
	});
})();

function fnLoadNotice(data) {
	var jsonData = $.parseJSON(data);
	if(jsonData){
		var nList = jsonData.noticeList;
		var tBody = $("div.tbody");
		var previousP = $("li.previous");
		var nextP = $("li.next");
		var pageList = $("ul.pagination");
		var totalPage = Math.ceil(nList.length/'${recordsPerPage}');
		var totalBlock = Math.ceil(totalPage/"${pagesPerBlock}");
		tBody.empty();
		pageList.empty();
		if(nList.length > 0) {
			//레코드 처리
			if(nList.length>'${recordsPerPage}') {
				for(var i='${beginNumPerPage}';i<'${beginNumPerPage + recordsPerPage}'; i++) {
					if('${currentPage}'==(totalPage-1)) {
						if(i==(nList.length%'${recordsPerPage}')) {
							break;
						}
					}
					createNoticeRecord(nList, i);
				}
			} else {
				for(var i='${beginNumPerPage}';i<nList.length; i++) {
					createNoticeRecord(nList, i);
				}
			}
			
			//페이징 처리
			if('${currentBlock}'==0) {
				previousP.empty();
				var previous = document.createElement("a");
				$(previous).addClass("disabledPager");
				$(previous).text("이전");
				previousP.append(previous);
			} else {
				$(previousP).find("a").removeClass("disabledPager");
				$(previousP).find("a").attr("href", "javascript:fnPreviousBlock('${currentBlock}')");
			}
			if('${currentBlock}'==(totalBlock-1)) {
				nextP.empty();
				var next = document.createElement("a");
				$(next).addClass("disabledPager");
				$(next).text("다음");
				nextP.append(next);
			} else {
				$(nextP).find("a").removeClass("disabledPager");
				$(nextP).find("a").attr("href", "javascript:fnNextBlock('${currentBlock}')");
			}
			for(var i='${beginNumPerBlock}';i<'${beginNumPerBlock + pagesPerBlock}';i++) {
				if('${currentBlock}'==(totalBlock-1)){
					if(i==(totalPage%'${pagesPerBlock}')){
						break;
					}
				}
				var li = document.createElement("li");
				var a = document.createElement("a");
				if(i=='${currentPage}') {
					$(li).addClass("active");
				}
				$(a).attr("href", "javascript:fnSelectPage("+i+")");
				$(a).text(Number(i)+1);
				li.append(a);
				pageList.append(li);
			}
		}
	}
}

//이전 블럭으로 이동
function fnPreviousBlock(cBlock) {
	
}

//다음 블럭으로 이동
function fnNextBlock(cBlock) {
	
}

function createNoticeRecord(nList, i) {
	var tBody = $("div.tbody");
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
	$(titleDiv).text(nList[i].title);
	var d = new Date(nList[i].b_datetime);
	$(dateDiv).text(d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate());
	$(rpNumDiv).text(nList[i].replies_cnt);
	$(viewNumDiv).text(nList[i].view_cnt);
	recordDiv.append(titleDiv);
	recordDiv.append(dateDiv);
	recordDiv.append(rpNumDiv);
	recordDiv.append(viewNumDiv);
	$(tBody).append(recordDiv);
	var hr = document.createElement("hr");
	$(hr).addClass("hr col-md-12");
	$(tBody).append(hr);
}

</script>
<div class="col-md-12" align="center">
	<h3 id="noticeBoardLabel" align="center">공지사항</h3>
	<div class="tableDiv col-md-12" align="justify">
		<div class="thead" align="center">
			<div class="col-md-8">제목</div>
			<div class="col-md-2">등록일</div>
			<div class="col-md-1">댓글 수</div>
			<div class="col-md-1">조회 수</div>
		</div>
		<div class="tbody" align="center">
			<div align="center">공지사항이 없습니다.</div>
		</div>
		<div class="tfoot">
			<div class="col-md-4">
				<ul class="pager">
					<li class="previous"><a>이전</a></li>
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="pagination">
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="pager">
					<li class="next"><a>다음</a></li>
				</ul>
			</div>
		</div>
	</div>
	
</div>
