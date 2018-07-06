layui.use(['form','upload'], function(){
    var form = layui.form,
        upload = layui.upload;
    //监听提交
    form.on('submit(addFilter)', function(data){
        submitAdd(data);
        return false;
    });
    form.on('submit(editFilter)', function(data){
        submitAdd(data);
        //submitEdit(data.field);
        return false;
    });
    //选完文件后不自动上传
    var uploadInst = upload.render({
        elem: '#test8'
        ,url: path + '/tblEmpPicture/upload'
        ,method: 'POST'
        ,accept: 'images'
        ,auto: false
        //,multiple: true
        //,bindAction: '#test9' //点击按钮开始上传
        ,choose: function (obj) {
            //预读本地文件示例，不支持ie8
            obj.preview(function(index, file, result){
                $('#ylimg').attr('src', result); //图片链接（base64）
            });
        }
        ,done: function(res){
            console.log(res)
        }
        ,error: function(){
            //演示失败状态，并实现重传
            var demoText = $('#demoText');
            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
            demoText.find('.demo-reload').on('click', function(){
                uploadInst.upload();
            });
        }
    });
    form.render();
});
function submitAdd(data){
    var formData = new FormData($("#editForm")[0]);
    $.ajax({
        cache:true,
        url:path + "/tblEmp/add",
        type:'post',
        data:formData,
        dataType:'json',
        contentType:false,//jax 中 contentType 设置为 false 是为了避免 JQuery 对其操作，从而失去分界符，而使服务器不能正常解析文件
        processData:false,//当设置为true的时候,jquery ajax 提交的时候不会序列化 data，而是直接使用data
        success:function(msg){
            if(msg.code==100){
                layer.msg('插入成功', {time: 2000}, function(){
                    closeWin();
                    window.parent.reload();//访问父页面方法
                });
            }else if(msg.code==200){
                layer.msg(JSON.stringify(msg.extend.errorField));
            }
        }
    })
    /*$.ajax({
        url:path + "/tblEmp/add",
        type:'post',
        data:data.field,
        dataType:'json',
        success:function(msg){
            if(msg.code==100){
                layer.msg('插入成功', {time: 2000}, function(){
                    closeWin();
                    window.parent.reload();//访问父页面方法
                });
            }else if(msg.code==200){
                layer.msg(JSON.stringify(msg.extend.errorField));
            }
        }
    })*/
}
function submitEdit(data){
    $.ajax({
        url: path + "/tblEmp/emp/" + data.empId,
        type: 'put',
        data: data,
        dataType: 'json',
        success: function (msg) {
            if (msg.code == 100) {
                layer.msg('修改成功', {time: 2000}, function () {
                    closeWin();
                    window.parent.reload();//访问父页面方法
                });
            } else if (msg.code == 200) {
                layer.msg(JSON.stringify(msg.extend.errorField));
            }
        }
    })
}
function closeWin(){
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index); //再执行关闭
}