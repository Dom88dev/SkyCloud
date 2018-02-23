<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
th{color:white}
</style>

<div class="col-md-12" align="center">
	<h2 class="text-info">스터디 신청받은 목록</h2>
	<br>
	<div class="col-md-12">
		<div align="right">
			<div class="form-group" style="width: 25%;" align="justify">
				<select name="myCurrentStudy" class="form-control" style="color:#39d2fd; margin-bottom:2%" onchange="fnSetApplyStdIndex(this.value)">
					<c:set value="-1" var="appliesStdIndex"></c:set>
					<c:forEach begin="0" end="${fn:length(myStdList) - 1}" step="1" var="i">
						<c:if test="${myStdList[i].email == sessionScope.email}">
							<c:set value="${appliesStdIndex +1}" var="appliesStdIndex"></c:set>
							<option style="color:#39d2fd; font-style: italic;" value="${myStdList[i].std_id}">
								${myStdList[i].std_name}
							</option>
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
							<td>수락</td><td><button onclick="fnCancelApply('${stdApply.apply_id}', '${stdApply.email}')">수락 취소</button></td>
						</c:when>
						<c:when test="${stdApply.apply_status eq 'apply'}">
							<td>가입 대기</td><td><button onclick="fnAcceptApply('${stdApply.apply_id}', '${stdApply.email}')">수락</button><button onclick="fnRejectApply('${stdApply.apply_id}')">거절</button></td>
						</c:when>
						<c:when test="${stdApply.apply_status eq 'reject'}">
							<td>거절</td><td><button onclick="fnCancelApply('${stdApply.apply_id}', '${stdApply.email}')">거절 취소</button></td>
						</c:when>
					</c:choose>
					<c:set target="${date}" property="time" value="${stdApply.apply_datetime}"/>
					<td><fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</table>
		</c:forEach>
	</div>
</div>
<form id="modifyStdApplyForm" method="post" action="/StudyCloud/fwd">
	<input type="hidden" name="command">
	<input type="hidden" name="apply_id">
	<input type="hidden" name="apply_email">
</form>
<script>
	
	(function() {
		$("tr.recordTr").hide();
		var i = "${appliesFirstStdId}";
		$("tr.appliesStdIdIs"+i).show();
	})();
	
	function fnSetApplyStdIndex(i) {
		$("tr.recordTr").hide();
		$("tr.appliesStdIdIs"+i).show();
	}
	
	function fnAcceptApply(apply_id, email) {
		$("form#modifyStdApplyForm input[name='command']").val("ACCEPTAPPLY");
		$("form#modifyStdApplyForm input[name='apply_id']").val(apply_id);
		$("form#modifyStdApplyForm input[name='apply_email']").val(email);
		$("form#modifyStdApplyForm").submit();
	}

	function fnRejectApply(apply_id, email) {
		$("form#modifyStdApplyForm input[name='command']").val("REJECTAPPLY");
		$("form#modifyStdApplyForm input[name='apply_id']").val(apply_id);
		$("form#modifyStdApplyForm input[name='apply_email']").val(email);
		$("form#modifyStdApplyForm").submit();
	}

	function fnCancelApply(apply_id, email) {
		$("form#modifyStdApplyForm input[name='command']").val("CANCELAPPLY");
		$("form#modifyStdApplyForm input[name='apply_id']").val(apply_id);
		$("form#modifyStdApplyForm input[name='apply_email']").val(email);
		$("form#modifyStdApplyForm").submit();
	}
</script>
