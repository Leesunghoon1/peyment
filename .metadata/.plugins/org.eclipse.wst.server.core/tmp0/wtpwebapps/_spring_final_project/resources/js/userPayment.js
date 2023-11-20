console.log(pkVo);

// 정규식을 사용하여 패턴에 맞게 문자열 파싱
const matches = pkVo.match(/pkNo=(\d+), pkName=([^,]+), pkPrice=(\d+)/);

// matches 배열에서 필요한 정보 추출
const pkNo = matches[1];
const pkName = matches[2];
const pkPrice = matches[3];


   function requestPay() {
    var uid = '';
    IMP.init("imp76450478");
   
   
   var selectedValue = document.getElementById("paymentMethod").value;

    IMP.request_pay({
          pg: selectedValue,
          pay_method: "card",
          merchant_uid: paymentUuid(),
          name: pkName,
      	    amount: pkPrice,
     		buyer_email : 'iamport@siot.do',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울 강남구 도곡동',
		    buyer_postcode : '123-456'
          
        }, function(rsp) {
			console.log(rsp);
			// 결제검증
			$.ajax({

  		
                            type: "POST",
                            dataType: 'json',
                            contentType: 'application/json',
							url : "/verifyIamport/" + rsp.imp_uid
	        	
	        }).done(function(data) {
	        	
	        	console.log(data);
	        	
	        	// 위의 pkPrice 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
	        	if(pkPrice == data.response.amount){
		        	alert("결제 및 결제검증완료");
	        	} else {
	        		alert("결제 실패");
	        	}
	        });
		});
	}

// uuid만들기
function paymentUuid(){
	const date = new Date();
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const day = String(date.getDate()).padStart(2, "0");
	
	let orderNum = year + month + day;
	for(let i=0;i<10;i++) {
		orderNum += Math.floor(Math.random() * 8);	
	}
	return orderNum;
}