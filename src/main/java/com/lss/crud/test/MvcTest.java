/**
 * 
 */
package com.lss.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.lss.crud.bean.Employee;

/**
*使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
*Spring4测试时，需要servlet3.0支持
*@author lss
*@version 创建时间：2020年3月28日下午5:19:29
*/

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
	//传入springmvc的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟mvc请求，获取到处理结果
	MockMvc mockMvc; 
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "10")).andReturn();
		
		
		//请求成功后，请求域中会有pageInfo，我们可以拿出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码："+pi.getPages());
		System.out.println("总记录数："+pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pi.getNavigatepageNums();
		for(int i :nums){
			System.out.println(" "+i);
		}
		//获取员工数据
		List<Employee> list=pi.getList();
		for(Employee e:list) {
			System.out.println("ID: "+e.getEmpId()+"==>Name:"+e.getEmpName()+
					"==>gender:"+e.getGender()+"==>email:"+e.getEmail()+"==>d_id:"+e.getdId());
		}
	}
}
