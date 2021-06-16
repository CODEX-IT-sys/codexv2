define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.basic/index',
        add_url: 'project.basic/add',
        edit_url: 'project.basic/edit',
        delete_url: 'project.basic/delete',
        export_url: 'project.basic/export',
        modify_url: 'project.basic/modify',
        fileup_url: 'project.basicfile/index',
    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh',  'delete','add'],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'project_name', title: '项目名称',},
                    {field: 'principal_id', title: '项目负责人',search:'false'},
                    {field: 'project_requirements', title: '项目客户要求'},
                    {field: 'project_reference_file', title: '项目客户参考文件'},
                    {field: 'project_reference_file_internal', title: '内部参考文件'},
                    {field: 'project_memory_reference', title: '参考记忆库'},
                    {field: 'project_memory_update', title: '更新记忆库'},
                    {field: 'terminology', title: '参考术语库'},
                    {field: 'project_remark', title: '备注'},
                    {field: 'create_time', title: '创建时间',search:'false'},
                    {width: 250, title: '操作', templet: ea.table.tool,
                        operat: [
                            [ {
                                text: '项目文件',
                                url: init.fileup_url,
                                method: 'open',
                                auth: 'fileup',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                            'edit','delete']},
                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
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