define(["jquery", "easy-admin",], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.quotation/index',
        add_url: 'customer.quotation/add',
        edit_url: 'customer.quotation/edit',
        delete_url: 'customer.quotation/delete',
        export_url: 'customer.quotation/export',
        modify_url: 'customer.quotation/modify',
        print_url: 'customer.quotation/print_view',
    };
    var soulTable = layui.soulTable;
    var Controller = {
        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'quotation_code', title: '报价单编码'},
                    {field: 'customer_id', title: '客户id'},
                    {field: 'contract_id', title: '合同id'},
                    {field: 'write_id', title: '写入人id'},
                    {field: 'tax', title: '税额'},
                    {field: 'quotation_amount', title: '报价金额'},
                    {field: 'create_time', title: '创建时间'},
                    {
                        width: 250, title: '操作', templet: ea.table.tool,fixed:"right",
                        operat: [
                            [{
                                text: '打印预览',
                                url: init.print_url,
                                method: 'open',
                                field: 'id',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                            'delete', 'edit']
                    },

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });
            /**
             * 查看公告信息
             **/

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