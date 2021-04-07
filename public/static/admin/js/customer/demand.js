define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.demand/index',
        add_url: 'customer.demand/add',
        edit_url: 'customer.demand/edit',
        delete_url: 'customer.demand/delete',
        export_url: 'customer.demand/export',
        modify_url: 'customer.demand/modify',
        file_url:'customer.file/index'
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                ,even: true, //开启隔行背景
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'company.chinese_company_name', title: '主体公司'},
                    // {field: 'cid', title: '合同编号'},
                    {field: 'contract.contract_code', title: '合同编号'},
                    {field: 'xm.username', title: '项目经理'},
                    {field: 'write.username', title: '录入人'},
                    {field: 'cooperation_first', search: 'select', selectList: {"1":"yes","2":"no","0":"N\/A"}, title: '是否首次合作'},
                    {field: 'quotation_amount', title: '报价金额'},
                    {field: 'create_time', title: '创建时间'},
                    {width: 250, title: '操作', templet: ea.table.tool,
                        operat: [
                            [{
                                text: '文件信息',
                                url: init.file_url,
                                method: 'open',
                                auth: 'stock',
                                field:'id',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                            'delete','edit']
                    },

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