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
<script type="text/javascript" src="${APP_PATH }/static/js/jquery.min.js"></script>
<link rel="stylesheet" href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
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
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
						 
					</tr>
					<C:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<th>${emp.empId }</th>
							<th>${emp.empName }</th>
							<th>${emp.gender=="M"?"男":"女" }</th>
							<th>${emp.email }</th>
							<th>${emp.department.deptName }</th>
							<th>
								<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
							 
						</tr>
					</C:forEach>
					
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
			当前第${pageInfo.pageNum },总共${pageInfo.pages }页，总共${pageInfo.total }条记录
			</div>
			
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  <li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				    <li>
					    <C:if test="${pageInfo.hasPreviousPage }">
					    	<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous">
					        	<span aria-hidden="true">&laquo;</span>
					      	</a>
					    </C:if>
				      
				    </li>
				  	
				   
					      <C:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
						      <C:if test="${page_Num==pageInfo.pageNum }">
							    	<li class="active"><a href="#">${page_Num }</a></li>
							  </C:if>
							  <C:if test="${page_Num!=pageInfo.pageNum }">
							  		<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num }</a></li>
							  </C:if>
					      </C:forEach>
					<li>
						<C:if test="${pageInfo.hasNextPage }">
							<a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next">
					        	<span aria-hidden="true">&raquo;</span>
					        </a>
						</C:if>
				      
				    </li>
				    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages }">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>