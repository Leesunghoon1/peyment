package com.easyfestival.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.easyfestival.www.domain.PackageVO;
import com.easyfestival.www.repository.PackageDAO;

import lombok.extern.slf4j.Slf4j;

@Service
public class PackageServiceImpl implements PackageService{
	
	@Inject
	private PackageDAO pdao;

	@Override
	public int register(PackageVO pgvo) {
		// TODO Auto-generated method stub	
		return pdao.register(pgvo);
	}

	@Override
	public List<PackageVO> getList() {
		// TODO Auto-generated method stub
		return pdao.getlist();
	}

	@Override
	public PackageVO getDetail(int pkNo) {
		// TODO Auto-generated method stub
		return pdao.getPackageDetail(pkNo);
	}
	
	

}
