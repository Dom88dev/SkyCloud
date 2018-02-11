<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/StudyCloud/lib/bootstrap337/css/bootstrap.min.css" />
<script src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<style>
	.panel {
	    border: 1px solid #39d2fd; 
	    border-radius:0;
	    transition: box-shadow 0.5s;
	}
	
	.panel:hover {
	    box-shadow: 5px 0px 40px rgba(0,0,0, .2);
	}
	
	.panel-footer .btn:hover {
	    border: 1px solid #39d2fd;
	    background-color: #fff !important;
	    color: #39d2fd;
	}

	.panel-heading {
	    color: #fff !important;
	    background-color: #39d2fd !important;
	    border-bottom: 1px solid transparent;
	    border-top-left-radius: 0px;
	    border-top-right-radius: 0px;
	    border-bottom-left-radius: 0px;
	    border-bottom-right-radius: 0px;
	}
	
	.panel-footer {
    	background-color: #fff !important;
	}
	
	.panel-footer p {
    	width:100%;
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 3; /* 라인수 */
		-webkit-box-orient: vertical;
		word-wrap:break-word; 
		line-height: 1.2em;
		height: 3.6em; /* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
	}
	
	.panel-footer .btn {
	    margin: 15px 0;
	    background-color: #39d2fd;
	    color: #fff;
	}
</style>
</head>
<body>
	<div class="col-md-4" style="margin:5">
		<div class="panel panel-default text-center">
			<div class="panel-heading">
	          <img src="/StudyCloud/images/categories/${stdList[param.index].std_category}.png" width="100%">
	        </div>
			<div class="panel-body">
	          <h3>${stdList[param.index].std_name}</h3>
	        </div>
	        <div class="panel-footer">
	          <p>${stdList[param.index].std_info}</p>
	          <form action="/StudyCloud/fwd" method="post">
	          	<input type="hidden" value="GETSTUDYINFO" name="command">
				<input type="hidden" value="${stdList[param.index].std_id}" name="stdId">
				<input type="hidden" value="${stdList[param.index].email }" name="email">
	          	<button class="btn btn-lg" type="submit">자세히 보기</button>
	          </form>
	        </div>
		</div>
	</div> 
</body>
</html>