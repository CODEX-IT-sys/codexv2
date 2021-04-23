define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.description/index',
        add_url: 'project.description/add',
        edit_url: 'project.description/edit',
        delete_url: 'project.description/delete',
        export_url: 'project.description/export',
        modify_url: 'project.description/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},                    {field: 'id', title: 'id'},                    {field: 'file_id', title: '文件id', templet: ea.table.url},                    {field: 'comment_id', title: '评论id'},                    {field: 'translation_id', title: '翻译人员id'},                    {field: 'tr_start_time', title: '翻译开始时间'},                    {field: 'tr_end_time', title: '翻译结束时间'},                    {field: 'proofreader_id', title: '校对人员'},                    {field: 'pr_start_time', title: '校对开始时间'},                    {field: 'pr_end_time', title: '校对结束时间'},                    {field: 'before_ty_id', title: '预排人员'},                    {field: 'be_start_time', title: '预排开始时间'},                    {field: 'be_end_time', title: '预排结束时间'},                    {field: 'after_ty_id', title: '后排人员'},                    {field: 'after_start_time', title: '后排开始时间'},                    {field: 'after_end_time', title: '后排结束时间'},                    {field: 'status', title: '状态0待预排.1待翻译2.待校对3.待后版', templet: ea.table.switch},                    {field: 'repetition_rate95', title: 'repetition_rate95'},                    {field: 'repetition_rate100', title: 'repetition_rate100'},                    {field: 'repetition_rateall', title: '总重复率'},                    {field: 'deduction_number', title: '扣除字数'},                    {field: 'number_of_words_actual', title: '实际源语数量'},                    {field: 'final_delivery_time', title: '最终交付时间'},                    {field: 'create_time', title: 'create_time'},                    {width: 250, title: '操作', templet: ea.table.tool},
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