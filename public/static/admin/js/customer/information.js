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
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh', 'add', 'delete'],
                text: {
                    none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
                }
                , cols: [[

                    {type: 'checkbox',},
                    {field: 'id', title: 'id'},
                    {field: 'customer_contact', title: '客户联系人', sort: true},
                    {field: 'department', title: '所在部门',},
                    {field: 'contract.company_name', title: '公司全称', sort: true},
                    {field: 'contract.abbreviation_name', title: '公司简称', sort: true},
                    {field: 'contract.company_code', title: '公司编码', sort: true},
                    {field: 'information_address', title: '客户联系地址'},
                    // {field: 'country', title: '国家', hide: true},
                    {field: 'position', title: '职位',},
                    {field: 'mobile_phone_number', title: '移动电话号码',search:false},
                    {field: 'landline_number', title: '固定电话号码',search:false},
                    {field: 'mailbox', title: '邮箱',search:false},
                    // {field: 'company_code', title: '公司编码', sort: true,search:false},
                    // {field: 'contract_code', title: '合同编码'},
                    {field: 'remarks', title: '备注',search:false},
                    {field: 'create_time', title: '创建时间',search:false},
                    {field: 'write.username', title: '录入人员'},
                    {width: 250, title: '操作', templet: ea.table.tool, fixed: "right",},

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
                , autoColumnWidth: {
                    init: true
                },
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
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