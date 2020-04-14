<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="C" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>员工列表</title>
<% 
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<!-- web 路径，
不以/开始的相对路径，以当前资源的路径为基准，容易出问题
以/开始的相对路径，以服务器路径为基准（http://localhost:3306）
 -->
<script src="${APP_PATH }/static/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="${APP_PATH }/static/bootstrap/css/bootstrap.min.css">
<script src="${APP_PATH }/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工修改</h4>
      </div>
      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add" class="col-sm-2 control-label">姓名：</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			    	<span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_update">
			    	<span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			     	<label class="radio-inline">
						 <input type="radio" name="gender" id="gender1_update" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
						 <input type="radio" name="gender" id="gender2_update" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="deptName_add" type="radio" class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
			    	<!-- 部门提交部门id即可 -->
			      	<select class="form-control" name="dId" id="dept_add_select">
						
					</select>
			    </div>
			  </div>
			  
			  
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>
<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add" class="col-sm-2 control-label">姓名：</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add" placeholder="empName">
			    	<span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add" class="col-sm-2 control-label">邮箱</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add" placeholder="email">
			    	<span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add" class="col-sm-2 control-label">性别</label>
			    <div class="col-sm-10">
			     	<label class="radio-inline">
						 <input type="radio" name="gender" id="gender1_add" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
						 <input type="radio" name="gender" id="gender2_add" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="deptName_add" class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
			    	<!-- 部门提交部门id即可 -->
			      	<select class="form-control" name="dId" id="dept_add_select">
						
					</select>
			    </div>
			  </div>
			  
			  
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>
	<!-- 搭建显示页面 -->
	<div class="container">
	
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-9">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">	
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					
					<tbody>
						
					
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
			</div>
			
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord,currentPage;
		//页面加载完了，直接发生ajax请求，要到分页数据
		$(function(){
			to_page(1);
		});
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					build_page_nav(result);
					//解析json
					build_emps_table(result);
					//解析显示分页信息
					build_page_info(result);
				}
			});
		}
		function build_emps_table(result){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd= $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
				//为新增按钮添加自定义属性 ，存放用户id
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
				//为删除按钮添加自定义属性 ，存放用户id
				delBtn.attr("dle-id",item.empId)
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//append方法执行完了以后还是返回原来的元素
				$("<tr></tr>").append(checkBoxTd)
						.append(empIdTd)
						.append(empNameTd)
						.append(genderTd)
						.append(emailTd)
						.append(deptNameTd)
						.append(btnTd)
						.appendTo("#emps_table tbody");
			});
		}
		//解析分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+
					"页 ,总共"+result.extend.pageInfo.pages+"页，总共"
					+result.extend.pageInfo.total+"条记录");
			totalRecord=result.extend.pageInfo.total;
			currentPage=result.extend.pageInfo.pageNum;
		}
		//解析分页条
		function build_page_nav(result){
			$("#page_nav_area").empty();
			//page_nav_area
			
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
				
			}else{
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			
			//添加首页和前一页的提示
			ul.append(firstPageLi).append(prePageLi);	
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				//添加 1 2 3 4 5 
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
				
			}else{
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			//添加末页和后一页的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
//============================新增======================================//
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据
			reset_form("#empAddModel form");
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModel select");
			//弹出模态框
			$("#empAddModel").modal({
				backdrop:"static"
			});
		});
		//查出所有的部门信息 显示在下拉列表
		function getDepts(ele){
			//清空之前的下拉列表信息
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result)
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		//校验表单数据
		function validate_add_form(){
			//拿到数据进行校验
			var empName = $("#empName_add").val();
			var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u4E00-\u9FA5]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文，或者4-16位英文数字组合");
				show_validate_msg("#empName_add","error","用户名可以是2-5位中文，或者4-16位英文数字组合");
				return false;
			}else{
				show_validate_msg("#empName_add","success","");
			}
			//邮箱校验
			var empEmail = $("#email_add").val();
			var regEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
			if(!regEmail.test(empEmail)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add","success","");

			}
			return true;
		}
		//校验结果提示信息
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#empName_add").change(function(){
			//发送ajax请求 校验用户名是否重复
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
				
			});
		});
		
		//保存新增用户信息
		$("#emp_save_btn").click(function(){
			//1.校验数据
			if(!validate_add_form()){
				return false;
			};
			//2.判断用户校验是否成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//3.保存
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModel form").serialize(),
				success:function(result){
					if(result.code==100){
						//alert(result.msg);
						$('#empAddModel').modal('hide');
						to_page(totalRecord);
					}else{
						//显示失败信息
						console.log(result);
						//显示失败信息
						if(undefined!=result.extend.errorField.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add","error",result.extend.errorField.email);
							
						}
						if(undefined != result.extend.errorField.empName){
							//显示员工名字的错误信息
							show_validate_msg("#empName_add","error",result.extend.errorField.empName);
						}
					}
					
				}
			});
		});
//=============================更新================================================//
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update").val(empData.email);
					$("#empUpdateModel input[name=gender]").val([empData.gender]);
					$("#empUpdateModel select").val([empData.dId]);
				}
			});
		}
	
		//绑定编辑按钮   1、添加按钮后绑定 高耦合，2.使用on
		$(document).on("click",".edit_btn",function(){
			//0.查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"));
			//1.查出部门信息，并显示部门列表
			getDepts("#empUpdateModel select");
			//把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
		 
			$("#empUpdateModel").modal({
				backdrop:"static"
			});
		});
		
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			//邮箱校验
			var empEmail = $("#email_update").val();
			var regEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
			if(!regEmail.test(empEmail)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_update","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update","success","");

			}
			//发送ajax请求 保存更新
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"POST",
				data:$("#empUpdateModel form").serialize()+"&_method=PUT",
				success:function(result){
					//alert(result.msg);
					//1.关闭对话框
					$("#empUpdateModel").modal("hide");
					//2.回到本页面
					to_page(currentPage);
				}
			});
			return true;
		});
//===================================删除=============================================//
	//单个删除	
	$(document).on("click",".delete_btn",function(){
		//1.弹出是否确认删除对话框
		var empName = $(this).parents("tr").find("td:eq(1)").text();
		var empId = $(this).attr("dle-id");
		if(confirm("确认删除【"+empName+"】吗？")){
			//确认，发送ajax请求删除即可
			$.ajax({
				url:"${APP_PATH}/emp/"+empId,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					//回到本页
					to_page(currentPage);
				}
			});
		}
	});
	//全选|全不选
	$("#check_all").click(function(){
		//attr获取checked是undifined
		//使用prop获取dom原生的属性 ，attr获取自定义属性
		//alert($(this).prop("checked"));
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	$(document).on("click",".check_item",function(){
		//判断当前的元素是否为5个
		var flag = $(".check_item:checked").length==$(".check_item").length
		$("#check_all").prop("checked",flag);
		
	});
	//点击全部删除
	$("#emp_delete_all").click(function(){
		var empNames = "";
		var del_idstr = "";
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			//组装员工id字符串
			del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		//取出enmNames多余的,
		empNames = empNames.substring(0,empNames.length-1);
		//取出id多余的-
		del_idstr = del_idstr.substring(0,del_idstr.length-1);
		if(confirm("确认删除【"+empNames+"】吗？")){
			//发送ajax请求
			$.ajax({
				url:"${APP_PATH}/emp/"+del_idstr,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					to_page(currentPage);
				}
			});
		}
	});
	</script>
</body>
</html>