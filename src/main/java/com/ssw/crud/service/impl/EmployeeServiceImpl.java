package com.ssw.crud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssw.crud.bean.Employee;
import com.ssw.crud.dao.EmployeeMapper;
import com.ssw.crud.service.EmployeeService;
@Service
public class EmployeeServiceImpl implements EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	@Override
	public List<Employee> selectAll() {
		List<Employee> list = employeeMapper.selectAll();
		return list;
	}
	@Override
	public int insertSelective(Employee record) {
		int i = employeeMapper.insertSelective(record);
		return i;
	}
	@Override
	public boolean selectByEmpName(String empName) {
		String employee = employeeMapper.selectByEmpName(empName);
		//String dbEmpName = employee.getEmpName();
		if(empName.equals(employee)) {
			return true;
		}else {
			return false;
		}
		
	}
	@Override
	public Employee selectByPrimaryKey(Integer empId) {
		Employee employee = employeeMapper.selectByPrimaryKey(empId);
		return employee;
	}
	@Override
	public int updateByPrimaryKeySelective(Employee record) {
		int i = employeeMapper.updateByPrimaryKeySelective(record);
		return i;
	}
	@Override
	public int deleteByPrimaryKey(Integer empId) {
		int i = employeeMapper.deleteByPrimaryKey(empId);
		return i;
	}
	@Override
	public int deleteBatch(List<Integer> list) {
		int i = employeeMapper.deleteBatch(list);
		return i;
	}

}
