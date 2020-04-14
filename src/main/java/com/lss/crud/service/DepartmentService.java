/**
 * <p>Title: DepartmentService.java</p>  
 * <p>Description: </p>  
 *
 * @author lss  
 * @date 2020Äê4ÔÂ11ÈÕ  
 */
package com.lss.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lss.crud.bean.Department;
import com.lss.crud.dao.DepartmentMapper;

/**
 * @author lishuaishuai
 *
 */
@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	 
	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> list=departmentMapper.selectByExample(null);
		return list;
	}
	
}
