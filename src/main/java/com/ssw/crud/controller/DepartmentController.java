package com.ssw.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssw.crud.bean.Department;
import com.ssw.crud.bean.Msg;
import com.ssw.crud.service.DepartmentService;

@Controller
public class DepartmentController {
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		
		List<Department> deptList = departmentService.getDepts();
		return Msg.success().add("deptList", deptList);
	}
}
