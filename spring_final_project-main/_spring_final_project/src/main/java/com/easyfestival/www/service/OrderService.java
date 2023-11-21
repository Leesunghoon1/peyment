package com.easyfestival.www.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easyfestival.www.repository.OrderDAO;
import com.easyfestival.www.repository.OrderDTO;

@Service
public class OrderService {
	
	@Autowired
	private OrderDAO orderDAO;

	public int insert_pay(OrderDTO orderDTO) throws Exception{
		
		
		return orderDAO.insert_pay(orderDTO);
	}

}