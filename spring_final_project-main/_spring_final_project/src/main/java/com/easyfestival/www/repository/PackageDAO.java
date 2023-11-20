package com.easyfestival.www.repository;

import java.util.List;

import com.easyfestival.www.domain.PackageVO;

public interface PackageDAO {

	int register(PackageVO pgvo);

	List<PackageVO> getlist();

	PackageVO getDetail(int pkNo);

}
