<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<c:if test="${fn:length(stdList)<9}">
			<c:forEach begin="0" end="${fn:length(stdList) - 1}" step="1" var="i">
				<jsp:include page="/WEB-INF/templates/studyList/studybrief.jsp">
					<jsp:param value="${i}" name="index"/>
				</jsp:include>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(stdList)>=9}">
			<c:forEach begin="0" end="8" step="1" var="i">
				<jsp:include page="/WEB-INF/templates/studyList/studybrief.jsp">
					<jsp:param value="${i}" name="index"/>
				</jsp:include>
			</c:forEach>
		</c:if>
	</div>
</body>
</html>