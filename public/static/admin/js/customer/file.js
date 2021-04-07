define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.file/index',
        add_url: 'customer.file/add',
        edit_url: 'customer.file/edit',
        delete_url: 'customer.file/delete',
        export_url: 'customer.file/export',
        modify_url: 'customer.file/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},                    {field: 'id', title: 'id'},                    {field: 'demand_id', title: '来稿需求id'},                    {field: 'file_name', title: '文件名称', templet: ea.table.url},                    {field: 'page', title: '文件页数'},                    {field: 'number_of_words', title: '源语数量'},                    {field: 'file_type', title: '文件类型'},                    {field: 'service', title: '服务'},                    {field: 'language', title: '语种'},                    {field: 'unit_price', title: '单价'},                    {field: 'unit', title: '单位'},                    {field: 'quotation_number', title: '报价数量'},                    {field: 'tax_rate', title: '税率'},                    {field: 'vat', title: '增值税'},                    {field: 'quotation_price', title: '报价金额'},                    {field: 'customer_submit_date', title: '客户期望提交日期'},                    {field: 'customer_file_request', title: '客户要求'},                    {field: 'customer_file_reference', title: '客户参考文件'},                    {field: 'customer_file_remark', title: '客户参考文件备注'},                    {field: 'create_time', title: '创建时间'},                    {width: 250, title: '操作', templet: ea.table.tool},
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