layui.use(['form', 'layedit', 'laydate', 'upload'], function () {
    let form = layui.form,
        layedit = layui.layedit,
        laydate = layui.laydate,
        upload = layui.upload;

    //指定允许上传的文件类型
    upload.render({
        elem: '#test3',
        url: '/upload/',
        accept: 'file', //普通文件
        done: function (res) {
            console.log(res);
        }
    });

    //数据表格全选
    form.on('checkbox(layTableAllChoose)', function (data) {
        let child = $(':checkbox[name!="all"]');
        child.each(function (index, item) {
            item.checked = data.elem.checked;
        });
        form.render('checkbox');
    });

    //文本编辑器
    layedit.build('demo'); //建立编辑器

    //日期范围
    lay('.beDate').each(function () {
        laydate.render({
            elem: this
            , trigger: 'click'
            , range: true
            , theme: '#11aa60'
            , position: 'fixed'
        });
    });
});