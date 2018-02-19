<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	.image-control {
    width: 100%;
    height: 300px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #39d2fd;
}

button.btn-info:active {
	border: 0.4px solid #39d2fd;
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
	outline:none;
}
button.btn-info{ width:100%; height:50%; background-color:#39d2fd; }

.fixedTable td {
	border-top: 1px solid #ddd !important;
}
.table>tbody+tbody {
	border-top: none;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	padding: 8px;
	line-height: 1.42857143;
	vertical-align: top;
	border-top: none
}

.table>thead>tr>th {
	vertical-align: bottom;
	border-bottom: none
}

.affix{
	left:57%;
}

.category-img{
	width:90%;
	height:311px; 
	margin:5%; 
	border:1px solid #39d2fd;
}

 /* Modal 크기조절  */
 .modal-dialog.modal-size {
  width: 35%;
  height: 80%;
  margin: 0;
  padding: 0;
}

.modal-content.modal-size {
  height: auto;
  min-height: 80%;
}

.modal.modal-center {
  text-align: center;
}

@media screen and (min-width: 768px) {
  .modal.modal-center:before {
    display: inline-block;
    vertical-align: middle;
    content: " ";
    height: 100%;
  }
}

.modal-dialog.modal-center {
  display: inline-block;
  text-align: left;
  vertical-align: middle;
}

/* 버튼 효과 */
button.btn-effect{
  background:#39d2fd;
  color:#fff;
  border:none;
  position:relative;
  height:40px;
  right : 0px;
  font-size:1.4em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
}
button.btn-effect:hover{
  background:#fff;
  color:#39d2fd;
}
button.btn-effect:before,button.btn-effect:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #39d2fd;
  transition:400ms ease all;
}
button.btn-effect:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
button.btn-effect:hover:before,button.btn-effect:hover:after{
  width:100%;
  transition:800ms ease all;
}
</style>
<script>
	// 스터디 신청 모달창 
	function fnApplyPopup(){
		$('#studyApplyModal').modal();
	}
	
	//스터디 신청 결과 모달 처리 function
	function fnResultModal(result) {
		if(result>0) {//성공
			$("#stdApplyBtn").click(function() {
				 window.location.href="/StudyCloud/index.jsp";
			});
		} else {//실패
			$("#ApplyResultModal div.modal-body")[0].innerHTML = "스터드등록 중 문제가 발생했습니다. 잠시 후 다시 등록해 주십시오.";
			$("#ApplyResultModal div.modal-footer button").removeClass("btn-info");
			$("#ApplyResultModal div.modal-footer button").addClass("btn-danger");
			$("#stdApplyBtn").click(function() {
				$("#ApplyResultModal").modal("hide");
			});
		}
		
		$('#ApplyResultModal').modal();
	}
	
</script>
</head>
<body style="background-color:#e6e6e6;">
    <div class="container-fluid" style="width:80%;" >
		<div class="row">
			<div class="col-md-7 col-sm-7 col-xs-7" style="background-color:#fff; padding:15px" align="center">
					<c:choose>
						<c:when test="${std.std_category == 'lang'}"><img class="category-img" src="/StudyCloud/images/categories/lang.png"/> </c:when>
						<c:when test="${std.std_category == 'job'}"><img class="category-img" src="/StudyCloud/images/categories/job.png"/> </c:when>
						<c:when test="${std.std_category == 'cert'}"><img class="category-img" src="/StudyCloud/images/categories/cert.png"/> </c:when>
						<c:when test="${std.std_category == 'bea'}"><img class="category-img" src="/StudyCloud/images/categories/bea.png"/> </c:when>
						<c:when test="${std.std_category == 'spt'}"><img class="category-img" src="/StudyCloud/images/categories/spt.png"/> </c:when>
						<c:when test="${std.std_category == 'etc'}"><img class="category-img" src="/StudyCloud/images/categories/etc.png"/> </c:when>
					</c:choose>
  					 <table  style="width:90%; margin-right:5%; margin-left:5%;">
						<tr>
							<td style="line-height: 32px;">
								<i class="glyphicon glyphicon-tower" style="font-size:16px; color:#02b2e3;"> ${mem.name}</i>
							</td>
							<td style="line-height: 32px;">
								<i class="glyphicon glyphicon-calendar" style="font-size:16px;color:#02b2e3;"> ${std.std_start}~${std.std_end} </i>
							</td>
						</tr>
						<tr style="margin-top:3%;">
							<td style="line-height: 32px;">
								<i class="glyphicon glyphicon-phone" style="font-size:16px; color:#02b2e3;"> ${mem.tel }</i>
							</td>
							<td style="line-height: 32px;">
								<i class="glyphicon glyphicon-user" style="font-size:16px;color:#02b2e3;"> 현재인원:${currentMember}명 / 총인원:${std.std_max}명 /
								<c:choose>
									<c:when test="${std.std_gender=='M'}">남자만</c:when>
									<c:when test="${std.std_gender=='F'}">여자만</c:when>
									<c:when test="${std.std_gender=='B'}">남녀무관</c:when>
								</c:choose>
								</i>
							</td>
						</tr>
				</table>
				
				<table class="table"  style="width:90%; margin:5%;">
					<tr>
						<td>
						<h2>스터디 소개글</h2>
						${std.std_info}
						</td>
					</tr>
					<tr>
						<td>
						<h2>스터디 계획</h2>
						${std.std_plan }
						</td>
					</tr>
					<tr>
						<td>
						<h2>기타 사항</h2>
						${std.std_etc }
						</td>
					</tr>
				</table>
					
			
     		</div><!-- end of col-md-8 -->
     		<div class="col-md-3 col-sm-3 col-xs-3" style="background-color:#fff; margin-left:20px;" data-spy="affix">
					<table class="fixedTable table" style="min-height: 300px">
						<tr>
							<td style="height:20%;vertical-align: middle"><label><b>스터디명&nbsp;:</b></label>   ${std.std_name }</td>
						</tr>
						<c:set value="${std.timePlaceList}" var="timePlaceList"/>
							<c:forEach begin="0" end="${fn:length(timePlaceList)-1}" step="1" var="j"> 
						<tr>
							<td style="height:20%;vertical-align: middle" ><label><b>장소&nbsp;:</b></label>&nbsp;&nbsp;<i class="glyphicon glyphicon-map-marker">${timePlaceList[j].std_addr}</i></td>
						</tr>
						<tr>
							<td style="height:20%; vertical-align: middle"><label><b>가능시간&nbsp;:</b></label>&nbsp;&nbsp;<i class="glyphicon glyphicon-time">&nbsp;${timePlaceList[j].std_time}~${timePlaceList[j].std_time + (timePlaceList[j].std_hour * 100)}</i></td>
						</tr>
						<tr>
							<td style="height:20%;vertical-align: middle"><label><b>요일&nbsp;:</b></label>  ${timePlaceList[j].std_day }</td>
						</tr>
						</c:forEach>
						<tr>
							<th style="height:20%;">
							<button class="btn btn-info" id="studyApply" onclick="fnApplyPopup()" >스터디 신청</button>
							</th>
						</tr>
					</table>
					
     			</div><!-- end of col-md-4 -->
      </div><!-- end of row -->
    </div><!-- end of container -->
	
	<!-- 스터디 신청 모달창 -->
	<div class="modal modal-center fade" id="studyApplyModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="my80sizeCenterModalLabel">
		<div class="modal-dialog modal-size modal-center" role="document">
			<div class="modal-content modal-size">
				<div class="modal-header" align="center">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h3 class="modal-title"> 스터디 신청하기 </h3>				
				</div>
				<div class="modal-body" align="center">
					<form action="/StudyCloud/fwd" method="POST">
					<input type="hidden" name="command" value="STUDYAPPLY">
					<input type="hidden" name="std_id" value="${std.std_id}">
					<input type="hidden" name="std_name" value="${std.std_name}">
					<input type="hidden" name="leaderEmail" value="${mem.email}">
					<textarea rows="15" style="width:80%;"  name="apply_content" id="apply_content" maxlength="200" placeholder="신청내용" style="over-flow:hidden;resize:none"></textarea>
					<button class="btn btn-effect" type="submit">신청</button>&nbsp;&nbsp;&nbsp;
					<button class="btn btn-effect" class="close" data-dismiss="modal">닫기</button>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	
	<!-- 스터디 신청 결과 모달창 -->
			<div class="modal fade" id="ApplyResultModal" data-backdrop="static">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<i class="fa fa-cloud" style="font-size:24px;color:#39d2fd"><strong>스터디 신청</strong></i>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							스터디 신청에 성공하셨습니다.
						</div>
						<div class="modal-footer">
							<button class="btn btn-info" id="stdApplyBtn">확인</button>
						</div>
					</div>
				</div>
			</div>
			
		<!-- 스터디 신청 결과 처리 -->
		<c:if test="${! (empty applyResult && empty msgResult)}">
			<script>fnResultModal('${applyResult}');</script>
		</c:if>
	
</body>
</html>