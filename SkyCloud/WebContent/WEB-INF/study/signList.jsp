<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
.nav-pills>li.active>a, .nav-pills>li.active>a:hover, .nav-pills>li.active>a:focus
	{
	color: #ffffff;
	background-color: #39d2fd;
}
.rbtn-info {
    color: #fff;
    background-color: #39d2fd;
    border-color: #03c6fc;
}

.back{
	border-top-left-radius: 4px;
	border-top-right-radius: 4px;
	color: #ffffff;
	background-color: #39d2fd;
}
</style>
</head>
<body>
	<div class="col-md-10">
		<div class="col-md-12">
			<table class="table text-center">
				<thead>
					<tr>
						<th class="back text-center">스터디</th>
						<th class="back text-center">신청 상태</th>
						<th class="back text-center">신청 날짜</th>
						<th class="back text-center"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>미드 정복 !</td>
						<td>수락</td>
						<td>2018.01.03</td>
						<td>
							<button type="button" class="btn rbtn-info btn-sm">메모 보기</button>
							<button type="button" class="btn btn-danger btn-sm">탈퇴</button>
						</td>
					</tr>
					<tr>
						<td>일드 정복 !</td>
						<td>신청</td>
						<td>2018.01.03</td>
						<td>
							<button type="button" class="btn rbtn-info btn-sm">메모 보기</button>
							<button type="button" class="btn btn-danger btn-sm">취소</button>
						</td>
					</tr>
					<tr>
						<td>댄스 정복 !</td>
						<td>거부</td>
						<td>2018.01.03</td>
						<td>
							<button type="button" class="btn rbtn-info btn-sm">메모 보기</button>
							<button type="button" class="btn btn-danger btn-sm">삭제</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>