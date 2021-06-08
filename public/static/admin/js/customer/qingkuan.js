define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.qingkuan/index',
        add_url: 'customer.qingkuan/add',
        edit_url: 'customer.qingkuan/edit',
        delete_url: 'customer.qingkuan/delete',
        export_url: 'customer.qingkuan/export',
        modify_url: 'customer.qingkuan/modify',
        print_url: 'customer.qingkuan/print_view',
    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                toolbar: ['refresh',
                    'delete',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'qingkuan_code', title: '请款单编码'},
                    {field: 'contract.company_name', title: '客户公司'},
                    {field: 'contract.contract_code', title: '合同编号'},
                    {field: 'write.username', title: '填表人'},
                    {field: 'tax', title: '增值税额'},
                    {field: 'quotation_amount', title: '请款金额'},
                    {field: 'create_time', title: '创建时间',search:false},
                    {
                        width: 250, title: '操作', templet: ea.table.tool, fixed: "right",
                        operat: [
                            [{
                                text: '打印预览',
                                url: init.print_url,
                                method: 'open',
                                auth: 'print',
                                field: 'id',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                            'delete',]
                    },


                ]],
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