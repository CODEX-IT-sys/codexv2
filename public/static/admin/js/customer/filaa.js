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
                    [{
                        text: '添加',
                        url: init.add_url + '?id=' + demand_id,
                        method: 'open',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    [{
                        text: '生成报价单',
                        url: init.quotation_url,
                        method: 'request',
                        auth: 'quotation',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    [{
                        text: '批量接受',
                        url: init.quotation_approve,
                        method: 'request',
                        auth: 'approve',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    'delete',],
                where: {id: demand_id},//如果无需传递额外参数，可不加该参数
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        title: '订单状态',
                        sort: true,
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定"},
                        fixed: true,
                        templet: function (d) {
                            if (d.file_status == 0) {
                                return '未确定';
                            } else if(d.file_status == 1){
                                return '拒绝';
                            }else{
                                return '接受';
                            }
                        },
                    },
                    // {field: 'demand.contract_code', title: '合同编号'},
                    {field: 'entrust_date', title: '来稿日期', sort: true,search:'searchtime'},
                    {field: 'customer_file_name', title: '文件名称',  sort: true},
                    {field: 'contract.company_name', title: '公司名称',  sort: true},
                    {field: 'type.content', title: '文件类型'},
                    {field: 'page', title: '页数',  search: 'false'},
                    {field: 'number_of_words', title: '源语字数',  search: 'false'},
                    {field: 'service', title: '服务类型', search: 'false'},
                    {field: 'yz.content', title: '语种',},
                    {field: 'unit_price', title: '单价', search: 'false'},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税额', search: 'false',templet: ea.table.price},
                    {field: 'no_vat', title: '未税金额', search: 'false',templet: ea.table.price},
                    {field: 'quotation_price', title: '报价金额', search: 'false',templet: ea.table.price,},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'customerInformation.department', title: '客户部门', search: 'false',},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false',},
                    {field: 'customerInformation.information_address', title: '客户联系人地址', search: 'false',},
                    {field: 'customer_file_request', title: '客户要求',  search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件',  search: 'false'},
                    {field: 'customer_file_remark', title: '备注',  search: 'false'},
                    {field: 'contract.sales', title: '销售',  search: 'false'},
                    {field: 'filecreate_at', title: '更新日期', sort: true,search: 'false'},
                    {width: 250, title: '操作', templet: ea.table.tool, fixed: "right",},

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


