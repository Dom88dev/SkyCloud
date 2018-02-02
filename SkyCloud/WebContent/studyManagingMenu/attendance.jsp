<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	attendance.jsp
	<script>
		alert("${index}");
	</script>
	<c:set var="command" value="PRINTCAL" />
	<c:set var="stdId" value="${stdList[param.index].std_id}" />
	<c:choose>
		<c:when test="${sessionScope.email==requestScope.email }">
			<jsp:include page="/WEB-INF/calendar/AtdCalStdleader.jsp"></jsp:include>
		</c:when>
		<c:otherwise>
			<jsp:include page="/WEB-INF/calendar/AtdCalStdmem.jsp"></jsp:include>
		</c:otherwise>
	</c:choose>
</body>
</html>