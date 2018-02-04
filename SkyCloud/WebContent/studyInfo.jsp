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
</style>
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
						<c:set value="${std.timePlaceList }" var="timePlaceList"></c:set>
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
							<button class="btn btn-info">스터디 신청</button>
							</th>
						</tr>
					</table>
					
     			</div><!-- end of col-md-4 -->
      </div><!-- end of row -->
    </div><!-- end of container -->

</body>
</html>