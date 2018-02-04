<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/boardCss.css">
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
		var postBtn = $("button#btnPostNotice");
		var previousP = $("li#nPrevious");
		var nextP = $("li#nNext");
		var pageList = $("ul#nPagination");
		var totalPage = Math.ceil(nList.length/recordsPerPage);
		var totalBlock = Math.ceil(totalPage/pagesPerBlock);
		tBody.empty();
		pageList.empty();
		
		if("${email == myStdList[index].email}") {
			postBtn.css("visibility", "visible");
		} else {
			postBtn.css("visibility", "hidden");
		}
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
				for(var i=beginNumPerNPage;i<nList.length; i++) {
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
	var title_a = document.createElement("a");
	$(title_a).text(nList[i].title);
	$(title_a).attr("href", "javascript:fnReadNotice('"+nList[i].b_id+"')");
	$(titleDiv).append(title_a);
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

//공지사항 보기
function fnReadNotice(b_id) {
	$.post("/StudyCloud/ajax", {"stdId":'${myStdList[index].std_id}', "command":"READNOTICE", "b_id":b_id}, 
			function(code) {
				$("#${includeStdMenu}").html(code);
		});
}

//공지사항 검색
function fnSearchNotice(){
	
}

//공지사항 작성화면으로 넘기는 function
function fnPostNotice() {
	$.post("/StudyCloud/ajax", {"stdId":'${myStdList[index].std_id}', "command":"POSTBOARD", "board":"notice"}, 
		function(code) {
			$("#${includeStdMenu}").html(code);
	});
}
</script>
<div class="col-md-12" align="center">
	<h2 class="boardLabel" align="center">공지사항</h2>
	<div align="right" id="searchNotice" class="col-md-12">
		<div class="form-group form-control" style="width: 25%;" align="justify">
			<input type="search" class="nav-search-input" placeholder="검색할 공지사항을 입력하세요" name="searchTxt" onchange="fnSearchNotice()" style="width:90%;"/>
			<a style="color:#39d2fd; width:10%;" href="javascript:fnSearchNotice();"><span class="glyphicon glyphicon-search"></span></a>
		</div>
	</div>
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
		<c:if test="${email == myStdList[index].email}">
			<div align="right" class="col-md-12" style="margin-top: 0.8em;">
				<button id="btnPostNotice" class='btn btn-info' onclick='fnPostNotice()'><i class="fa fa-pencil-square-o">공지사항 작성</i></button>
			</div>
		</c:if>
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
