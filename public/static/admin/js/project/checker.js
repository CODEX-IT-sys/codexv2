define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.checker/index',
        add_url: 'project.checker/add',
        edit_url: 'project.checker/edit',
        delete_url: 'project.checker/delete',
        export_url: 'project.checker/export',
        modify_url: 'project.checker/modify',
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
                    {field: 'fileaa.customer_file_code', title: '文件编号',},
                    {field: 'write.username', title: '填表人'},
                    {field: 'checker_id', title: '检查人'},
                    {field: 'tr_checker', search: 'select', selectList: {"1":"C","2":"NC"}, title: '翻译'},
                    {field: 'terminology', search: 'select', selectList: {"1":"C","2":"NC"}, title: '术语'},
                    {field: 'language_quality', search: 'select', selectList: {"1":"C","2":"NC"}, title: '语言品质'},
                    {field: 'proper_nouns', search: 'select', selectList: {"1":"C","2":"NC"}, title: '专有名词'},
                    {field: 'units_measurement', search: 'select', selectList: {"1":"C","2":"NC"}, title: '测量单位'},
                    {field: 'symbol', search: 'select', selectList: {"1":"C","2":"NC"}, title: '符号'},
                    {field: 'chart', search: 'select', selectList: {"1":"C","2":"NC"}, title: '图表'},
                    {field: 'abbreviation', search: 'select', selectList: {"1":"C","2":"NC"}, title: '缩写'},
                    {field: 'layout_format', search: 'select', selectList: {"1":"C","2":"NC"}, title: '布局格式'},
                    {field: 'other', search: 'select', selectList: {"1":"C","2":"NC"}, title: '其他'},
                    {field: 'existing_problem', search: 'select', selectList: {"1":"C","2":"NC"}, title: '现有问题'},
                    {field: 'correct_situation', search: 'select', selectList: {"1":"C","2":"NC"}, title: '纠正情况'},
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