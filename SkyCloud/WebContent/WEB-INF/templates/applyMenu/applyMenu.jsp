<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<div class="col-md-2" style="border:0px; margin-top:20px;">
		<ul class="nav rnav-pills nav-stacked text-center">	
			<li>
				<a data-toggle="pill" href="#stdApplies" onclick="fnSetCurrentApplyMenu('stdApplies')">스터디 홈</a>
            </li>
            <li>
               <a data-toggle="pill" href="#myApplies" onclick="fnSetCurrentApplyMenu('myApplies')">공지사항</a>
            </li>
		</ul>	
	</div>
	<div class="tab-content col-md-10 ApplyMenu">
		<div class="tab-pane fade" id="stdApplies" style="margin-top: 10px">
			<%@ include file="/WEB-INF/templates/applyMenu/studyApplies.jsp" %>
		</div>
		<div id="myApplies" class="tab-pane fade" style="margin-top: 10px">
			<%@ include file="/WEB-INF/templates/applyMenu/myApplyList.jsp" %>
		</div>
	</div>