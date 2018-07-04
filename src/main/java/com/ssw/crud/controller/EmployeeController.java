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
	 * ��ҳ��ѯԱ����Ϣ
	 */
	@RequestMapping("/emps")
	public String selectAll(@RequestParam(value="pageNo",defaultValue="1")Integer pageNo
							, ModelMap model) {
		//����PageHelper��ҳ���������ҳ�� �Լ� ÿҳ�ļ�¼��
		//ʹ��PageInfo��װ��ѯ��Ľ����ֻ��Ҫ��PageInfo����ҳ��
		//��װ�����ǲ�ѯ����Ϣ ���Լ�������ʾ��ҳ��
	   	PageHelper.startPage(pageNo, 10);
		List<Employee> list = employeeService.selectAll();
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(list,5);
		
		model.addAttribute("pageInfo", pageInfo);
		return "list";
	}
	/*
	 * ʹ��ajax ��json���ؿͻ���
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
			//У��ʧ�ܣ���ģ̬������ʾ��Ϣ
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("������ֶ���"+fieldError.getField());
				System.out.println("�������Ϣ"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else if(employeeService.insertSelective(employee)>0){
				return Msg.success();  
		}
		return Msg.fail();
	}
	/*
	 * �����û����Ƿ��ظ�
	 */
	@RequestMapping("/checkEmp")
	@ResponseBody
	public Msg changeEmpName(@RequestParam("empName") String empName) {
		String regex = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)) {
			return Msg.fail().add("emp_vali", "�û���������5-16λӢ�Ļ�2-5λ������");
		}
		boolean b = employeeService.selectByEmpName(empName);
		if(b) {
			return Msg.fail().add("emp_vali", "�û����ظ�");
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
	//Ա������
	/*
	 * 1.tomcat���������еķ�װ��һ��map
	 * 2.request.getParameter();���Ի�ȡ��map�е�ֵ
	 * 3.SpringMvc��װPOJO�����ʱ�� 
	 * 				ÿ�����Ե�ֵ ��ͨ��request.getParameter();�õ�
	 * ��ajax����PUT�����ʱ�� tomcat���Ὣ���е�����װ��map
	 */
	@RequestMapping(value="/emps/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
//		System.out.println(employee);
		employeeService.updateByPrimaryKeySelective(employee);
		return Msg.success();
	}
	
	//Ա��ɾ��
	@RequestMapping(value="/emps/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpByEmpID(@PathVariable("id") String empIds) {
		//����ɾ��
		if(empIds.contains("-")) {
			List<Integer> list = new ArrayList<>();
			String[] strings = empIds.split("-");
			for (String string : strings) {
				list.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(list);
		}else {
			//����ɾ��
			Integer empId = Integer.parseInt(empIds);
			employeeService.deleteByPrimaryKey(empId);
		}
		return Msg.success();
	}
}
