define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.schedule/index',
        add_url: 'project.schedule/add',
        edit_url: 'project.schedule/edit',
        delete_url: 'project.schedule/delete',
        export_url: 'project.schedule/export',
        modify_url: 'project.schedule/modify',
    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',
                    [{
                        text: '添加',
                        url: init.add_url + '?id=' + description_id,
                        method: 'open',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                    }],
                    'delete',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'write_id', title: '写入'},
                    {field: 'late_submission', search: 'select', selectList: {"1":"yes","0":"no"}, title: '是否延迟提交'},
                    {field: 'completion_page', title: '完成页码'},
                    {field: 'self_Inspection_status', search: 'select', selectList: {"1":"yes","0":"no"}, title: '自检'},
                    {field: 'start_time', title: '开始时间'},
                    {field: 'end_time', title: '结束时间'},
                    {field: 'actual_time', title: '实际用时'},
                    {field: 'degree_completion', title: '完成度'},
                    {field: 'work_date', title: '工作日期'},
                    {field: 'work_content', title: '工作内容'},
                    {field: 'update_main_library', search: 'select', selectList: {"1":"yes","2":"no","0":"N\/A"}, title: '会否更新主库'},
                    {field: 'terminology_submit', search: 'select', selectList: {"1":"yes","2":"no","0":"N\/A"}, title: '术语提交'},
                    {field: 'finalized_submit', search: 'select', selectList: {"1":"yes","2":"no","0":"N\/A"}, title: '是否转至定稿'},
                    {field: 'original_word_count', title: '原总字数'},
                    {field: 'chinese_word_count', title: '中文字数统计'},
                    {field: 'efficiency', title: '效率'},
                    {field: 'scedule_remark', title: '备注'},
                    {field: 'create_time', title: '创建时间'},
                    {width: 250, title: '操作', templet: ea.table.tool},

                ]],
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