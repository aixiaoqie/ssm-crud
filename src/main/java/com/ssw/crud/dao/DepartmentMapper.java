package com.ssw.crud.dao;

import java.util.List;

import com.ssw.crud.bean.Department;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Integer depId);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(Integer depId);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
    
    List<Department> getDepts();
}