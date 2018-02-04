<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

	<div class="col-md-2" style="border:0px; margin-top:20px;">
		<select name="myCurrentStudy" class="form-control" style="color:#39d2fd; margin-bottom:2%" onchange="fnSetIndex(this.value)">
			<c:forEach begin="0" end="${fn:length(myStdList) - 1}" step="1" var="i">
				<c:choose>
					<c:when test="${myStdList[i].email == sessionScope.email}">
						<option style="color:#39d2fd; font-style: italic;" value="${i}">${myStdList[i].std_name}</option>
					</c:when>
					<c:otherwise>
						<option value="${i}">${myStdList[i].std_name}</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		<ul class="nav rnav-pills nav-stacked text-center">
			<li class="active">
               <a data-toggle="pill" href="#stdHome" onclick="fnSetCurrentStdMenu('stdHome')">스터디 홈</a>
             </li>
             <li>
               <a data-toggle="pill" href="#stdNotice" onclick="fnSetCurrentStdMenu('stdNotice')">공지사항</a>
             </li>
             <li>
               <a data-toggle="pill" href="#stdHomework" onclick="fnSetCurrentStdMenu('stdHomework')">과제</a>
             </li>
             <li>
               <a data-toggle="pill" href="#stdAttendance" onclick="fnSetCurrentStdMenu('stdAttendance')">출석부</a>
             </li>
		</ul>	
	</div>
	<div class="tab-content col-md-10">
		<div class="tab-pane fade in active" id="stdHome" style="margin-top: 10px">
			<jsp:include page='/studyManagingMenu/studyHome.jsp'></jsp:include>
		</div>
		<div id="stdNotice" class="tab-pane fade" style="margin-top: 10px">
			<jsp:include page='/studyManagingMenu/noticeBoard.jsp'></jsp:include>
		</div>
		<div id="stdHomework" class="tab-pane fade" style="margin-top: 10px">
			<jsp:include page='/studyManagingMenu/homeworkBoard.jsp'></jsp:include>
		</div>
		<div id="stdAttendance" class="tab-pane fade" style="margin-top: 10px">
			<jsp:include page='/studyManagingMenu/attendance.jsp'></jsp:include>
		</div>
	</div>
<script>
function fnChangeStdMenuInclude(data) {
	var page = "";
	if(currentMenu == "stdHome") {
		page = "studyHome.jsp";
	} else if(currentMenu == "stdNotice") {
		page = "noticeBoard.jsp";
	} else if(currentMenu == "stdHomework") {
		page = "homeworkBoard.jsp";
	} else {
		page = "attendance.jsp";
	}
	$.post(data+page, {}, 
			function(code) {
				$("#"+currentMenu).html(code);
		});
	//studyManagingMenu폴더를 web-inf안으로 이동시켜서 ajax컨트롤러를 통해 접근하도록 처리가능
}
</script>
