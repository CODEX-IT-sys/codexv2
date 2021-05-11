define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.basicfile/index',
        add_url: 'project.basicfile/add',
        edit_url: 'project.basicfile/edit',
        delete_url: 'project.basicfile/delete',
        export_url: 'project.basicfile/export',
        modify_url: 'project.basicfile/modify',
        fileup_url: 'project.basicfile/fileup',
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
                        url: init.fileup_url + '?id=' + basic_id,
                        method: 'open',
                        auth: 'fileup',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    'delete',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {field: 'label.content', title: '文件类型'},
                    {field: 'original_name', title: '文件名'},
                    {field: 'url', title: '存储地址'},
                    {field: 'mime_type', title: '文件类型'},

                    // {field: 'remark', title: '备注', templet: ea.table.text},
                    {field: 'upload_time', title: '上传时间'},
                    {field: 'create_time', title: '创建时间',search: false},
                    {field: 'download', title: '下载',toolbar:"#barDemo" ,search:false},
                    {width: 250, title: '操作', templet: ea.table.tool,operat: [
                            'delete']
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                // , autoColumnWidth: {
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