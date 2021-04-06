define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.information/index',
        add_url: 'customer.information/add',
        edit_url: 'customer.information/edit',
        delete_url: 'customer.information/delete',
        export_url: 'customer.information/export',
        modify_url: 'customer.information/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                ,even: true, //开启隔行背景
                text: {
                    none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
                }
                ,cols: [[

                    {type: 'checkbox',},
                    {field: 'id', title: 'id'},
                    {field: 'customer_contact', title: '客户联系人',sort:true},
                    {field: 'department', title: '所在部门',hide:true},
                    {field: 'company_name', title: '公司全称',sort:true},
                    {field: 'company_address', title: '公司地址'},
                    {field: 'country', title: '国家',hide:true},
                    {field: 'position', title: '职位',hide:true},
                    {field: 'mobile_phone_number', title: '移动电话号码'},
                    {field: 'landline_number', title: '固定电话号码'},
                    {field: 'mailbox', title: '邮箱'},
                    {field: 'company_code', title: '公司编码',sort:true},
                    // {field: 'contract_code', title: '合同编码'},
                    {field: 'remarks', title: '备注',hide:true},
                    {field: 'create_time', title: '创建时间'},
                    {field: 'write.username', title: '录入人员'},
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