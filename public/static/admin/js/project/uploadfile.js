define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.uploadfile/index',
        add_url: 'project.uploadfile/add',
        edit_url: 'project.uploadfile/edit',
        delete_url: 'project.uploadfile/delete',
        export_url: 'project.uploadfile/export',
        modify_url: 'project.uploadfile/modify',
        down_url: 'project.uploadfile/down',
        uploadfile_url: 'project.uploadfile/uploadfile',
    };

var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh',
                    [{
                        text: '添加',
                        url: init.uploadfile_url,
                        method: 'open',
                        auth: 'uploadfile',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    'delete'],
                cols: [[
                    {type: 'checkbox'},
                    // {field: 'id', title: 'id',search:false,templet: '<div><a href="/admin/project.uploadfile/down?id={{d.id}}" class="layui-table-link">下载</a></div>'},
                    {field: 'id', title: 'id',search:false},

                    {field: 'label.content', title: '文件标签' },
                    {field: 'original_name', title: '文件名',},
                    // {field: 'url', title: '存储路',},
                    {field: 'mime_type', title: '文件类型'},
                    {field: 'remark', title: '备注', templet: ea.table.text},
                    {field: 'upload_time', title: '上传时间',},
                    {field: 'create_time', title: '创建时间',search:false},
                    {field: 'download', title: '下载',toolbar:"#barDemo",search:false},
                    {width: 250, title: '操作', templet: ea.table.tool,
                        operat: [
                            'delete']},

                ]],
                // autoColumnWidth: {
                //     init: true
                // },

                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });



            ea.listen();
        },
        add: function () {
            ea.listen();
        },
        edit: function () {
            ea.listen();
        },
    };
    return Controller;
});

