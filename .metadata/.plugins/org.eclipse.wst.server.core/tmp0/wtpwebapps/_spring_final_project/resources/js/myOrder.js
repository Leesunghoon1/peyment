const matches = pkVo.match(/payNum=(\d+), id=([^,]+), orderNum=(\d+), payMethod=([^,]+), payName=([^,]+), payDate=([^,]+), payAmount=(\d+)/);
console.log(pkVo);

// matches 배열에서 필요한 정보 추출
const payNum = matches[1];
const id = matches[2];
const orderNum = matches[3];
const payMethod = matches[4];
const payName = matches[5];
const payDate = matches[6];
const payAmount = matches[7];

console.log("payNum:", payNum);
console.log("id:", id);
console.log("orderNum:", orderNum);
console.log("payMethod:", payMethod);
console.log("payName:", payName);
console.log("payDate:", payDate);
console.log("payAmount:", payAmount);

document.addEventListener("DOMContentLoaded", function () {
    const payMentCancelButtons = document.querySelectorAll('.payMentCancel');

    payMentCancelButtons.forEach(function(button) {
        button.addEventListener("click", function () {

            console.log("1111" + payNum)
            console.log("1111" + orderNum)
            $.ajax({
              type: 'POST',
              url: '/peyment/completeDetail',
              data: {
                  value: payNum.value,
              },
              success: function(data) {
                      console.log("112" + data)
                      if(data == 1){
                        location.replace('/peyment/completeDetail?payNum='+payNum.value);
                      } 
                    }
          });

            const userConfirmed = confirm("주문을 취소하시겠습니까?\n취소하면 되돌릴 수 없습니다.!");

            if (userConfirmed) {
                alert("주문을 취소하였습니다!");
                const xhttp = new XMLHttpRequest();
                console.log(xhttp);

                
                xhttp.open("POST", "/peyment/orderCancle");
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send("orderNum=" + orderNum);

                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        let result1 = xhttp.responseText.trim();
                        console.log(result1 + "11111");

                        if (result1 == 1) {
                            location.replace('/package/list');
                        } else {
                            alert("이미 취소된 주문이거나 없는 주문번호입니다.");
                        }
                    }
                }
            } else {
                alert("보류하였습니다!");
            }
        });
    });
});

function cancelPay(){
		
		
    const xhttp = new XMLHttpRequest;

    xhttp.open("POST","../admin/orderCancle")

    
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");


    xhttp.send("orderNum="+orderNum);

    xhttp.onreadystatechange=function(){
        if(this.readyState==4 && this.status==200){
           let result1 = xhttp.responseText.trim();
           console.log(result1);
               if(result1==1){
                   console.log("삭제성공")
           
               } else{
                   console.log("삭제실패");
               }
        } 
    }
}





