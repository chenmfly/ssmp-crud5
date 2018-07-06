<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>员工列表</title>
		<%
			//以"/"开始不以"/"结束 
			pageContext.setAttribute("ctx", request.getContextPath());
		%>
		<!-- 
		web路径：
		不以/开始的相对路径，找资源，以当前资源的路径为基准，经常出问题。
		以/开始的绝对路径，找资源，以服务器的路径为标准(http://localhost:3306/)，需要加上项目名
			http://localhost:3306/crud
		 -->
		<script src="${ctx}/static/js/jquery-1.11.3.min.js"></script>
		<link href="${ctx}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
		<script src="${ctx}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	</head>
	<body>
		<!-- 员工修改模态框 -->
		<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">员工修改</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
						  <div class="form-group">
						    <label class="col-sm-2 control-label">empName</label>
						    <div class="col-sm-10">
						      <p class="form-control-static" id="empName_update_p" name="empName"></p>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">email</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="email_update_input" name="email" placeholder="email@164.com">
						      <span class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">gender</label>
						    <label class="radio-inline">
							  <input type="radio" name="gender" id="gender_update_input" value="M" checked="checked">男
							</label>
							<label class="radio-inline">
							  <input type="radio" name="gender" id="gender_update_input" value="F">女
							</label>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">deptName</label>
						    <div class="col-sm-4">
						    	<!-- 部门提交部门id即可 -->
							    <select class="form-control" name="dId" id="dept_update_select">
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
		<!-- 员工新增模态框 -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">员工添加</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
						  <div class="form-group">
						    <label class="col-sm-2 control-label">empName</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="empName_add_input" name="empName" placeholder="empName">
						      <span class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">email</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="email_add_input" name="email" placeholder="email@164.com">
						      <span class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">gender</label>
						    <label class="radio-inline">
							  <input type="radio" name="gender" id="gender_add_input" value="M" checked="checked">男
							</label>
							<label class="radio-inline">
							  <input type="radio" name="gender" id="gender_add_input" value="F">女
							</label>
						  </div>
						  <div class="form-group">
						    <label class="col-sm-2 control-label">deptName</label>
						    <div class="col-sm-4">
						    	<!-- 部门提交部门id即可 -->
							    <select class="form-control" name="dId" id="dept_and_select">
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
		
		
		
		<div class="container">
			<!-- 标题 -->
			<div class="row">
				<div class="col-md-12">
					<h1>SSMP_CRUD2</h1>
				</div>
			</div>
			<!-- 按钮 -->
			<div class="row">
				<div class="col-md-8 col-md-offset-8">
					<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
					<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
				</div>
			</div>
			<!-- 显示表格数据 -->
			<div class="row">
				<div class="col-md-12">
					<table class="table table-hover" id="emps_table">
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="check_all"/>
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
			<!-- 显示分页 -->
			<div class="row">
				<!-- 分页文字信息 -->
				<div class="col-md-6" id="page_info_area"></div>
				<!-- 分页条信息 -->
				<div class="col-md-6" id="page_nav_area"></div>
			</div>
		</div>
	</body>
</html>
<script type="text/javascript">
	var currentNum;

	//1. 页面加载完成之后，直接发送一个ajax请求，获取分页数据 
	$(function(){
		to_page(1);
	});
	
	function to_page(pn){
		$.ajax({
			url:"${ctx}/tblEmp/empsnew",
			type:"get",
			data:"current="+pn,
			success:function(data){
				//1. 解析并显示员工数据
				build_emps_table(data);
				//2. 解析并显示分页数据
				build_page_info(data);
				//3. 解析并显示分页条数据
				build_page_nav(data);
			},
			error:function(){
				alert("error");
			}
		});
	}
	
	function build_emps_table(result){
		//清空table
		$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.records;
		$.each(emps,function(index,item){
			var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
			var empIdTd = $("<td></td>").append(item.empId);
			var empNameTd = $("<td></td>").append(item.empName);
			var empGenderTd = $("<td></td>").append(item.gender=='M'?'男':'女');
			var empEmailTd = $("<td></td>").append(item.email);
			var empDeptNameTd = $("<td></td>").append(item.tblDept.deptName);
			/**
			<button class="btn btn-primary btn-sm">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				编辑
			</button>
			<button class="btn btn-danger btn-sm">
				<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				删除
			</button>
			*/
			var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").
				append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
			//增加一个自定义属性来表示当前行的Id
			editBtn.attr("edit-id",item.empId);
			var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").
				append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
			delBtn.attr("edit-id",item.empId);
			var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
			$("<tr></tr>").append(checkBoxTd).
				append(empIdTd).
				append(empNameTd).
				append(empGenderTd).
				append(empEmailTd).
				append(empDeptNameTd).
				append(btnTd).
				appendTo("#emps_table tbody");
			
		});
	}
	
	//返回导航列表
	function getPagination(pageInfo,size){
		var current = pageInfo.current;//当前页码
		var s1,s2;
		s1 = current - parseInt(size/2);
		s2 = s1 + size - 1; 
		if(s1<1){
			s1 = 1;
			s2 = size;
		}
		if(s2 > pageInfo.pages){
			s1 = pageInfo.pages - size + 1;
			s2 = pageInfo.pages;
		}
		var array = new Array();
		for(var i = s1;i <= s2;i++){
			array.push(i);
		}
		console.log(array);
		return array;
	}
	
	//解析显示分页信息
	function build_page_info(result){
		$("#page_info_area").empty();
		var msg = result.extend.pageInfo;
		$("#page_info_area").append("当前"+msg.current+"页，总"+msg.pages+"页，总"+msg.total+"条记录");
		currentNum = msg.current;
	}
	//解析显示分页条
	function build_page_nav(result){
		$("#page_nav_area").empty();
		var pageInfo = result.extend.pageInfo;
		
// 		var navigatepageNums = pageInfo.navigatepageNums; 
		var navigatepageNums = getPagination(pageInfo,5); 
		
		//page_nav_area
		var ul = $("<ul></ul>").addClass("pagination");
		
		//构建元素
		var filePageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if(pageInfo.current == 1){
			filePageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			//为元素添加分页事件
			filePageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(pageInfo.current-1)
			});
		}
		
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
		if(pageInfo.current == pageInfo.pages){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			nextPageLi.click(function(){
				to_page(pageInfo.current+1);
			});
			lastPageLi.click(function(){
				to_page(pageInfo.pages);
			});
		}
		
		//添加首页和前一页的提示
		ul.append(filePageLi).append(prePageLi);
		//1,2,3遍历给ul添加页码提示
		$.each(navigatepageNums,function(index,item){
			
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if(pageInfo.current == item){
				numLi.addClass("active");
			}
			numLi.click(function(){
				to_page(item);
			});
			ul.append(numLi);
		});
		//添加下一页和尾页的提示
		ul.append(nextPageLi).append(lastPageLi);
		
		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav_area");
	}
	
	function reset_form(ele){
		//清空表单数据
		$(ele)[0].reset();
		//清空表单样式
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
	}
	
	//新增模态框 
	$("#emp_add_modal_btn").click(function(){
		//表单重置（数据+样式）
		reset_form("#empAddModal form");
		
		//ajax请求部门信息
		getDepts("#dept_and_select");
		
		//弹出模态框 
		$("#empAddModal").modal({
			backdrop:"static"
		});
	});
	
	//查出所有部门信息显示下拉列表
	function getDepts(ele){
		//清空之前下拉列表内容 
		$(ele).empty();
		$.ajax({
			url:"${ctx}/tblDept/depts",
			type:"GET",
			success:function(data){
				//$("#dept_and_select").append("");
				$.each(data.extend.depts,function(){
					var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
					optionEle.appendTo(ele)
				})
			},
			error:function(){
				
			}
		});
	}
	
	//校验用户名是否可用
	$("#empName_add_input").change(function(){
		var empName = this.value;
		$.ajax({
			url:"${ctx}/tblEmp/checkuser",
			data:{"empName":empName},
			type:"POST",
			success:function(data){
				if(data.code==100){
					show_validate_msg("#empName_add_input","success","前端提示：用户名可用");
					$("#emp_save_btn").attr("ajax-va","success");
				}else{
					show_validate_msg("#empName_add_input","error",data.extend.va_msg);
					$("#emp_save_btn").attr("ajax-va","error");
				}
			},
			error:function(){
				alert("error")
			}
		});
	});
	
	
	//保存
	$("#emp_save_btn").click(function(){
		//1. 先检验
		if(!validate_add_form()){
			return;
		}
		if($(this).attr("ajax-va")=="error"){
			return;
		}
		//2. 保存
		$.ajax({
			url:"${ctx}/tblEmp/emp",
			type:"POST",
			data:$("#empAddModal form").serialize(),
			success:function(data){
				if(data.code==100){
					//1. 关闭模态框 
					$("#empAddModal").modal("hide");
					//2. 来到最后一页
					to_page(9999);
				}else{
					//显示失败信息
					//有哪个字段的错误信息就显示哪个字段
					if(undefined != data.extend.errorField.email){
						//显示邮箱错误信息
						show_validate_msg("#email_add_input","error",data.extend.errorField.email);
					}
					if(undefined != data.extend.errorField.empName){
						show_validate_msg("#empName_add_input","error",data.extend.errorField.empName);
					}
				}
			},
			error:function(data){
				
			}
		});
	});
	
	//验证表单 
	function validate_add_form(){
		var empName = $("#empName_add_input").val();
		var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
		if(!regName.test(empName)){
			show_validate_msg("#empName_add_input","error","前端表单验证：6-16位英文或者2-5位中文");
			return false;
		}else{
			show_validate_msg("#empName_add_input","success","");
		};
		var empEmail = $("#email_add_input").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(empEmail)){
			show_validate_msg("#email_add_input","error","前端表单验证：输入正确的邮箱格式");
			return false;
		}else{
			show_validate_msg("#email_add_input","success","");
		}
		return true;
	}
	
	//显示 提示信息
	function show_validate_msg(ele,status,msg){
		//清空之前的校验Class
		$(ele).parent().removeClass("has-success").removeClass("has-error");
		$(ele).next("span").text("");
		if(status=="success"){
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text("正确");
		}else if(status=="error"){
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);			
		}
	}
	
	//因为$().click()...创建按钮之前就绑定，所以绑定不上，换成on
	$(document).on("click",".edit_btn",function(){
		//1.获取部门信息
		getDepts("#dept_update_select")
		//2.获取员工信息
		getEmp($(this).attr("edit-id"));
		//3.把员工的id传递给模态框的更新按钮
		$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
		$("#empUpdateModal").modal({
			backdrop:"static"
		});
	})
	
	function getEmp(id){
		$.ajax({
			url:"${ctx}/tblEmp/emp/"+id,
			type:"GET",
			success:function(data){
				var empData = data.extend.tblEmp;
				$("#empName_update_p").text(empData.empName);
				$("#email_update_input").val(empData.email);
				$("#empUpdateModal input[name=gender]").val([empData.gender]);
				$("#empUpdateModal select").val([empData.dId]);
			},
			error:function(){
				alert("error")
			}
		});
	}
	
	//更新员工信息
	$("#emp_update_btn").click(function(){
		//验证邮箱信息
		var empEmail = $("#email_update_input").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(empEmail)){
			show_validate_msg("#email_update_input","error","前端提示：输入正确Email");
			return false;
		}else{
			show_validate_msg("#email_update_input","success","");
		}
		//发送ajax请求更新信息
		$.ajax({
			url:"${ctx}/tblEmp/emp/"+$(this).attr("edit-id"),
			type:"PUT",
			data:$("#empUpdateModal form").serialize(),
			success:function(data){
// 				alert(data.msg);
				//1. 关闭模态框 
				$("#empUpdateModal").modal("hide");
				//2. 来到最后一页
				to_page(currentNum);
			},
			error:function(){
				alert("error")
			}
			
		});
	});
	
	$(document).on("click",".delete_btn",function(){
		//1. 弹出是否确认删除对话框
		var empName = $(this).parents("tr").find("td:eq(2)").text() 
		var empId = $(this).attr("edit-id");
		if(confirm("确认删除【"+empName+"】吗?")){
			$.ajax({
				url:"${ctx}/tblEmp/emp/"+empId,
				type:"DELETE",
				success:function(data){
					alert(data.msg);
					to_page(currentNum);
				},
				error:function(){
					alert("error");
				}
			});
		}
	})
	
	//全选/全不选功能 
	$("#check_all").click(function(){
// 		alert($(this).prop("checked"));
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	
	$(document).on("click",".check_item",function(){
		//判断当前选中的元素是否是5个
		var flag = $(".check_item:checked").length==$(".check_item").length;
		$("#check_all").prop("checked",flag);
	});
	
	//点击全部清除，就批量清除
	$("#emp_delete_all_btn").click(function(){
		var empNames = "";//名称 
		var del_idstr = "";//Id
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		//去除empNames，del_idstr多余的","/"-"
		empNames = empNames.substring(0,empNames.length-1);
		del_idstr = del_idstr.substring(0,del_idstr.length-1);
		
		if(confirm("确认删除【"+empNames+"】员工吗")){
			$.ajax({
				url:"${ctx}/tblEmp/emp/"+del_idstr,
				type:"DELETE",
				success:function(data){
					alert("删除成功");
					to_page(currentNum);
				},
				error:function(){
					
				}
			});
		}
	});
</script>