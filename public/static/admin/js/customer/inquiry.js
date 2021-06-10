define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.filaa/index',
        add_url: 'customer.filaa/add',
        edit_url: 'customer.filaa/edit',
        delete_url: 'customer.filaa/delete',
        export_url: 'customer.filaa/export',
        modify_url: 'customer.filaa/modify',
        quotation_url: 'customer.filaa/quotation',
        quotation_approve: 'customer.filaa/approve',
    };
    var soulTable = layui.soulTable;
    var Controller = {
        index: function () {
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                totalRow: true,
                toolbar: ['refresh',

                    'delete',],
                where: {id: demand_id},//如果无需传递额外参数，可不加该参数
                cols: [[

                    {field: 'id', title: 'id', search: 'false',},
                    {field: 'customer_file_code', title: '文件编号',},
                    {field: 'customer_file_name', title: '文件名称',  sort: true},
                    {field: 'contract.company_name', title: '公司名称',  sort: true},
                    {field: 'type.content', title: '类型'},
                    {field: 'page', title: '页数',  search: 'false'},
                    {field: 'number_of_words', title: '源语数量',  search: 'false'},
                    {field: 'service', title: '服务',},
                    {field: 'language', title: '语种',},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', search: 'false'},
                    {field: 'customer_file_remark', title: '备注', search: 'false'},
                    {
                        field: 'generate_demand',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '生成项目需求'
                    },
                    {field: 'create_time', title: '创建时间', sort: true,search: 'false'},
                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                },
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                , autoColumnWidth: {
                    init: true
                },

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


