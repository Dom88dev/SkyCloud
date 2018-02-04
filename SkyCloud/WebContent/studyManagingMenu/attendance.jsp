<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src='/StudyCloud/lib/bootstrap337/js/fullcalendar.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/moment.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/bootstrap-datetimepicker.min.js'></script>
<script src='/StudyCloud/lib/bootstrap337/js/scheduler.min.js'></script>
	attendance.jsp
	<script>
		alert("${index}");
	</script>
	<c:choose>
		<c:when test="${email == myStdList[index].email}">
			<jsp:include page="/WEB-INF/calendar/AtdCalStdleader.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<jsp:include page="/WEB-INF/calendar/AtdCalStdmem.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>