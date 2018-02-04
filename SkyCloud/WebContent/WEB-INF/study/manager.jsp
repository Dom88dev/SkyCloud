<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	.rlist-group-item {
		width: 70%;
		position: relative;
	    display: block;
	    padding: 10px 15px;
	    margin-bottom: -1px;
	    background-color: #fff;
	    border: 0px solid #000;
	}
	.rlist-group-item.active, .rlist-group-item.active:focus, .rlist-group-item.active:hover {
	    z-index: 2;
	    color: #fff;
	    background-color: #39d2fd;
	    border-color: #39d2fd;
	}
	.rlist-group-item:first-child {
	    border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
	.rnav-pills>li.active>a, .rnav-pills>li.active>a:focus, .rnav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: #39d2fd;
	    border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
    
	.name-tag {
		position: relative;
	    display: block;
	    padding: 10px 15px;
	    margin-bottom: -1px;
	    width: 83%;
	    border: 0px solid #000;
		z-index: 2;
		color: #fff;
	    background-color: #39d2fd;
	    border-color: #39d2fd;
		border-top-left-radius: 4px;
	    border-top-right-radius: 4px;
	    border-bottom-left-radius: 4px;
	    border-bottom-right-radius: 4px;
	}
	.rbtn-primary {
	    color: #fff;
	    background-color: #39d2fd;
	    border-color: #03c6fc;
	}
	#footer {
	    width: 100%;
	    bottom: 0;
	}
	
</style>
<script>
	var currentIndex = Number("${index}");
	var currentMenu = "${includeStdMenu}";
	function fnSetIndex(index) {
		currentIndex = index;
		$.post("/StudyCloud/ajax", {"command":"MNG_CHANGESTUDY", "index":index, "includeStdMenu":currentMenu}, 
				function(data) {
					fnChangeStdMenuInclude(data);
			});
	}
	
	function fnSetCurrentStdMenu(menu) {
		currentMenu = menu;
		$.post("/StudyCloud/ajax", {"command":"MNG_CHANGESTUDY", "index":currentIndex, "includeStdMenu":menu}, 
				function(data) {
					fnChangeStdMenuInclude(data);
			});
	}
	function fnSetCurrentApplyMenu(menu) {
		
	}
	
	function fnPostResultModalPopup(result) {
		if(Number(result)==0) {
			$("#postResultModal div.modal-body h4").text("게시물 업로드중 문제가 발생했습니다.");
		} else {
			$("#postResultModal div.modal-body h4").text("게시글이 업로드되었습니다.");
		}
		$("#postResultModal").modal();
	}
	
	function fnUpdateResultModalPopup(result) {
		if(Number(result)==0) {
			$("#postResultModal div.modal-body h4").text("게시물 수정중 문제가 발생했습니다.");
		} else {
			$("#postResultModal div.modal-body h4").text("게시글이 수정되었습니다.");
		}
		$("#postResultModal").modal();
	}
</script>
</head>
<body>
	<div class="container-fluid" style="margin-top: 50px;">
		<!-- nav tabs -->
		<div class="col-md-12">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#studyManager" data-toggle="tab">나의 스터디</a></li>
				<li><a href="#applyList" data-toggle="tab">스터디 신청목록</a></li>
			</ul>
			
		<!-- 탭화면 -->
			<div class="tab-content">
			<!-- 스터디 매니져 화면 -->
				<div id="studyManager" class="tab-pane fade in active">
					<div id="mngMenuDiv">
						<jsp:include page="/studyManagingMenu/stdMenu.jsp"></jsp:include>
					</div>
				</div>
			<!-- 스터디 신청 목록 화면 -->
				<div id="applyList" class="tab-pane fade">
					<h3>Menu 1</h3>
  					<p>Some content in menu 1.</p>
				</div>
			</div>
		</div>
		
		<!-- 게시판 업로드 결과 모달 -->
		<div class="modal fade" id="postResultModal" data-backdrop="static">
 			<div class="modal-dialog modal-sm">
 				<div class="modal-content">
 					<div class="modal-body">
						<h4 style="text-align: center;color: #6e6e6e">게시글이 업로드되었습니다.</h4>
	 					<div style="text-align: center;padding-top: 20px">
	 						<button class="btn btn-info" data-dismiss="modal" style="background: #39d2fd;border: 0;">확인</button>
	 					</div>
	 				</div>
 				</div>
 			</div>
 		</div>
		
		<c:if test="${! (empty postResult)}">
			<script>fnPostResultModalPopup('${postResult}');</script>
		</c:if>
		<c:if test="${! (empty updateResult)}">
			<script>fnUpdateResultModalPopup('${updateResult}');</script>
		</c:if>
		
	</div>
</body>
</html>