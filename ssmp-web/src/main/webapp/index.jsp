<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>员工列表</title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<script src="${ctx}/static/js/jquery-1.11.3.min.js"></script>
		<link rel="stylesheet" href="${ctx}/static/layui/css/layui.css" media="all">
	</head>
	<body>
		<div class="layui-btn-group demoTable">
			<button class="layui-btn layui-btn-xs" data-method="add">新增</button>
			<button class="layui-btn layui-btn-xs" data-method="reload">刷新</button>
		</div>
		<table class="layui-hide" id="demoTable" lay-filter="demo"/>
		<script type="text/html" id="barDemo">
			<a class="layui-btn layui-btn-xs" lay-event="detail">查看</a>
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-xs" lay-event="del">删除</a>
		</script>

		<script src="${ctx}/static/layui/layui.all.js" charset="utf-8"></script>
		<script type="text/javascript">
            var path = "${ctx}";
            layui.config({
                base: path + '/static/js/system/' //你存放新模块的目录，注意，不是layui的模块目录
            }).use('index'); //加载入口
		</script>
	</body>
</html>