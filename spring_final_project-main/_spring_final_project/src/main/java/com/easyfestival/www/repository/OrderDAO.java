package com.easyfestival.www.repository;

import java.util.List;

public interface OrderDAO {

	int insert_pay(OrderDTO orderDTO);

	int insert_payinfo(PayDTO payDTO);

	PayDTO getLastPay(PayDTO payDTO);

	PayDTO getPay(long payNum);

	List<Long> myOrderCount(String saveNUM);
	



}
