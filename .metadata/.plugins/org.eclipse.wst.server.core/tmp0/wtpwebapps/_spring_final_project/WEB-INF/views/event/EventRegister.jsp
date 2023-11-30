<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/css/tmpCss.css" rel="stylesheet">

<!-- include libraries(jQuery, bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

</head>

<body>

		<form action="/event/eventRegister" method="post">
			<table>
				<tr>
					<th>이벤트 제목</th>
					<td><input type="text" name="evName"></td>
				</tr>
				<tr>
					<th>이벤트 시작일</th>
					<td><input type="datetime-local" name="evStart"></td>
				</tr>
				<tr>
					<th>이벤트 종료일</th>
					<td><input type="datetime-local" name="evEnd"></td>
				</tr>
				<tr>
					<th>이벤트 타입</th>
					<td><select name="evType">
							<option>선택...</option>
							<option value="discountEv">할인</option>
							<option value="rouletteEv">룰렛</option>
							<option value="LadderEv">사다리 타기</option>
					</select></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea id="summernote" name="evContent"></textarea></td>
				</tr>
			</table>

			<button type="submit">등록</button>
		</form>
	

	<script type="text/javascript">
		$('#summernote').summernote({
			height : 300, // 에디터 높이 설정
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
					// 이미지 업로드 시 호출되는 콜백 함수
					 for (var i = files.length - 1; i >= 0; i--) {
						uploadImage(files[0], editor, welEditable); // 파일 업로드 함수 호출
					}
				}
			}
		});
	</script>
	<script type="text/javascript">
		function uploadImage(file, editor, welEditable) {
			var formData = new FormData();
			formData.append('file', file);

			$.ajax({
				url : '/event/uploadSummernoteImageFile', // 이미지 업로드를 처리하는 서버 URL
				method : 'POST',
				data : formData,
				processData : false,
				contentType : false,
				datatype : 'JSON',
				enctype : 'multipart/form-data',
				success : function(resp, editor, welEditable) {
					// 이미지 업로드 성공 시 처리
					console.log('success!!');
					console.log(resp);

					let Rurl = resp.url;

					$('#summernote').summernote('editor.insertText', '해치웠나	');
					 let imgData = $("<img>").attr('src',Rurl);
					 console.log(imgData);
					 $('#summernote').summernote("insertNode", imgData[0]);
				},
				error : function(resp) {
					// 이미지 업로드 실패 시 처리
					console.log(resp);
					console.log('이미지 업로드 실패');
				}
			});
		}
	</script>



</body>
</html>