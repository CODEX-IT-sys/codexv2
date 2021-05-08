define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.message/index',
        add_url: 'project.message/add',
        edit_url: 'project.message/edit',
        delete_url: 'project.message/delete',
        export_url: 'project.message/export',
        modify_url: 'project.message/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},                    {field: 'id', title: 'id'},                    {field: 'write_id', title: '发信人'},                    {field: 'addressee_id', title: '收件人id'},                    {field: 'topic', title: '主题'},                    {field: 'message_content', title: '消息内容'},                    {field: 'link', title: 'link'},                    {field: 'create_time', title: '创建时间'},                    {width: 250, title: '操作', templet: ea.table.tool},
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