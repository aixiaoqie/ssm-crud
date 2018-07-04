package com.ssw.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssw.crud.bean.Employee;
import com.ssw.crud.bean.Msg;
import com.ssw.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;

	/*
	 * 分页查询员工信息
	 */
	@RequestMapping("/emps")
	public String selectAll(@RequestParam(value="pageNo",defaultValue="1")Integer pageNo
							, ModelMap model) {
		//引入PageHelper分页插件，传入页码 以及 每页的记录数
		//使用PageInfo包装查询后的结果，只需要将PageInfo交给页面
		//封装了我们查询的信息 ，以及连续显示的页数
	   	PageHelper.startPage(pageNo, 10);
		List<Employee> list = employeeService.selectAll();
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(list,5);
		
		model.addAttribute("pageInfo", pageInfo);
		return "list";
	}
	/*
	 * 使用ajax 将json返回客户端
	 */
	@RequestMapping("/emps1")
	@ResponseBody
	public Msg selectAllWithJson(@RequestParam(value="pageNo",defaultValue="1")Integer pageNo) {
		PageHelper.startPage(pageNo, 10);
		List<Employee> list = employeeService.selectAll();
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(list,5);
		
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	@RequestMapping(value="/emps",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmps(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<>();
			//校验失败，在模态框中显示信息
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名"+fieldError.getField());
				System.out.println("错误的信息"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else if(employeeService.insertSelective(employee)>0){
				return Msg.success();  
		}
		return Msg.fail();
	}
	/*
	 * 检验用户名是否重复
	 */
	@RequestMapping("/checkEmp")
	@ResponseBody
	public Msg changeEmpName(@RequestParam("empName") String empName) {
		String regex = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)) {
			return Msg.fail().add("emp_vali", "用户名可以是5-16位英文或2-5位的中文");
		}
		boolean b = employeeService.selectByEmpName(empName);
		if(b) {
			return Msg.fail().add("emp_vali", "用户名重复");
		}else {
			return Msg.success();
		}	
	}
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmpName(@PathVariable("id")Integer id) {
		Employee employee = employeeService.selectByPrimaryKey(id);
		return Msg.success().add("emp", employee);
	}
	//员工更新
	/*
	 * 1.tomcat将请求体中的封装成一个map
	 * 2.request.getParameter();可以获取到map中的值
	 * 3.SpringMvc封装POJO对象的时候 
	 * 				每个属性的值 ，通过request.getParameter();拿到
	 * 而ajax发送PUT请求的时候 tomcat不会将其中的数封装成map
	 */
	@RequestMapping(value="/emps/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
//		System.out.println(employee);
		employeeService.updateByPrimaryKeySelective(employee);
		return Msg.success();
	}
	
	//员工删除
	@RequestMapping(value="/emps/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpByEmpID(@PathVariable("id") String empIds) {
		//批量删除
		if(empIds.contains("-")) {
			List<Integer> list = new ArrayList<>();
			String[] strings = empIds.split("-");
			for (String string : strings) {
				list.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(list);
		}else {
			//单个删除
			Integer empId = Integer.parseInt(empIds);
			employeeService.deleteByPrimaryKey(empId);
		}
		return Msg.success();
	}
}
