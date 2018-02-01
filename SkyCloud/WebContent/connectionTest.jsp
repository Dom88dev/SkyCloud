<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
</head>
<body>
<%
	try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "skycloud", "skycloud");
	
	if(con != null){
		out.println("¼º°ø");
	}
	}
	catch(Exception err){
		out.println(err);
	}
%>
</body>
</html>