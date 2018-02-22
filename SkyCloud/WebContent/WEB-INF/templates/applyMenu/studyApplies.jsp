<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
th{color:white}
</style>

<div class="col-md-12" align="center">
	<h2 class="text-info">스터디 신청목록</h2>
	<br>
	<div class="col-md-12">
		<div align="right">
			<div class="form-group" style="width: 25%;" align="justify">
				<select name="myCurrentStudy" class="form-control" style="color:#39d2fd; margin-bottom:2%" onchange="fnSetApplyStdIndex(this.value)">
					<c:set value="-1" var="appliesStdIndex"></c:set>
					<c:forEach begin="0" end="${fn:length(myStdList) - 1}" step="1" var="i">
						<c:if test="${myStdList[i].email == sessionScope.email}">
							<c:set value="${appliesStdIndex +1}" var="appliesStdIndex"></c:set>
							<option style="color:#39d2fd; font-style: italic;" value="${appliesStdIndex}">${myStdList[i].std_name}</option>
							<input type="hidden" name="appliesStudyId${appliesStdIndex}" value="${myStdList[i].std_id}">
							<c:if test="${appliesStdIndex == 0 }"><c:set value="${myStdList[i].std_id}" var="appliesFirstStdId"></c:set></c:if>
						</c:if>
					</c:forEach>
				</select>
			</div>
		</div>
		<table	class="table-hover table-condensed" style="width: 100%; max-width:100%; margin-bottom:0;">
			<tr style="background:#39d2fd;">
				<th>스터디</th><th>신청자</th><th colspan="2">신청 상태</th><th>신청 날짜</th>
			</tr>
		</table>
		<jsp:useBean id="date" class="java.util.Date"/>
		<c:forEach items="${stdApplies}" var="stdApply">
			<table class="table-hover table-condensed" style="width: 100%; max-width:100%; margin-bottom:0;">
				<tr class="recordTr appliesStdIdIs${stdApply.std_id}">
					<td>${stdApply.stdName}</td><td>${stdApply.name}</td>
					<c:choose>
						<c:when test="${stdApply.apply_status eq 'accept'}">
							<td>수락</td><td><button>수락 취소</button></td>
						</c:when>
						<c:when test="${stdApply.apply_status eq 'apply'}">
							<td>가입 대기</td><td><button>수락</button><button>거절</button></td>
						</c:when>
						<c:when test="${stdApply.apply_status eq 'reject'}">
							<td>거절</td><td><button>거절 취소</button></td>
						</c:when>
					</c:choose>
					<c:set target="${date}" property="time" value="${stdApply.apply_datetime}"/>
					<td><fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</table>
		</c:forEach>
	</div>
</div>

<script>
	var selectedApplyStudyId = 0;
	
	(function() {
		$("tr.recordTr").hide();
		var i = $("input[name='appliesStudyId0']").val();
		$("tr.appliesStdIdIs"+i).show();
	})();
	
	function fnSetApplyStdIndex(i) {
		selectedApplyStudyId = $("input[name='appliesStudyId"+i+"']").val();
		$("tr.recordTr").hide();
		$("tr.appliesStdIdIs"+selectedApplyStudyId).show();
	}
	
</script>
