/**
 * <p>Title: DepartmentController.java</p>  
 * <p>Description: </p>  
 *
 * @author shenlan  
 * @date 2020年4月11日  
 */
package com.lss.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lss.crud.bean.Department;
import com.lss.crud.bean.Msg;
import com.lss.crud.service.DepartmentService;

/**
 * @author lishuaishuai
 *	处理和部门有关的请求
 */
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	//返回所有的部门信息
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepats() {
		List<Department> list=departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
	
}
