package com.ssw.crud.dao;

import java.util.List;

import com.ssw.crud.bean.Employee;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    Employee selectByPrimaryKey(Integer empId);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
    
    Employee selectByPrimaryKeyWithDept(Integer empId);
    
    List<Employee> selectAll();
    
    String selectByEmpName(String empName);
    
    int deleteBatch(List<Integer> list);
}