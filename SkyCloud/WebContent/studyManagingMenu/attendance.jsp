<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	function fnLoadLeaderCal() {
		$.ajax({
			url : "/StudyCloud/json",
			type : "GET",
			data : {command: "LOADLEADERCALENDAR"},
			success : function(data){
				$.post(data, {}, function(code){
					$("#stdAttendance").html(code);
				});
			}
		});
	}
	
	function fnLoadMemberCal() {
		$.ajax({
			url : "/StudyCloud/json",
			type : "GET",
			data : {command: "LOADMEMCALENDAR"},
			success : function(data){
				$.post(data, {}, function(code){
					$("#stdAttendance").html(code);
				});
			}
		});
	}
	
	(function() {
		if("${email}" == "${myStdList[index].email}") {
			fnLoadLeaderCal();
		} else {
			fnLoadMemberCal();
		}
	})();
</script>