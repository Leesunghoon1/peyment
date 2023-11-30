<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<table class="table table-hover">
		<tr>
			<th>rvNo</th>
			<td>${rvo.rvNo }</td>
		</tr>
		<tr>
			<th>title</th>
			<td>${rvo.title }</td>
		</tr>
		<tr>
			<th>userNo</th>
			<td>${rvo.userNo }</td>
		</tr>
		<tr>
			<th>readCount</th>
			<td>${rvo.readCount }</td>
		</tr>
		<tr>
			<th>cmtCount</th>
			<td>${rvo.cmtCount}</td>
		</tr>
	</table>
	<div id="contentArea">
		${rvo.content}
	</div>
	<a><button type="button">좋아요</button></a>
	<a href="/review/remove?rvNo=${rvo.rvNo}"><button type="button">삭제</button></a>
	<a href="/review/modify?rvNo=${rvo.rvNo}"><button type="button">수정</button></a>
	
	<!-- 댓글 영역 -->
	<!-- 댓글 등록 영역 -->
	<div class="input-group mb-3">
			<span id="cmtWriter" >123</span> 
			<input type="text"  placeholder="Comment Content" id="cmtText">
			<button  type="button" id="cmtPostBtn">POST</button>
		</div>
	<!-- 댓글 표시 영역 -->
	
	<script type="text/javascript">
		let rnoVal=`<c:out value='${rvo.rvNo }'/>`;
		console.log(rnoVal);
	</script>
	<script type="text/javascript" src="/resources/js/ReviewComment.js"></script>

</body>
</html>