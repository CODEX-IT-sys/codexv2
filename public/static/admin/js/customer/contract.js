define(["jquery", "easy-admin"], function ($, ea) {    var init = {        table_elem: '#currentTable',        table_render_id: 'currentTableRenderId',        index_url: 'customer.contract/index',        add_url: 'customer.contract/add',        edit_url: 'customer.contract/edit',        delete_url: 'customer.contract/delete',        export_url: 'customer.contract/export',        modify_url: 'customer.contract/modify',    };    var soulTable = layui.soulTable;    var Controller = {        index: function () {            ea.table.render({                init: init, overflow: 'tips',                skin: 'line  ' //行边框风格                , even: true, //开启隔行背景                toolbar: ['refresh', 'add', 'delete'],                cols: [[                    {type: 'checkbox'},                    {field: 'id', title: 'id', search: false},                    {field: 'contract_code', title: '合同编码'},                    {field: 'company.chinese_company_name', title: '主体公司'},                    {field: 'customerInformation.company_name', title: '客户公司'},                    {field: 'sale.username', title: '销售'},                    {field: 'contract_signer', title: '合同签订人',},                    {field: 'fw.content', title: '服务', 'hide': true},                    {field: 'yz.content', title: '语种', 'hide': true, search: false},                    {field: 'bz.content', title: '币种', 'hide': true, search: false},                    {field: 'unit_price', title: '单价', 'hide': true, search: false, templet: ea.table.price},                    {field: 'dw.content', title: '单位', 'hide': true, search: false},                    {field: 'estimated_sales', title: '预计销售额', 'hide': true, search: false, templet: ea.table.price},                    {field: 'tax_rate', title: '税率', 'hide': true, search: false, templet: ea.table.percent},                    {field: 'customer_tax_number', title: '客户税号', 'hide': true, search: false},                    {field: 'bank_information', title: '银行信息', 'hide': true, search: false},                    {                        field: 'invoicing_rules',                        search: 'select',                        selectList: {"1": "专票", "2": "普票", "0": "N\/A"},                        title: '开票规则',                        'hide': true                    },                    {field: 'account_period', title: '结算方式', 'hide': true, search: false},                    {                        field: 'confidentiality_agreement',                        search: 'select',                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},                        title: '有无保密协议',                        'hide': true                    },                    {field: 'effective_date', title: '生效日期', 'sort': true, search: false},                    {field: 'expiration_date', title: '失效日期', 'sort': true, search: false},                    {field: 'status', title: '合同状态', 'sort': true, search: false},                    {field: 'remaining', title: '剩余天数', 'sort': true, search: false},                    {field: 'recipient', title: '合同收件人', 'hide': true},                    {field: 'recipient_address', title: '合同收件地址', 'hide': true, search: false},                    {field: 'remarks', title: '备注', 'hide': true, search: false},                    {field: 'create_time', title: '创建时间', search: false},                    {field: 'write.username', title: '录入人员'},                    // {field: 'customerInformation.contract_code', title: '合同编码'},                    {width: 250, title: '操作', templet: ea.table.tool, fixed: "right",},                ]],                done: function () {                    // 在 done 中开启                    soulTable.render(this)                }            });            ea.listen(function (data) {                // // 此处进行数据重组再返回                // data.effective_date = '测试重组数据';                //                // return data;            });        },        add: function () {            ea.listen();        },        edit: function () {            ea.listen();        },    };    return Controller;});