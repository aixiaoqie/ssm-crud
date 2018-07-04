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
	<!--===============模态框======================-->
	<!-- 员工修改Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">修改员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="emp_update_form">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			       <p class="form-control-static" id="empName_update_static"></p>
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="empMail_add_input" class="col-sm-2 control-label">empMail</label>
			    <div class="col-sm-10">
			      <input type="text" name="empMail" class="form-control" id="empMail_update_input" placeholder="empMail@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			   <label for="empName_add_input" class="col-sm-2 control-label">empGender</label>
			   	<div class="col-sm-10">
				  <label class="radio-inline">
					  <input type="radio" name="empGender" id="empGender_update_input1" value="male" checked> 男
				  </label>
				  <label class="radio-inline">
					  <input type="radio" name="empGender" id="empGender_update_input2" value="female"> 女
				  </label>
				 </div>
			  </div>
			  <!-- 部门的提交 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-6">
			    	<select class="form-control" name="dId" id="dept_update_select"></select>					
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="update_emp_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<!-- 员工添加Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" b="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="emp_add_form">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="empMail_add_input" class="col-sm-2 control-label">empMail</label>
			    <div class="col-sm-10">
			      <input type="text" name="empMail" class="form-control" id="empMail_add_input" placeholder="empMail@qq.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			   <label for="empName_add_input" class="col-sm-2 control-label">empGender</label>
			   	<div class="col-sm-10">
				  <label class="radio-inline">
					  <input type="radio" name="empGender" id="empGender_add_input1" value="male" checked> 男
				  </label>
				  <label class="radio-inline">
					  <input type="radio" name="empGender" id="empGender_add_input2" value="female"> 女
				  </label>
				 </div>
			  </div>
			  <!-- 部门的提交 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-6">
			    	<select class="form-control" name="dId" id="dept_add_select"></select>					
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="save_emp_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
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
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_btn">删除</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-hover">
					<tr>
						<th>
							<input type="checkbox" id="check_all">
						</th>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>empEmail</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
					<tr>
						<th>
							<input type="checkbox" class="check_item">
						</th>
						<th>${emp.empId }</th>
						<th>${emp.empName }</th>
						<th>${emp.empGender=="male"?"男":"女" }</th>
						<th>${emp.empMail }</th>
						<th>${emp.department.depName }</th>
						<th>
							<button class="btn btn-info btn-sm" id="edit_emp_btn" edit_btn_id="${emp.empId }">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
							编辑</button>
							<button class="btn btn-danger btn-sm" id="delete_emp_btn" delete_btn_id="${emp.empId }">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
							删除</button>
						</th>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum}页，总${pageInfo.pages }页，总${pageInfo.total }条记录
			</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH }/emps?pageNo=1">首页</a></li>
				  	<c:if test="${pageInfo.hasPreviousPage }">
				  		<li>
				      	<a href="${APP_PATH }/emps?pageNo=${pageInfo.pageNum-1}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				    	</a>
				    	</li>
				  	</c:if>
			
				    <c:forEach items="${pageInfo.navigatepageNums }" var="navi_Page">
				    	<c:if test="${pageInfo.pageNum == navi_Page }">
				    		<li class="active"><a href="#">${navi_Page }</a></li>
				    	</c:if>
				    	<c:if test="${pageInfo.pageNum != navi_Page }">
				    		<li><a href="${APP_PATH }/emps?pageNo=${navi_Page }">${navi_Page }</a></li>
				    	</c:if>
				    </c:forEach>
				    <c:if test="${pageInfo.hasNextPage }">
				    	<li>
				      		<a href="${APP_PATH }/emps?pageNo=${pageInfo.pageNum+1}" aria-label="Next">
				        	<span aria-hidden="true">&raquo;</span>
				      		</a>
				    	</li>
				    </c:if>
				    <li><a href="${APP_PATH }/emps?pageNo=${pageInfo.pages}">末页</a></li>
				  </ul>
				</nav>	
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		//重置表单状态
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		$("#emp_add_btn").click(function () {
			//对表单内容重置
			//$("#emp_add_form")[0].reset();
			reset_form("#emp_add_form");
			//查出部门信息
			getDepts("#dept_add_select");
			//弹出模块框
			$('#empAddModal').modal({
				backdrop:"static"
			});
		});
		//查出所有部门信息
		function getDepts(ele){
			//清空下拉列表的数据
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//显示部门信息 在下拉列表中
					//$("#dept_add_select").append("<option></option>")
					$.each(result.map.deptList,function(){
						var optionDept = $("<option></option>").append(this.depName).attr("value",this.depId);
						optionDept.appendTo(ele);
					});					
				}
			});
		}
		// 模态框保存员工信息
		$("#save_emp_btn").click(function(){
			//对要提供的数据进行前端校验|
			if(!validate_add_form()){
				return false;
			}
			//判断ajax用户名校验 是否成功
			if($(this).attr("empName_validate")=="error"){
				return false; 
			}
		    //发送ajax请求
			$.ajax({
				url:"${APP_PATH}/emps",
				type:"POST",
				data:$("#emp_add_form").serialize(),
				success:function(result){
					if(result.code == 100){
						alert(result.msg);
						//1.员工保存成功 关闭模态框
						$('#empAddModal').modal('hide');
					}else{
						//显示失败信息
						//console.log(result);
						if(undefined != result.map.errorFields.empMail){
							//显示邮箱的错误信息
							show_validate_msg("#empMail_add_input","error",result.map.errorFields.empMail);
						}
						if(undefined != result.map.errorFields.empName){
							//显示empName的错误信息
							show_validate_msg("#empName_add_input","error",result.map.errorFields.empName);
						}
// 						alert(result.map.errorFields.empMail);
// 						alert(result.map.errorFields.empName);
					}		
					//2.最后一页显示
					
				}
			});
		});
		//校验用户提交的模态框信息
		function validate_add_form(){
			//对用户名校验
			var empNameVal = $("#empName_add_input").val();
			var empNameRel = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			//alert(empNameRel.test(empNameVal));
			if(!empNameRel.test(empNameVal)){//校验失败 提示 用户名信息
				//alert("用户名可以是5-16位英文或2-5位的中文");
				show_validate_msg("#empName_add_input","error","用户名可以是5-16位英文或2-5位的中文");
				/*$("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名可以是5-16位英文或2-5位的中文");*/
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
				/*$("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text("");*/
			}
			//检验邮箱信息
			var empMailVal = $("#empMail_add_input").val();
			var empMailRel = /^([a-z0-9_\.-]+)@([a-z\.-]+)\.([a-z\.]{2,6})$/ ;
			if(!empMailRel.test(empMailVal)){
				//alert("邮箱格式不正确");
				show_validate_msg("#empMail_add_input","error","邮箱格式不正确");
				/*$("#empMail_add_input").parent().addClass("has-error");
				$("#empMail_add_input").next("span").text("邮箱格式不正确");*/
				return false;
			}else{
				show_validate_msg("#empMail_add_input","success","");
				/*$("#empMail_add_input").parent().addClass("has-success");
				$("#empMail_add_input").next("span").text("");*/
			}
			return true;
		}
		function show_validate_msg(ele,status,msg){
			//清除当前类的检验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
// 		//对用户名的重复性校验
	    $("#empName_add_input").change(function(){
	    	var empName = this.value;
	    	empName = $.trim(empName);
	    	if(empName != ""){
	    		$.ajax({
		    		url:"${APP_PATH}/checkEmp",
		    		data:"empName="+empName,
		    		type:"GET",
		    		success:function(result){
		    			if(result.code == 100){
		    				show_validate_msg("#empName_add_input","success","用户名可用");
		    				$("#save_emp_btn").attr("empName_validate","success");
		    			}else{
		    				show_validate_msg("#empName_add_input","error",result.map.emp_vali);
		    				$("#save_emp_btn").attr("empName_validate","error");
		    			}
		    		}
		    	});
	    	}
	    });	
	    //为编辑按钮添加点击事件
		$(document).on("click","#edit_emp_btn",function(){
			//1.查询部门信息
			getDepts("#empUpdateModal select");
			//2.查询员工信息empName	
			get_emp_name($(this).attr("edit_btn_id"));
			//3.为模态框的更新按钮添加自定义属性
			$("#update_emp_btn").attr("edit_btn_id",$(this).attr("edit_btn_id"));
			
			//弹出模态框
			$('#empUpdateModal').modal({
				backdrop:"static"
			});
		});
		
	    function get_emp_name(id){
	    	$.ajax({
	    		url:"${APP_PATH}/emp/"+id,
	    		type:"GET",
	    		success:function(result){
	    			//console.log(result);
	    			var empEle = result.map.emp;
	    			$("#empName_update_static").text(empEle.empName);
	    			$("#empMail_update_input").val(empEle.empMail);
	    			$("#empUpdateModal input[name=empGender]").val([empEle.empGender]);
	    			$("#empUpdateModal select").val([empEle.dId]);
	    		}
	    	});
	    }
	    //点击更新 ，修改员工信息
	    $("#update_emp_btn").click(function(){
	    	//校验邮箱
	    	var empMailVal = $("#empMail_update_input").val();
			var empMailRel = /^([a-z0-9_\.-]+)@([a-z\.-]+)\.([a-z\.]{2,6})$/ ;
			if(!empMailRel.test(empMailVal)){
				show_validate_msg("#empMail_update_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#empMail_update_input","success","");
			}
			//发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emps/"+$(this).attr("edit_btn_id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					alert(result.msg);
					$('#empUpdateModal').modal('hide');
				}
			});
	    });
	    //删除员工信息
	    $(document).on("click","#delete_emp_btn",function(){
	    	var empName = $(this).parents("tr").find("th:eq(2)").text();
	    	if(confirm("确认删除【"+empName+"】吗？")){
	    		$.ajax({
	    			url:"${APP_PATH}/emps/"+$(this).attr("delete_btn_id"),
	    			type:"DELETE",
	    			success:(function(result){
	    				alert(result.msg);
	    			})
	    		});
	    	}
	    	
	    });
	    $("#check_all").click(function(){
	    	$(".check_item").prop("checked",$(this).prop("checked"));
	    });
	    $(document).on("click",".check_item",function(){
	    	var flag = $(".check_item:checked").length==$(".check_item").length;
	    	$("#check_all").prop("checked",flag);
	    });
	    //批量删除
	    $("#emp_delete_btn").click(function(){
	    	//$(".check_item:checked")
	    	var empNames = "";
	    	var del_batch_id = "";
	    	$.each($(".check_item:checked"),function(){
	    		empNames += $(this).parents("tr").find("th:eq(2)").text()+",";	
	    		del_batch_id += $(this).parents("tr").find("th:eq(1)").text()+"-";
	    	});
	    	empNames = empNames.substring(0,empNames.length-1);
	    	del_batch_id = del_batch_id.substring(0,del_batch_id.length-1);
	    	if(confirm("确认删除【"+empNames+"】")){
	    		$.ajax({
	    			url:"${APP_PATH}/emps/"+del_batch_id,
	    			type:"DELETE",
	    			success:function(result){
	    				alert(result.msg);
	    			}
	    		});
	    	}
	    });
	</script>
</body>
</html>