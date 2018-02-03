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

		<c:if test="${email==myStdList[index].email}">
			<script>
				$.ajax({
					url : "/StudyCloud/ajax",
					type : "GET",
					data : {command: "LOADLEADERCALENDAR"},
					success : function(data){
						$.post(data, {}, function(code){
							$("#stdAttendance").html(code);
						});
					}
				});
			</script>
		</c:if>
		<c:if test="${SessionScope.email != myStdList[index].email}">
			<script>
				$.ajax({
					url : "/StudyCloud/ajax",
					type : "GET",
					data : {command: "LOADMEMCALENDAR"},
					success : function(data){
						$.post(data, {}, function(code){
							$("#stdAttendance").html(code);
						});
					}
				});
			</script>
		</c:if>

</body>
</html>