<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>iamport</title>
<!-- jQuery -->

		

</head>
<body>
	<a class="nav-link" href="/package/register">Board Register</a>
	
	<table id="table" class="table table-dark table-hover">
		<tr>
			<th>#</th>
			<th>상품명</th>
			<th>상품가격</th>
		</tr>
			<tr data-bno="${payDTO.payNum}">
				<td>
				<a id="${payDTO.payNum}" href="/package/detail?pkNo=${payDTO.num}">${payDTO.num}</a>
				</td>
				<td>${payDTO.payName}</td>
				<td>${payDTO.payAmount}</td>
				
			</tr>
	</table>
	


	
	
	
</body>
</html>