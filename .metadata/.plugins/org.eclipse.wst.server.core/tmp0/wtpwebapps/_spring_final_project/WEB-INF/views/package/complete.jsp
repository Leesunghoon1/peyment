<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

</head>
<body>
	

    <section class="checkout-section spad mt-5">
		<div class="container">
						
             
                            <div class="row pl-3">
							<div class="col-lg-1">
								<label for="fir">주문일자</label>
							</div>
						</div>
						<div class="row pl-3">
							<div class="col-lg-1">
								<label for="cun-name">주문번호</label>
							</div>
							<div class="col-lg-11 text-left">
								<label><strong>${payDTO.orderNum}</strong></label>
							</div>
						</div>
						<br><hr><br>
	
							
								
						<h4>주문/결제 금액 정보</h4>
						<div class="row">
						    <div class="col-lg-6">
						        <div class="row">
									<div class="col-lg-12">
										<div class="pl-3 row">
											<div class="col-lg-3">
												<label>상품금액</label>
												<label><strong>${payDTO.payAmount}</strong></label>
											</div>
											<div class="col-lg-5 text-right">
											</div>
										</div>
									</div>
									
									
						    <div class="col-lg-6">
						        <div class="row">
						            <div class="col-lg-3">
						                <label>결제정보</label>
						                
						            </div>
						            <div class="col-lg-5 text-right">
						                <strong>${payDTO.payMethod} 결제!!</strong>
						            </div>
						        </div>
						        <div class="row">
						            <div class="col-lg-8 text-right">  
						            </div>
						        </div>
						        <div class="row">
						            <div class="col-lg-3">
						                <label>결제금액</label>
						                <label><strong>${payDTO.payAmount}</strong></label>
						            </div>
						            <div class="col-lg-5 text-right">
						            </div>
						        </div>
						    </div>
						</div>
						<br>
						<hr>
						<br>
					</div>
				</div>
				<br>
				<div class="row text-center">
	
				</div>
		</div>
	</section>
</body>
</html>