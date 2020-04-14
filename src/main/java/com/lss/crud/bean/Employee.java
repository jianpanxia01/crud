package com.lss.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Length;

public class Employee {
    private Integer empId;
    
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\\\u4E00-\\\\u9FA5]{2,5})"
    		,message = "用户名可以是2-5位中文，或者4-16位英文数字组合")
    private String empName;

    private String gender;
    
    @Pattern(regexp = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$"
    		,message = "邮箱格式不正确")
    private String email;

    private Integer dId;
    
    //鏌ヨ鍛樺伐鍚屾椂閮ㄩ棬淇℃伅涔熸煡璇㈠ソ鐨�
    private Department department;
    
    
    public Employee() {
		super();
		// TODO Auto-generated constructor stub
	}

	 
	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}


	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email
				+ ", dId=" + dId + ", department=" + department + "]";
	}


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
        this.empName = empName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}