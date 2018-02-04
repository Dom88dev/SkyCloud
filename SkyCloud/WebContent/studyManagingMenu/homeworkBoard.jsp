<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/boardCss.css">
<script>
var currentHPage = 0;
var currentHBlock = 0;
var beginNumPerHPage = recordsPerPage * currentHPage;
var beginNumPerHBlock = pagesPerBlock * currentHBlock;
var homeworkData = "";

(function() {
	$.post("/StudyCloud/ajax", {command:"LOADHOMEWORK", stdId:"${myStdList[index].std_id}"}, 
		function(data) {
			homeworkData = data;
			fnLoadHomework(data);
	});
})();

function fnLoadHomework(data) {
	var jsonData = $.parseJSON(data);
	if(jsonData){
		var hList = jsonData.homeworkList;
		var tBody = $("div#hTbody");
		var previousP = $("li#hPrevious");
		var nextP = $("li#hNext");
		var pageList = $("ul#hPagination");
		var totalPage = Math.ceil(hList.length/recordsPerPage);
		var totalBlock = Math.ceil(totalPage/pagesPerBlock);
		tBody.empty();
		pageList.empty();
		if(hList.length > 0) {
			//레코드 처리
			if(hList.length>recordsPerPage) {
				if(currentHPage==(totalPage-1)) {
					for(var i=beginNumPerHPage;i<(beginNumPerHPage + (hList.length%recordsPerPage)); i++) {
						createHomeworkRecord(hList, i);
					}
				} else {
					for(var i=beginNumPerHPage;i<(beginNumPerHPage + recordsPerPage); i++) {
						createHomeworkRecord(hList, i);
					}
				}
			} else {
				for(var i=beginNumPerHPage;i<hList.length; i++) {
					createHomeworkRecord(hList, i);
				}
			}
			
			//페이징 처리
			if(currentHBlock==0) {
				previousP.empty();
				var previous = document.createElement("a");
				$(previous).addClass("disabledPager");
				$(previous).text("이전 블록");
				previousP.append(previous);
			} else {
				$(previousP).find("a").removeClass("disabledPager");
				$(previousP).find("a").attr("href", "javascript:fnPreviousBlockH("+currentHBlock+")");
			}
			if(currentHBlock==(totalBlock-1)) {
				nextP.empty();
				var next = document.createElement("a");
				$(next).addClass("disabledPager");
				$(next).text("다음 블록");
				nextP.append(next);
			} else {
				$(nextP).find("a").removeClass("disabledPager");
				$(nextP).find("a").attr("href", "javascript:fnNextBlockH("+currentHBlock+")");
			}
			if(currentHBlock==(totalBlock-1)){
				for(var i=beginNumPerHBlock;i<(beginNumPerHBlock + (totalPage%pagesPerBlock));i++) {
					var li = document.createElement("li");
					var a = document.createElement("a");
					if(i==currentHPage) {
						$(li).addClass("active");
					}
					$(a).attr("href", "javascript:fnSelectPageH("+i+")");
					$(a).text(Number(i)+1);
					li.append(a);
					pageList.append(li);
				}
			} else {
				for(var i=beginNumPerHBlock;i<(beginNumPerHBlock + pagesPerBlock);i++) {
					var li = document.createElement("li");
					var a = document.createElement("a");
					if(i==currentHPage) {
						$(li).addClass("active");
					}
					$(a).attr("href", "javascript:fnSelectPageH("+i+")");
					$(a).text(Number(i)+1);
					li.append(a);
					pageList.append(li);
				}
			}
		}
	}
}

//페이지 선택시 해당 페이지 로딩
function fnSelectPageH(page) {
	currentHPage = page;
	beginNumPerHPage = recordsPerPage * currentHPage;
	fnLoadHomework(homeworkData);
}

//이전 블럭으로 이동
function fnPreviousBlockH(cBlock) {
	
}

//다음 블럭으로 이동
function fnNextBlockH(cBlock) {
	
}

//과제 upload
function fnUploadHomework(h_id) {
	
}

//과제 목록 로딩 및 생성
function createHomeworkRecord(hList, i) {
	var tBody = $("div#hTbody");
	var recordDiv = document.createElement("div");
	$(recordDiv).addClass("record");
	var titleDiv = document.createElement("div");
	$(titleDiv).addClass("col-md-4");
	var uploadHDiv = document.createElement("div");
	$(uploadHDiv).addClass("col-md-2");
	var duedateDiv = document.createElement("div");
	$(duedateDiv).addClass("col-md-2");
	var dateDiv = document.createElement("div");
	$(dateDiv).addClass("col-md-2");
	var rpNumDiv = document.createElement("div");
	$(rpNumDiv).addClass("col-md-1");
	var viewNumDiv = document.createElement("div");
	$(viewNumDiv).addClass("col-md-1");
	
	$(titleDiv).text(hList[i].title);
	$(uploadHDiv).attr("align", "right");
	$(uploadHDiv).html("<button class='btn-white' onclick='fnUploadHomework("+hList[i].b_id+")'>과제 올리기</button>");
	var d = new Date(hList[i].duedate);
	$(duedateDiv).text(d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate());
	d = new Date(hList[i].b_datetime);
	$(dateDiv).text(d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate());
	$(rpNumDiv).text(hList[i].replies_cnt);
	$(viewNumDiv).text(hList[i].view_cnt);
	recordDiv.append(titleDiv);
	recordDiv.append(uploadHDiv);
	recordDiv.append(duedateDiv);
	recordDiv.append(dateDiv);
	recordDiv.append(rpNumDiv);
	recordDiv.append(viewNumDiv);
	$(tBody).append(recordDiv);
	var hr = document.createElement("hr");
	$(hr).addClass("hr col-md-12");
	$(tBody).append(hr);
}

//과제 검색
function fnSearchHomework() {
	
}

//과제 작성
function fnPostHomework(){
	$.post("/StudyCloud/ajax", {"stdId":'${myStdList[index].std_id}', "command":"POSTBOARD", "board":"homework"}, 
		function(code) {
			$("#${includeStdMenu}").html(code);
	});
}

</script>

<div class="col-md-12" align="center">
	<h2 class="boardLabel" align="center">과제</h2>
	<div align="right" id="searchHomework" class="col-md-12">
		<div class="form-group form-control" style="width: 25%;" align="justify">
			<input type="search" class="nav-search-input" placeholder="검색할 과제를 입력하세요" name="searchTxt" onchange="fnSearchHomework()" style="width:90%;"/>
			<a style="color:#39d2fd; width:10%;" href="javascript:fnSearchHomework();"><span class="glyphicon glyphicon-search"></span></a>
		</div>
	</div>
	<div class="tableDiv col-md-12" align="justify">
		<div class="thead" align="center">
			<div class="col-md-6">제목</div>
			<div class="col-md-2">마감일</div>
			<div class="col-md-2">등록일</div>
			<div class="col-md-1">댓글 수</div>
			<div class="col-md-1">조회 수</div>
		</div>
		<div class="tbody" id="hTbody" align="center">
			<div align="center">과제가 없습니다.</div>
		</div>
		<div align="right" class="col-md-12">
			<button id="btnPostHomework" class='btn btn-info' onclick='fnPostHomework()'><i class="fa fa-pencil-square-o">과제 작성</i></button>
		</div>
		<div class="tfoot">
			<div class="col-md-4">
				<ul class="pager">
					<li class="previous" id="hPrevious"><a>이전 블록</a></li>
				</ul>
			</div>
			<div class="col-md-4" align="center">
				<ul class="pagination" id="hPagination">
				</ul>
			</div>
			<div class="col-md-4">
				<ul class="pager">
					<li class="next" id="hNext"><a>다음 블록</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<style>
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
</style>
