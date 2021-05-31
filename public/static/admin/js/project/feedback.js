define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.feedback/index',
        add_url: 'project.feedback/add',
        edit_url: 'project.feedback/edit',
        delete_url: 'project.feedback/delete',
        export_url: 'project.feedback/export',
        modify_url: 'project.feedback/modify',
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
                    {field: 'write.username', title: '填表人'},
                    {field: 'fileaa.customer_file_code', title: '文件编号',},
                    {field: 'tr_upper_management', title: '翻译直属管理'},
                    {field: 'xd_upper_management', title: '校对直属管理'},
                    {field: 'yp_upper_management', title: '预排直属管理'},
                    {field: 'hp_upper_management', title: '后排直属管理'},
                    {field: 'tr', title: '翻译'},
                    {field: 'xd', title: '校对'},
                    {field: 'yp', title: '预排'},
                    {field: 'hp', title: '后排'},
                    {field: 'pa.username', title: '项目助理'},
                    {field: 'feedback', search: 'select', selectList: {"1":"Non","2":"Good","3":"Bad","4":"Other"}, title: '客户反馈'},
                    {field: 'feedback_time', title: '反馈时间'},
                    {field: 'adverse_ratio', title: '不良比率'},
                    {field: 'feedback_content', title: '反馈内容'},
                    {field: 'feedback_description', title: '事项及不良现象描述'},
                    {field: 'reason', title: '原因分析'},
                    {field: 'feedback_correction', title: '纠正措施'},
                    {field: 'feedback_evaluate', title: '客户评价'},
                    {field: 'feedback_advance', title: '后续更进'},
                    {field: 'create_time', title: '创建时间'},
                    {width: 250, title: '操作', templet: ea.table.tool},

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },

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