/**
 * 
 */
package com.lss.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lss.crud.bean.Employee;
import com.lss.crud.bean.Msg;
import com.lss.crud.dao.EmployeeMapper;
import com.lss.crud.service.EmployeeService;

/**
*澶勭悊CRUD璇锋眰
*@author lss
*@version 鍒涘缓鏃堕棿锛�2020骞�3鏈�28鏃ヤ笅鍗�4:56:13
*/
@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	/*
	 * 单个删除用户
	 * 批量删除：1-2-3
	 */
	@ResponseBody
	@RequestMapping(value="emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpId(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id的集合
			for(String string:str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);	
		}
		return Msg.success();
	}
	/*
	 * employee对象封装不上
	 * 原因：
	 * 	tomcat:	
	 * 			1.将请求的数据封装为一个map
	 * 			2.request.getParameter(“empName")就会从这个map中取值
	 * 			3.SpringMVC封装POJO对象的时候	会把POJO中每个属性的值，request.getParamter("email");
	 * 	AJAX 发送PUT请求应发的问题
	 * 		1.PUT请求，请求题中的数据，request.getParameter("empName")拿不到
	 * 		2.Tomcat一看是PUT请求，就不会封装请求题中的数据为map，只有post形式的请求封装请求体为map
	 * 解决方案：
	 * 要能支持PUT请求还要封装请求体的数据
	 * 配置HttpPutFormContentFilter
	 * 它的作用，将请求体的数据解析包装成一个map
	 * request被重新包装，request.getParameter（）被重写，就会从自己封装的map中拿取数据
	 * 
	 * 员工更新
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method = RequestMethod.PUT)
	public Msg saveEmp(Employee employee,HttpServletRequest request) {
		System.out.println(request.getParameter("empName"));
		System.out.println("将要更新的数据"+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/*
	 * 根据id查询员工
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id) {
		System.out.println("查询员工信息");
		Employee employee = employeeService.getEmp(id);
		System.out.println(employee);
		return Msg.success().add("emp",	employee);
	}
	
	/*
	 * 员工保存
	 * 1.支持JSR303校验
	 * 2.导入Hibernate-Validator包
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName) {
		//先判断用户名是否是合法的
		String regx="(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u4E00-\\u9FA5]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名可以是2-5位中文，或者4-16位英文数字组合");
			
		}
		
		//数据库用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
		
	}
	
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<>();
			List<FieldError> errors=result.getFieldErrors();
			for(FieldError fieldError :errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息:"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	//导入jackson包
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
		//引入pageHelper分页插件
		//在查询前只需要调用，传入页码，以及每页大小
		PageHelper.startPage(pn,5);
		//startPage后面紧跟的这个查询就是分页查询
		List<Employee> emps=employeeService.getAll();
		//使用pageInfo包装后的结果，只需要将pageInfo交给页面就行了
		//封装详细的分页信息，包括我们查询出来的数据，传入连徐显示的页数
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo", page);
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn,Model model) {
		//鍒嗛〉鏌ヨ
		//寮曞叆pageHelper鎻掍欢
		//鍦ㄦ煡璇箣鍓嶉渶瑕佽皟鐢� 浼犲叆椤电爜锛屼互鍙婃瘡椤靛ぇ灏�
		PageHelper.startPage(pn, 8);
		//startpage鍚庨潰绱ц窡鐨勬暟鎹氨鏄竴涓垎椤垫煡璇�
		List<Employee> emps = employeeService.getAll();
		//浣跨敤pageInfo鍖呰鏌ヨ鍚庣殑缁撴灉锛屽皢pageInfo浜ょ粰椤甸潰
		//灏佽鐨勮缁嗗垎椤典俊鎭紝鍖呮嫭鎴戜滑鏌ヨ鍑烘潵鐨勬暟鎹� 浼犲叆杩炵画鏄剧ず鐨勯〉鏁�
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}

}
