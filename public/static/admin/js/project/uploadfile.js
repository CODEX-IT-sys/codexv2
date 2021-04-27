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
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},                    {field: 'id', title: 'id'},                    {field: 'file_id', title: '项目id', templet: ea.table.url},                    {field: 'original_name', title: '文件名'},                    {field: 'url', title: '存储路劲'},                    {field: 'mime_type', title: '文件类型'},                    {field: 'remark', title: '备注', templet: ea.table.text},                    {field: 'upload_time', title: '上传时间'},                    {field: 'create_time', title: '创建时间'},                    {width: 250, title: '操作', templet: ea.table.tool},
                ]],
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