define(["jquery", "easy-admin"], function ($, ea) {


    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'main.company/index',
        add_url: 'main.company/add',
        edit_url: 'main.company/edit',
        delete_url: 'main.company/delete',
        export_url: 'main.company/export',
        modify_url: 'main.company/modify',


    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,

                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'chinese_company_name', title: '中文公司名称'},
                    {field: 'english_company_name', title: '英文公司名称'},
                    {field: 'chinese_company_address', title: '公司地址'},
                    {field: 'english_company_address', title: '英文公司地址'},
                    {field: 'main_company_tax_number', title: '税号'},
                    {field: 'chinese_bank_information', title: '银行信息'},
                    {field: 'english_bank_information', title: '英文英文银行信息'},
                    {width: 250, title: '操作', templet: ea.table.tool},

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