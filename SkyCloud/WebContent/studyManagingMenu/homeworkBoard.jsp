<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/boardCss.css">
<script>
var recordsPerPage = 10;
var pagesPerBlock = 5;
var currentHPage = 0;
var currentHBlock = 0;
var beginNumPerHPage = recordsPerPage * currentHPage;
var beginNumPerHBlock = pagesPerBlock * currentHBlock;
var homeworkData = "";

(function() {
	$.post("/StudyCloud/json", {command:"LOADHOMEWORK", stdId:"${myStdList[index].std_id}"}, 
		function(data) {
			homeworkData = data;
			fnLoadHomework(data);
	});
})();

function fnLoadHomework(data) {
	var jsonData = $.parseJSON(data);
	if(jsonData){
		var hList = jsonData.homeworkList;
		var hfList = jsonData.homeworkFilesList;
		var tBody = $("div#hTbody");
		var postBtn = $("button#btnPostHomework");
		var previousP = $("li#hPrevious");
		var nextP = $("li#hNext");
		var pageList = $("ul#hPagination");
		var totalPage = Math.ceil(hList.length/recordsPerPage);
		var totalBlock = Math.ceil(totalPage/pagesPerBlock);
		tBody.empty();
		pageList.empty();
		
		if("${email == myStdList[index].email}") {
			postBtn.css("visibility", "visible");
		} else {
			postBtn.css("visibility", "hidden");
		}
		if(hList.length > 0) {
			//레코드 처리
			if(hList.length>recordsPerPage) {
				if(currentHPage==(totalPage-1)) {
					for(var i=beginNumPerHPage;i<(beginNumPerHPage + (hList.length%recordsPerPage)); i++) {
						createHomeworkRecord(hList, i, hfList);
					}
				} else {
					for(var i=beginNumPerHPage;i<(beginNumPerHPage + recordsPerPage); i++) {
						createHomeworkRecord(hList, i, fhList);
					}
				}
			} else {
				for(var i=beginNumPerHPage;i<hList.length; i++) {
					createHomeworkRecord(hList, i, hfList);
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
	$("#hwUpTemplate").attr("src", "/StudyCloud/fwd?command=MOVETOUPLOADHWF&b_id="+h_id);
	
	$("#HWF_UploadModal").modal();
}

//과제 목록 로딩 및 생성
function createHomeworkRecord(hList, i, hfList) {
	var tBody = $("div#hTbody");
	var recordDiv = document.createElement("div");
	$(recordDiv).addClass("record");
	var titleDiv = document.createElement("div");
	$(titleDiv).addClass("col-md-5");
	var uploadHDiv = document.createElement("div");
	$(uploadHDiv).addClass("col-md-3");
	var duedateDiv = document.createElement("div");
	$(duedateDiv).addClass("col-md-1");
	var dateDiv = document.createElement("div");
	$(dateDiv).addClass("col-md-1");
	var rpNumDiv = document.createElement("div");
	$(rpNumDiv).addClass("col-md-1");
	var viewNumDiv = document.createElement("div");
	$(viewNumDiv).addClass("col-md-1");
	
	var title_a = document.createElement("a");
	$(title_a).text(hList[i].title);
	$(title_a).attr("href", "javascript:fnReadHomework('"+hList[i].b_id+"')");
	$(titleDiv).append(title_a);
	$(uploadHDiv).attr("align", "right");
	$(uploadHDiv).html("<button class='btn-white' onclick='fnUploadHomework("+hList[i].b_id+")'>과제 올리기</button><button class='btn-white' id='toggleBtn"+i+"' style='border:none; margin:0.1em;'>제출파일보기<i class='glyphicon glyphicon-triangle-bottom'></i></button>");
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
	
	//toggle될 div 추가
	var toggleDiv = document.createElement("div");
	$(toggleDiv).addClass("col-md-12");
	$(toggleDiv).attr("id", "hFileListToggleDiv"+i);
	$(toggleDiv).attr("align", "left");
	var innerCode = "";
	var hfiles = hfList[i];
	for(var n = 0; n<hfiles.length; n++) {
		hfiles[n]
		innerCode+="<b>"+hfiles[n].name+"</b><a class='btn-white' href='/StudyCloud"+hfiles[n].hw_file+"'><i class='glyphicon glyphicon-paperclip'>"+hfiles[n].hw_file_name+"</i></a>";
		if(hfiles[n].email == "${email}") {
			innerCode += "<button class='btn-red' onclick='fnDelHomeworkFile("+hList[i].b_id+")' style='border-radius:1em;'>파일 삭제</button>"
		}
		d = new Date(hfiles[n].hw_datetime);
		
		innerCode+="<span style='text-shadow: 0 1px 0 #fff; filter: alpha(opacity = 20); opacity: .2;'>"+d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+" "+d.getHours()+":"+d.getMinutes()+"</span><br>";
	}
	if(hfiles.length == 0) {
		innerCode = "아직 제출된 과제 파일이 없습니다.";
	}
	$(toggleDiv).html(innerCode);
	$(tBody).append(toggleDiv);
	$(toggleDiv).hide();
	$("#toggleBtn"+i).attr("onclick", "fnToggleHomeworkFdiv('"+"hFileListToggleDiv"+i+"')");
	
	var hr = document.createElement("hr");
	$(hr).addClass("hr col-md-12");
	$(tBody).append(hr);
}

function fnToggleHomeworkFdiv(toggleDivId) {
	$("#"+toggleDivId).toggle();
}

function fnDelHomeworkFile() {
	
}

//과제 보기
function fnReadHomework(b_id) {
	$.post("/StudyCloud/fwd", {"command":"READHOMEWORK", "b_id":b_id, "countUp":"up"}, 
			function(code) {
				$("#${includeStdMenu}").html(code);
		});
}

//과제 검색
function fnSearchHomework() {
	
}

//과제 작성
function fnWriteHomework(){
	$.post("/StudyCloud/fwd", {"command":"WRITEBOARD", "stdId":'${myStdList[index].std_id}', "board":"homework"}, 
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
			<div class="col-md-2">과제 업로드/확인</div>
			<div class="col-md-1">마감일</div>
			<div class="col-md-1">등록일</div>
			<div class="col-md-1">댓글 수</div>
			<div class="col-md-1">조회 수</div>
		</div>
		<div class="tbody" id="hTbody" align="center">
			<div align="center">과제가 없습니다.</div>
		</div>
		<c:if test="${email == myStdList[index].email}">
			<div align="right" class="col-md-12" style="margin-top: 0.8em;">
				<button id="btnPostHomework" class='btn btn-info' onclick='fnWriteHomework()'><i class="fa fa-pencil-square-o">과제 작성</i></button>
			</div>
		</c:if>
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

<!-- 과제 파일 업로드 모달창 -->
<div class="modal fade" id="HWF_UploadModal" data-backdrop="static">
	<div class="modal-dialog">
		<div class="modal-content">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<iframe id="hwUpTemplate" src="/StudyCloud/fwd?command=MOVETOUPLOADHWF" width="100%" style="border:none;"></iframe>
		</div>
	</div>
</div>

<c:if test="${! (empty readBoard_id)}">
	<script>fnReadHomework("${readBoard_id}");</script>
</c:if>
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
