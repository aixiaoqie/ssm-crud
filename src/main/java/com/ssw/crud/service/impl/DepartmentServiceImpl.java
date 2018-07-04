package com.ssw.crud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssw.crud.bean.Department;
import com.ssw.crud.dao.DepartmentMapper;
import com.ssw.crud.service.DepartmentService;
@Service
public class DepartmentServiceImpl implements DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	@Override
	public List<Department> getDepts() {
		List<Department> list = departmentMapper.getDepts();
		return list;
	}


}
