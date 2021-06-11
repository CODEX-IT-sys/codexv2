define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'repoat.xdpg/index',
        add_url: 'repoat.xdpg/add',
        edit_url: 'repoat.xdpg/edit',
        delete_url: 'repoat.xdpg/delete',
        export_url: 'repoat.xdpg/export',
        modify_url: 'repoat.xdpg/modify',
    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                 overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh', 'delete','add'],

                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'description.file_name_project', title: '文件名称'},
                    {field: 'description.file_code_project', title: '文件编号'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {field: 'page_numbers', title: '抽取页码'},
                    {field: 'mistake_tr', title: '严重误译'},
                    {field: 'expression', title: '表述不恰当'},
                    {field: 'term', title: '术语错误'},
                    {field: 'result', title: '评估结果'},
                    {field: 'xdpg_remark', title: '备注'},
                    {field: 'xdpg_create_time', title: '创建时间'},

                    {width: 250, title: '操作', templet: ea.table.tool},

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                },
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                , autoColumnWidth: {
                    init: true
                },
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