define(["jquery", "easy-admin", "treetable",], function ($, ea) {

    var soulTable = layui.soulTable;
    var tableReload = layui.table;
    console.log(soulTable);
    console.log(tableReload);
    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.demand/index',
        add_url: 'customer.demand/add',
        edit_url: 'customer.demand/edit',
        delete_url: 'customer.demand/delete',
        export_url: 'customer.demand/export',
        modify_url: 'customer.demand/modify',
        file_url: 'customer.filaa/index',
        quotation_url: 'customer.quotation/index'
    };


    var Controller = {

        index: function () {
            var aa = ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh', 'add', 'delete', [{
                    text: '报价单',
                    url: init.quotation_url,
                    method: 'open',
                    auth: 'delete',
                    class: 'layui-btn layui-btn-normal layui-btn-sm',
                    extend: 'data-full="true"',
                }],],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'submission_time', title: '来稿时间',search: 'range'},
                    {field: 'company.chinese_company_name', title: '主体公司'},
                    {field: 'contract.company_name', title: '客户公司'},
                    {field: 'customerInformation.customer_contact', title: '联系人'},
                    {field: 'contract.contract_code', title: '合同编号'},
                    {field: 'xm.username', title: '项目经理'},
                    {field: 'write.username', title: '录入人'},
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    // {field: 'quotation_amount', title: '报价金额'},
                    {field: 'create_time', title: '创建时间'},
                    {
                        width: 250, title: '操作', templet: ea.table.tool, fixed: "right",
                        operat: [
                            [{
                                text: '文件信息',
                                url: init.file_url,
                                method: 'open',
                                field: 'id',
                                auth: 'file',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                            'delete', 'edit']
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });
            $('#reload').on('click', function () {
                // 表格重载
                aa.reload()
            })
            $('#clear').on('click', function () {
                soulTable.clearCache(aa.config.id)
                layer.msg('已还原！', {icon: 1, time: 1000})
            })

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