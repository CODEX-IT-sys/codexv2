define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.staffing/index',
        rc_url: 'project.staffing/rc',

    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'username', title: '姓名'},
                    {field: 'auth', title: '职位',search:false},
                    {width: 250, title: '操作', templet: ea.table.tool,
                        operat: [
                            [ {
                                text: '人员日程',
                                url: init.rc_url,
                                method: 'open',
                                auth: 'rc',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                           ]},
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
