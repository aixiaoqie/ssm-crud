package com.ssw.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Employee {

	private Integer empId;
    
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
    		message="用户名必须是5-16位英文或2-5位的中文（JSR303）")
    private String empName;

    private String empGender;
    
    @Email(regexp = "^([a-z0-9_\\.-]+)@([a-z\\.-]+)\\.([a-z\\.]{2,6})$",
    					/* /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/  */
    		message="邮箱格式不对（JSR303）")
    private String empMail;

    private Integer dId;
    
    private Department department;

    public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public String getEmpMail() {
        return empMail;
    }

    public void setEmpMail(String empMail) {
        this.empMail = empMail == null ? null : empMail.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String empGender, String empMail, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empGender = empGender;
		this.empMail = empMail;
		this.dId = dId;
	}

	public void setdId(Integer dId) {
        this.dId = dId;
    }

	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", empGender=" + empGender + ", empMail=" + empMail
				+ ", dId=" + dId + ", department=" + department + "]";
	}
	
}