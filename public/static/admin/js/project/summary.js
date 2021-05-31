define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.summary/index',
        add_url: 'project.summary/add',
        edit_url: 'project.summary/edit',
        delete_url: 'project.summary/delete',
        export_url: 'project.summary/export',
        modify_url: 'project.summary/modify',
    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                 ,even: true, //开启隔行背景
                toolbar: ['refresh','add','delete'],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'basic.project_name', title: '基本信息'},
                    {field: 'Involved_products', title: '涉及产品',},
                    {field: 'language', title: '涉及产品',},
                    {field: 'document_overview', title: '文件概览'},
                    {field: 'xd_feedback', title: '校对反馈'},
                    {field: 'expression_accumulation', title: '表达积累'},
                    {field: 'project_summary', title: '项目总结'},
                    {field: 'write.username', title: '填表人'},
                    {field: 'create_time', title: '创建时间'},
                    {width: 250, title: '操作', templet: ea.table.tool},

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