<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자바스</title>

<link rel="stylesheet" href="/resources/css/sub.css" type="text/css">

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<style>
body, h1, h2, h3, h4, h5, h6, p, span {
	font-family: 'Noto Sans KR', sans-serif !important;
}
</style>

</head>
<body>

	<section class="checkout-section spad mt-5">
		<div class="container">
			<form class="checkout-form">
				<div class="row">
					<div class="col-lg-12">

						<h3>${payDTO.orderNum }님의전체주문 내역</h3>

						<div class="point_list_box">

							<table class="point_table">
								<colgroup>
									<col style="width: 15%">
									<col style="width: 55%;">
									<col style="width: 15%">
									<col style="width: 15%">
								</colgroup>
								<tr class="table_top_tr">
									<th>주문일/주문번호</th>
									<th>상품정보</th>
									<th>상태</th>
									<th>신청</th>
								</tr>

								<tbody>
									<c:choose>
										<c:when test="${empty orderMap }">
											<td colspan="4" class="null_text">상품 문의 내역이 없습니다.</td>
										</c:when>
										<c:otherwise>
											<c:forEach var="map" items="${orderMap}" varStatus="it">
												<c:set var="index" value="${it.index}" />
												<fmt:formatDate var="regdate"
													value="${map.value[0].orderDate}" pattern="yyyy-MM-dd" />
												<tr>
													<input type="hidden" value="${map.key}" class="orderNum">
													<td class="order_num_td">${regdate}<br> <span
														value="${map.key}">( ${map.key} )</span><br>
														<button type="button" class="table_btn site-btn">주문
															상세보기</button>
													</td>
													<c:forEach var="val" items="${map.value}" varStatus="itt">
														<td class="order_info_td"><img
															src="/resources/img/${val.img}" width="50">
															<div>
																<input type="hidden" class="usernum" value="${val.num}" />
																<a
																	onclick="location.href='/studyCafe/cafeDetail?scName=${val.productName }'">
																	${val.productName } </a> / <span> (${val.roomName})
																</span> / <span> (${val.seDate}) </span> / <span>
																	(${val.seTime}) </span>
																<hr>
																<span>${val.totalPrice }원 / </span> <span>${val.timeLength}
																	(시간)</span>
															</div></td>
														<td>
															<button type="button" order-num="${val.orderNum}"
																class="payMentCancel site-btn">주문취소</button> <br>
														</td>

													</c:forEach>

												</tr>
											</c:forEach>

										</c:otherwise>
									</c:choose>
								</tbody>
							</table>

							<div class="paging_container">
								<c:if test="${pm.prev }">
									<a href="myOrderList?pagingNum=${pm.startPage - 1}"
										class="paging_a">이전</a>
								</c:if>

								<c:forEach var="block" varStatus="pg" begin="${pm.startPage }"
									end="${pm.endPage }" step="1">
									<c:choose>
										<c:when test="${pg.index == pagingNum }">
											<a href="myOrderList?pagingNum=${pg.index }"
												class="paging_num_yes">${pg.index }</a>
										</c:when>
										<c:otherwise>
											<a href="myOrderList?pagingNum=${pg.index }"
												class="paging_num">${pg.index }</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<c:if test="${pm.next }">
									<a href="myOrderList?pagingNum=${pm.endPage + 1}"
										class="paging_a">다음</a>
								</c:if>
							</div>

						</div>

						<button onclick="cancelPay()">환불하기</button>
						<!-- jQuery CDN --->


					</div>
				</div>
				<!-- 리뷰 페이지 끝 -->

			</form>
		</div>
	</section>

	<script src="/resources/js/myOrderAdmin.js">
		
	</script>
</body>
</html>