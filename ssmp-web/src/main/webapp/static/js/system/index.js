var tableIns;
layui.use(['table','laypage'], function(){
    var table = layui.table;
    tableIns = table.render({
        elem: '#demoTable'
        ,url:path + '/tblEmp/empsnew'
        ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
        ,request: {
            pageName: 'current' //页码的参数名称，默认：page
            ,limitName: 'size' //每页数据量的参数名，默认：limit
        }
        ,cols: [[
            {field:'empId', width:'15%', title: 'ID', sort: true}
            ,{field:'empName', width:'15%', title: '用户名'}
            ,{field:'gender', width:'15%', title: '性别', sort: true}
            ,{field:'email', width:'15%', title: '邮箱'}
            ,{field:'dId', width:'15%', title: '部门'}
            ,{field:'opt', width:'25%', title: '操作', toolbar:"#barDemo"}
        ]]
        ,page:{
            //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
            layout: ['first', 'prev', 'page', 'next', 'last', 'count', 'skip'] //自定义分页布局
            ,curr: 1 //设定初始在第 5 页
            ,groups: 5 //只显示 1 个连续页码
            ,first: '首页'
            ,last: '尾页'
        }
    });

    //监听工具条
    table.on('tool(demo)', function(obj){
        var data = obj.data;
        if(obj.event === 'edit'){
            edit(data.empId);
        } else if(obj.event === 'del'){
            layer.confirm('真的删除行么', function(index){
                obj.del();
                layer.close(index);
            });
        }
    });

    var $ = layui.$, active = {
        add: function() { //获取选中数据
            add();
        },
        reload: function(){
            reload();
        }
    };
    $('.demoTable .layui-btn').on('click', function(){
        var method = $(this).data('method');
        active[method] ? active[method].call(this) : '';
    });
});
function add(){
    layer.open({
        type: 2
        ,title: true
        ,closeBtn: 1
        ,maxmin:false
        ,area: ['800px', '400px']
        ,shade: 0.2
        ,id: 'LAY_layuiprodetail' //设定一个id，防止重复弹出
        ,moveType: 1 //拖拽模式，0或者1
        ,content:path + "/tblEmp/toAdd"
    });
}
function edit(id){
    layer.open({
        type: 2
        ,title: true
        ,closeBtn: 1
        ,maxmin:false
        ,area: ['800px', '400px']
        ,shade: 0.2
        ,id: 'LAY_layuiprodetail' //设定一个id，防止重复弹出
        ,moveType: 1 //拖拽模式，0或者1
        ,content:path + "/tblEmp/emp/" + id
    });
}
function reload(){
    tableIns.reload({
        /*where: { //设定异步数据接口的额外参数，任意设
            aaaaaa: 'xxx'
            ,bbb: 'yyy'
            //…
        },*/
        page: {
            curr: 1 //重新从第 1 页开始
        }
    });
}