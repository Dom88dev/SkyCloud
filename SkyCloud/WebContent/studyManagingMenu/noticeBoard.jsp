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
		color:#02b2e3;
	}
	
	h3.boardLabel {
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
var recordsPerPage = 10;
var pagesPerBlock = 5;
var currentNPage = 0;
var currentNBlock = 0;
var beginNumPerNPage = recordsPerPage * currentNPage;
var beginNumPerNBlock = pagesPerBlock * currentNBlock;
var noticeData = "";
(function() {
	$.post("/StudyCloud/ajax", {command:"LOADNOTICE", stdId:"${myStdList[index].std_id}"}, 
		function(data) {
			noticeData = data;
			fnLoadNotice(data);
	});
})();

function fnLoadNotice(data) {
	var jsonData = $.parseJSON(data);
	if(jsonData){
		var nList = jsonData.noticeList;
		var tBody = $("div#nTbody");
		var previousP = $("li#nPrevious");
		var nextP = $("li#nNext");
		var pageList = $("ul#nPagination");
		var totalPage = Math.ceil(nList.length/recordsPerPage);
		var totalBlock = Math.ceil(totalPage/pagesPerBlock);
		tBody.empty();
		pageList.empty();
		if(nList.length > 0) {
			//레코드 처리
			if(nList.length>recordsPerPage) {
				if(currentNPage==(totalPage-1)) {
					for(var i=beginNumPerNPage;i<beginNumPerNPage + (nList.length%recordsPerPage); i++) {
						createNoticeRecord(nList, i);
					}
				} else {
					for(var i=beginNumPerNPage;i<beginNumPerNPage + recordsPerPage; i++) {
						createNoticeRecord(nList, i);
					}
				}	
			} else {
				for(var i=beginNumPerPage;i<nList.length; i++) {
					createNoticeRecord(nList, i);
				}
			}
			
			//페이징 처리
			if(currentNBlock==0) {
				previousP.empty();
				var previous = document.createElement("a");
				$(previous).addClass("disabledPager");
				$(previous).text("이전 블록");
				previousP.append(previous);
			} else {
				$(previousP).find("a").removeClass("disabledPager");
				$(previousP).find("a").attr("href", "javascript:fnPreviousBlockN("+currentNBlock+")");
			}
			if(currentNBlock==(totalBlock-1)) {
				nextP.empty();
				var next = document.createElement("a");
				$(next).addClass("disabledPager");
				$(next).text("다음 블록");
				nextP.append(next);
			} else {
				$(nextP).find("a").removeClass("disabledPager");
				$(nextP).find("a").attr("href", "javascript:fnNextBlockN("+currentNBlock+")");
			}
			
			if(currentNBlock==(totalBlock-1)){
				for(var i=beginNumPerNBlock;i<(beginNumPerNBlock + (totalPage%pagesPerBlock));i++) {
					var li = document.createElement("li");
					var a = document.createElement("a");
					if(i==currentNPage) {
						$(li).addClass("active");
					}
					$(a).attr("href", "javascript:fnSelectPageN("+i+")");
					$(a).text(Number(i)+1);
					li.append(a);
					pageList.append(li);
				}
			} else {
				for(var i=beginNumPerNBlock;i<(beginNumPerNBlock + pagesPerBlock);i++) {
					var li = document.createElement("li");
					var a = document.createElement("a");
					if(i==currentNPage) {
						$(li).addClass("active");
					}
					$(a).attr("href", "javascript:fnSelectPageN("+i+")");
					$(a).text(Number(i)+1);
					li.append(a);
					pageList.append(li);
				}
			}
		}
	}
}

//페이지 선택시 해당 페이지 로딩
function fnSelectPageN(page) {
	currentNPage = page;
	beginNumPerNPage = recordsPerPage * currentNPage;
	fnLoadNotice(noticeData);
}

//이전 블럭으로 이동
function fnPreviousBlockN(cBlock) {
	
}

//다음 블럭으로 이동
function fnNextBlockN(cBlock) {
	
}

function createNoticeRecord(nList, i) {
	var tBody = $("div#nTbody");
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
	<h3 class="boardLabel" align="center">공지사항</h3>
	<div class="tableDiv col-md-12" align="justify">
		<div class="thead" align="center">
			<div class="col-md-8">제목</div>
			<div class="col-md-2">등록일</div>
			<div class="col-md-1">댓글 수</div>
			<div class="col-md-1">조회 수</div>
		</div>
		<div class="tbody" id="nTbody" align="center">
			<div align="center">공지사항이 없습니다.</div>
		</div>
		<div class="tfoot">
			<div class="col-md-4">
				<ul class="pager">
					<li class="previous" id="nPrevious"><a>이전 블록</a></li>
				</ul>
			</div>
			<div class="col-md-4" align="center">
				<ul class="pagination" id="nPagination">
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="pager">
					<li class="next" id="nNext"><a>다음 블록</a></li>
				</ul>
			</div>
		</div>
	</div>
	
</div>
