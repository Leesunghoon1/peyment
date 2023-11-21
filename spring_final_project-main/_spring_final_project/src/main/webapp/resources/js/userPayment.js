console.log(pkVo);

// 정규식을 사용하여 패턴에 맞게 문자열 파싱
const matches = pkVo.match(/pkNo=(\d+), pkName=([^,]+), pkPrice=(\d+)/);
  var selectedValue = document.getElementById("paymentMethod").value;

// matches 배열에서 필요한 정보 추출
const pkNo = matches[1];
const pkName = matches[2];
const pkPrice = matches[3];





  function requestPay() {
    // IMP.request_pay(param, callback) 결제창 호출
    var uid = '';
    IMP.init("imp76450478");


    IMP.request_pay({ // param
        pg: selectedValue,
        pay_method: "card",
        merchant_uid: paymentUuid(), //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
        name: pkName,
      	amount: pkPrice,
		buyer_email : 'iamport@siot.do',
		buyer_name : '구매자이름',
		buyer_tel : '010-1234-5678',
		buyer_addr : '서울 강남구 도곡동',
		buyer_postcode : '123-456'
    }, function (rsp) { // callback
        if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
            uid = rsp.imp_uid;
            // 결제검증
            $.ajax({
                url: '/peyment/peverifyIamport/' + rsp.imp_uid,
                type: 'post',
                dataType: 'json',
                contentType: 'application/json'
            }).done(function(data) {
                // 결제를 요청했던 금액과 실제 결제된 금액이 같으면 해당 주문건의 결제가 정상적으로 완료된 것으로 간주한다.
                console.log(data);
                if (pkPrice == data.response.amount) {
                    // jQuery로 HTTP 요청
                    // 주문정보 생성 및 테이블에 저장 
                    // @@ 주문정보는 상품 개수만큼 생성되어야 해서 상품 개수만큼 반복문을 돌린다
                    // 이때 order code는 모두 같아야 한다.          
		        	
                        // 데이터를 json으로 보내기 위해 바꿔준다.
                        data = JSON.stringify({
                            "orderNum" : 123,
                            "productNum" : 123, //상품번호
                            "num" : 123, // 회원번호
                            "productName" : "rsp.name",
                            "orderDate" : new Date().getTime(),
                            "totalPrice" : 123,
                            "imp_uid" : "rsp.imp_uid",
                            "reserNum" :  123 // 예약정보를 담고있는번호
                        });
                        console.log(data);
					
                        $.ajax({
                            url: "/peyment/complete",
                            type: 'post',
                            dataType: 'json',
                            contentType: 'application/json',
                            data : data
                        })
                        .done(function(res) {
                            if (res > 0) {
                                console.log(res);
                                alert('주문정보 저장 성공')
                                swal('주문정보 저장 성공')
                                createPayInfo(uid);
                            }
                            else {
                                console.log(data);
                                alert('주문정보 저장 실패');
                            }
                        })
                }
                else {
                    alert('결제 실패');
                }
            })
            } else {
                swal("결제에 실패하였습니다.","에러 내용: " +  rsp.error_msg,"error");
            }
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

function createPayInfo(uid) {
    // 결제정보 생성 및 테이블 저장 후 결제완료 페이지로 이동 
    console.log("시작");
    $.ajax({
        type: 'get',
        url: '/order/pay_info',
        data: {
            'imp_uid': uid,
        },
        success: function(data) {
            
            swal('결제 성공 !',"결제완료 페이지로 이동합니다.","success").then(function(){
                
                // 결제완료 페이지로 이동
                location.replace('/order/complete?payNum='+data);

            })
        },
        error: function() {
            swal('결제정보 저장 통신 실패');
        }
    });
}
