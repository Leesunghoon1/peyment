package com.easyfestival.www.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easyfestival.www.repository.OrderDTO;
import com.easyfestival.www.service.PayService;
import com.easyfestival.www.service.OrderService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/peyment/*")
public class PeymentController {

	@Value("7820725586500628")
	private String apiKey;

	@Value("8kJzA2A8JvcuCEVuWlXENjqli35CyLVev2gY4grQLmxfnj2DZvvqPZu4sDlrLLjjdmDpKaUiEkDEyCJM")
	private String secretKey;

	private IamportClient api = new IamportClient(apiKey, secretKey);
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private OrderService orderService;

	public PeymentController() {
		// REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
		this.api = new IamportClient("7820725586500628",
				"8kJzA2A8JvcuCEVuWlXENjqli35CyLVev2gY4grQLmxfnj2DZvvqPZu4sDlrLLjjdmDpKaUiEkDEyCJM");
	}

	@RequestMapping(value = "/peverifyIamport/{imp_uid}")
	@ResponseBody
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session,
			@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
		return api.paymentByImpUid(imp_uid);
	}

	@RequestMapping(value = "/complete", method = RequestMethod.POST)
	@ResponseBody
	public int paymentComplete(HttpSession session, String imp_uid, String merchant_uid, String totalPrice,@RequestBody OrderDTO orderDTO) throws Exception {
		// 
		log.info(" orderDTO >>>> {}", orderDTO);
		String token = payService.getToken();
		log.info(" tocen >>>> {}", token);

		// 결제 완료된 금액
		String amount = payService.paymentInfo(orderDTO.getImp_uid(), token);
		log.info(" amount >>>> {}", amount);

		int res = 1;

		if (orderDTO.getTotalPrice() != Long.parseLong(amount)) {
			res = 0;
			// 결제 취소
			payService.payMentCancle(token, orderDTO.getImp_uid(), amount, "결제 금액 오류");
			return res;
		}
		
		orderService.insert_pay(orderDTO);
		return res;

	}

}
