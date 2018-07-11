<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    pageContext.setAttribute("ctx", request.getContextPath());
%>
<html>
    <head>
        <title>Title</title>
        <script src="${ctx}/static/js/jquery-1.11.3.min.js"></script>
        <link rel="stylesheet" href="${ctx}/static/layui/css/layui.css" media="all">
    </head>
    <body>
        <form class="layui-form" id="editForm">
            <div style="width:330px;float: left;">
                <input type="hidden" name="empId" value="${tblEmp.empId}"/>
                <div class="layui-form-item">
                    <label class="layui-form-label">empName</label>
                    <div class="layui-input-inline">
                        <input type="text" name="empName" value="${tblEmp.empName}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">email</label>
                    <div class="layui-input-inline">
                        <input type="text" name="email" value="${tblEmp.email}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">gender</label>
                    <div class="layui-input-block">
                        <input type="radio" name="gender" value="M" title="男" ${tblEmp.gender == 'M'?'checked':''}/>
                        <input type="radio" name="gender" value="F" title="女" ${tblEmp.gender == 'F'?'checked':''}/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">dept</label>
                    <div class="layui-input-inline">
                        <select id="dId" name="dId">
                            <c:forEach items="${tblDepts}" var="dept" varStatus="status">
                                <option value='${dept.deptId}' ${tblEmp.dId == dept.deptId?'selected':''}>${dept.deptName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <c:if test="${empty tblEmp}">
                            <button class="layui-btn" lay-submit lay-filter="addFilter">新增</button>
                        </c:if>
                        <c:if test="${not empty tblEmp}">
                            <button class="layui-btn" lay-submit lay-filter="editFilter">编辑</button>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="layui-upload" style="float: left;width:250px;">
                <button type="button" class="layui-btn layui-btn-normal" id="test8">选择文件</button>
                <%--<button type="button" class="layui-btn" id="test9">开始上传</button>--%>
                <div class="layui-upload-list">
                    <c:if test="${not empty tblEmp.tblEmpPicture.url}">
                        <img class="layui-upload-img" style="width: 250px;height: auto" id="ylimg" src="${ip}${tblEmp.tblEmpPicture.group}/${tblEmp.tblEmpPicture.url}"/>
                    </c:if>
                    <c:if test="${empty tblEmp.tblEmpPicture.url}">
                        <img class="layui-upload-img" style="width: 250px;height: auto" id="ylimg" src=""/>
                    </c:if>
                    <%--<p id="demoText"></p>--%><!-- 重传 -->
                </div>
            </div>
        </form>
        <script src="${ctx}/static/layui/layui.all.js" charset="utf-8"></script>
        <script type="text/javascript">
            var path = "${ctx}";
            layui.config({
                base: path + '/static/js/system/' //你存放新模块的目录，注意，不是layui的模块目录
            }).use('edit'); //加载入口
        </script>
    </body>
</html>
