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
						<th class="back text-center">���͵�</th>
						<th class="back text-center">��û ����</th>
						<th class="back text-center">��û ��¥</th>
						<th class="back text-center"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>�̵� ���� !</td>
						<td>����</td>
						<td>2018.01.03</td>
						<td>
							<button type="button" class="btn rbtn-info btn-sm">�޸� ����</button>
							<button type="button" class="btn btn-danger btn-sm">Ż��</button>
						</td>
					</tr>
					<tr>
						<td>�ϵ� ���� !</td>
						<td>��û</td>
						<td>2018.01.03</td>
						<td>
							<button type="button" class="btn rbtn-info btn-sm">�޸� ����</button>
							<button type="button" class="btn btn-danger btn-sm">���</button>
						</td>
					</tr>
					<tr>
						<td>�� ���� !</td>
						<td>�ź�</td>
						<td>2018.01.03</td>
						<td>
							<button type="button" class="btn rbtn-info btn-sm">�޸� ����</button>
							<button type="button" class="btn btn-danger btn-sm">����</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>