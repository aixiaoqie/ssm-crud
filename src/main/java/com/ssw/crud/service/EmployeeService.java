package com.ssw.crud.service;

import java.util.List;

import com.ssw.crud.bean.Employee;

public interface EmployeeService {
	public List<Employee> selectAll();
	
	int insertSelective(Employee record);
	
	boolean selectByEmpName(String empName);
	
	Employee selectByPrimaryKey(Integer empId);
	
	int updateByPrimaryKeySelective(Employee record);
	
	int deleteByPrimaryKey(Integer empId);
	
	int deleteBatch(List<Integer> list);
}
