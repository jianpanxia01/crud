package com.lss.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lss.crud.bean.Department;
import com.lss.crud.bean.Employee;
import com.lss.crud.dao.DepartmentMapper;
import com.lss.crud.dao.EmployeeMapper;

/**
 * 
 * @author lishuaishuai
 *导入springtext 文件
 *@ContextConfiguration 指定spring 配置文件的位置
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	@Test
	public void testCRUD() {
		//创建springIOC容器
//		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		//从容器中获取mapper
//		DepartmentMapper bean = ctx.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		//1.插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		
		//2.生成员工
//		employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
		
		//3.批量插入多个员工，可以执行批量操作sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		
		for(int i = 0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
		}
		System.out.println("批量完成");
	}
}
