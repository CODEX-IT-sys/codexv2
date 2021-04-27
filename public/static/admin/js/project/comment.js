define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.comment/index',
        add_url: 'project.comment/add',
        edit_url: 'project.comment/edit',
        delete_url: 'project.comment/delete',
        export_url: 'project.comment/export',
        modify_url: 'project.comment/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},                    {field: 'id', title: 'id'},                    {field: 'description_id', title: '描述id'},                    {field: 'user_id', title: '用户id'},                    {field: 'title', title: '主题'},                    {field: 'mentioned_id', title: '提到的人'},                    {field: 'create_time', title: 'create_time'},                    {width: 250, title: '操作', templet: ea.table.tool},
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