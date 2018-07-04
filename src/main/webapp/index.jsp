<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<% 
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-10">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-hover" id="emp_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>empEmail</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info">
				
			</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
//	页面加载完成 发送ajax请求
	$(function() {
		$.ajax({
			url:"${APP_PATH}/emps1",
			data:"pageNo=1",
			type:"GET",
			success:function(result){
	//			console.log(result);
				//解析并显示员工数据
				build_emps_table(result);
				//解析并显示分页信息
				build_page_info(result);
				//解析并显示分页条
				build_page_nav(result)
			}
		});
	})
	
	function build_emps_table(result){
		//获取员工信息
 		var emps = result.map.pageInfo.list;
// 		$.each(emps,function(index,item){
// 			alert(item.empName);
// 		});
		$.each(emps,function(index,item){
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var empGenderTd = $("<td></td>").append(item.empGender=="male"?"男":"女");
			var empMailTd = $("<td></td>").append(item.empMail);
			var depNameTd = $("<td></td>").append(item.department.depName);
			/**
			<button class="btn btn-info btn-sm">
			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
			编辑</button>
			*/
			var editBtn= $("<button></button>").addClass("btn btn-info btn-sm")
							.append("<span></span>").addClass("glyphicon glyphicon-pencil")
							.append("编辑");
			var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
							.append("<span></span>").addClass("glyphicon glyphicon-trash")
							.append("删除");
			var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
					
			$("<tr></tr>").append(empIdTd)
						.append(empNameTd)
						.append(empGenderTd)
						.append(empMailTd)
						.append(depNameTd)
						.append(btn)
						.appendTo("#emp_table tbody");
		});
	}
	function build_page_info(result){
		$("#page_info").append("当前"+result.map.pageInfo.pageNum+"页","总"+result.map.pageInfo.pages+
				"页","总"+result.map.pageInfo.total+"条记录")
	}
	
	function build_page_nav(result){
		
	}
	</script>
</body>
</html>