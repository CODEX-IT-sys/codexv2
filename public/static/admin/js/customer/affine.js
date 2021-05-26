define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.affine/index',
        add_url: 'customer.affine/add',
        edit_url: 'customer.affine/edit',
        delete_url: 'customer.affine/delete',
        export_url: 'customer.filaa/export',
        approve_url: 'customer.affine/approve',
        qingkuan_url: 'customer.affine/qingkuan',
    };

    var soulTable = layui.soulTable;


    var Controller = {
        // 、、全部
        index: function () {
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',
                    [{
                        text: '批准',
                        url: init.approve_url,
                        method: 'request',
                        auth: 'approve',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    [{
                        text: '生成请款单',
                        url: init.qingkuan_url,
                        method: 'request',
                        auth: 'qingkuan',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    'delete',],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true,},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准", '4': "项目已交稿"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    {field: 'contract.contract_code', title: '合同编码'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'contract.company_name', title: '公司名称', sort: true},
                    {field: 'entrust_date', title: '委托日期', sort: true, search: false},
                    {field: 'contract.sales_id', title: '销售', sort: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', sort: true},
                    {field: 'customerInformation.department', title: '所在部门', sort: true, search: false},
                    {field: 'type.content', title: '文件类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'contract.currency', title: '币种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false',},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'completion_quantity', title: '交付数量', search: 'false'},
                    {field: 'no_vat', title: '报价未税金额', search: 'false'},
                    {field: 'vat', title: '报价增值税金额', search: 'false'},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'vat1', title: '请款增值税', search: 'false',templet: ea.table.price},
                    {field: 'no_vat1', title: '请款未税金额', search: 'false',templet: ea.table.price},
                    {field: 'quotation_price1', title: '请款金额', search: 'false',templet: ea.table.price,},
                    {field: 'discount', title: '折扣', search: 'false'},
                    {field: 'po_number', title: 'po号', search: 'false'},
                    // {field: 'po_amount', title: 'po金额', search: 'false'},
                    // {field: 'po_balance', title: 'po剩余金额', search: 'false'},
                    {field: 'jsstatus.content', title: '结算状态', search: 'false'},
                    {
                        field: 'contract.invoicing_rules',
                        title: '发票类型',
                        search: 'false'
                    },
                    {field: 'fapiao_amount', title: '开票金额', search: 'false'},
                    {field: 'fapiao_date', title: '开票日期', search: 'false'},
                    {field: 'fapiao_code', title: '发票编码', search: 'false'},
                    {
                        field: 'pre_payment',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '预付款'
                    },

                    {field: 'pre_payment_date', title: '预付款日期', search: 'false'},
                    {field: 'pre_payment_amount', title: '预付款金额', search: 'false'},
                    {field: 'the_balance', title: '余款', search: 'false'},
                    {field: 'date_of_balance', title: '余款支付日期', search: 'false'},
                    {
                        field: 'balance_done',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '余款付清',
                        search: 'false'
                    },
                    {
                        field: 'generate_demand',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '生成项目需求'
                    },
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'customerInformation.department', title: '客户部门', search: 'false',},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false',},
                    {field: 'contract.company_address', title: '客户地址', search: 'false',},
                    {field: 'customer_file_request', title: '客户要求', search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', search: 'false'},
                    {field: 'payment_time', title: '付款完成时间', search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
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
        // 、、已接受
        accept: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'customer.affine/accept',
                add_url: 'customer.affine/add',
                edit_url: 'customer.affine/edit',
                delete_url: 'customer.affine/delete',
                export_url: 'customer.filaa/export',
                approve_url: 'customer.affine/approve',
                qingkuan_url: 'customer.affine/qingkuan',
            };
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                totalRow: true,
                toolbar: ['refresh',
                    [{
                        text: '批准',
                        url: init.approve_url,
                        method: 'request',
                        auth: 'approve',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    [{
                        text: '生成请款单',
                        url: init.qingkuan_url,
                        method: 'request',
                        auth: 'qingkuan',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    'delete',],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true,},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准", '4': "项目已交稿"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    {field: 'contract.contract_code', title: '合同编码'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'contract.company_name', title: '公司名称', sort: true},
                    {field: 'entrust_date', title: '委托日期', sort: true, search: false},
                    {field: 'contract.sales_id', title: '销售', sort: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', sort: true},
                    {field: 'customerInformation.department', title: '所在部门', sort: true, search: false},
                    {field: 'type.content', title: '文件类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'contract.currency', title: '币种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false',},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'completion_quantity', title: '交付数量', search: 'false'},
                    {field: 'no_vat', title: '报价未税金额', search: 'false'},
                    {field: 'vat', title: '报价增值税金额', search: 'false'},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'vat1', title: '请款增值税', search: 'false',templet: ea.table.price},
                    {field: 'no_vat1', title: '请款未税金额', search: 'false',templet: ea.table.price},
                    {field: 'quotation_price1', title: '请款金额', search: 'false',templet: ea.table.price,},
                    {field: 'discount', title: '折扣', search: 'false'},
                    {field: 'po_number', title: 'po号', search: 'false'},
                    // {field: 'po_amount', title: 'po金额', search: 'false'},
                    // {field: 'po_balance', title: 'po剩余金额', search: 'false'},
                    {field: 'jsstatus.content', title: '结算状态', search: 'false'},
                    {
                        field: 'contract.invoicing_rules',
                        title: '发票类型',
                        search: 'false'
                    },
                    {field: 'fapiao_amount', title: '开票金额', search: 'false'},
                    {field: 'fapiao_date', title: '开票日期', search: 'false'},
                    {field: 'fapiao_code', title: '发票编码', search: 'false'},
                    {
                        field: 'pre_payment',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '预付款'
                    },

                    {field: 'pre_payment_date', title: '预付款日期', search: 'false'},
                    {field: 'pre_payment_amount', title: '预付款金额', search: 'false'},
                    {field: 'the_balance', title: '余款', search: 'false'},
                    {field: 'date_of_balance', title: '余款支付日期', search: 'false'},
                    {
                        field: 'balance_done',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '余款付清',
                        search: 'false'
                    },
                    {
                        field: 'generate_demand',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '生成项目需求'
                    },
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'customerInformation.department', title: '客户部门', search: 'false',},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false',},
                    {field: 'contract.company_address', title: '客户地址', search: 'false',},
                    {field: 'customer_file_request', title: '客户要求', search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', search: 'false'},
                    {field: 'payment_time', title: '付款完成时间', search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
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

        // 拒绝
        refuse: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'customer.affine/refuse',
                add_url: 'customer.affine/add',
                edit_url: 'customer.affine/edit',
                delete_url: 'customer.affine/delete',
                export_url: 'customer.filaa/export',
                approve_url: 'customer.affine/approve',
                qingkuan_url: 'customer.affine/qingkuan',
            };
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                totalRow: true,
                toolbar: ['refresh',
                    [{
                        text: '接受并批准',
                        url: init.approve_url,
                        method: 'request',
                        auth: 'approve',
                        checkbox: true,
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],

                    'delete',],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true,},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准", '4': "项目已交稿"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    {field: 'contract.contract_code', title: '合同编码'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'contract.company_name', title: '公司名称', sort: true},
                    {field: 'entrust_date', title: '委托日期', sort: true, search: false},
                    {field: 'contract.sales_id', title: '销售', sort: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', sort: true},
                    {field: 'customerInformation.department', title: '所在部门', sort: true, search: false},
                    {field: 'type.content', title: '文件类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'contract.currency', title: '币种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'completion_quantity', title: '交付数量', search: 'false'},
                    {field: 'no_vat', title: '报价未税金额', search: 'false'},
                    {field: 'vat', title: '报价增值税金额', search: 'false'},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'vat1', title: '请款增值税', search: 'false',templet: ea.table.price},
                    {field: 'no_vat1', title: '请款未税金额', search: 'false',templet: ea.table.price},
                    {field: 'quotation_price1', title: '请款金额', search: 'false',templet: ea.table.price,},
                    {field: 'discount', title: '折扣', search: 'false'},
                    {field: 'po_number', title: 'po号', search: 'false'},
                    // {field: 'po_amount', title: 'po金额', search: 'false'},
                    // {field: 'po_balance', title: 'po剩余金额', search: 'false'},
                    {field: 'jsstatus.content', title: '结算状态', search: 'false'},
                    {
                        field: 'contract.invoicing_rules',
                        title: '发票类型',
                        search: 'false'
                    },
                    {field: 'fapiao_amount', title: '开票金额', search: 'false'},
                    {field: 'fapiao_date', title: '开票日期', search: 'false'},
                    {field: 'fapiao_code', title: '发票编码', search: 'false'},
                    {
                        field: 'pre_payment',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '预付款'
                    },

                    {field: 'pre_payment_date', title: '预付款日期', search: 'false'},
                    {field: 'pre_payment_amount', title: '预付款金额', search: 'false'},
                    {field: 'the_balance', title: '余款', search: 'false'},
                    {field: 'date_of_balance', title: '余款支付日期', search: 'false'},
                    {
                        field: 'balance_done',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '余款付清',
                        search: 'false'
                    },
                    {
                        field: 'generate_demand',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '生成项目需求'
                    },
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'customerInformation.department', title: '客户部门', search: 'false',},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false',},
                    {field: 'contract.company_address', title: '客户地址', search: 'false',},
                    {field: 'customer_file_request', title: '客户要求', search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', search: 'false'},
                    {field: 'payment_time', title: '付款完成时间', search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
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
        //已批准
        passed: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'customer.affine/passed',
                add_url: 'customer.affine/add',
                edit_url: 'customer.affine/edit',
                delete_url: 'customer.affine/delete',
                export_url: 'customer.filaa/export',
                approve_url: 'customer.affine/approve',
            };
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                totalRow: true,
                toolbar: ['refresh'],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true,},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准", '4': "项目已交稿"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    {field: 'contract.contract_code', title: '合同编码'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'contract.company_name', title: '公司名称', sort: true},
                    {field: 'entrust_date', title: '委托日期', sort: true, search: false},
                    {field: 'contract.sales_id', title: '销售', sort: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', sort: true},
                    {field: 'customerInformation.department', title: '所在部门', sort: true, search: false},
                    {field: 'type.content', title: '文件类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'contract.currency', title: '币种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false',},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'completion_quantity', title: '交付数量', search: 'false'},
                    {field: 'no_vat', title: '未税金额', search: 'false'},
                    {field: 'vat', title: '增值税金额', search: 'false'},
                    {field: 'quotation_price', title: '请款金额', search: 'false'},
                    {field: 'discount', title: '折扣', search: 'false'},
                    {field: 'po_number', title: 'po号', search: 'false'},
                    // {field: 'po_amount', title: 'po金额', search: 'false'},
                    // {field: 'po_balance', title: 'po剩余金额', search: 'false'},
                    {field: 'jsstatus.content', title: '结算状态', search: 'false'},
                    {
                        field: 'contract.invoicing_rules',
                        title: '发票类型',
                        search: 'false'
                    },
                    {field: 'fapiao_amount', title: '开票金额', search: 'false'},
                    {field: 'fapiao_date', title: '开票日期', search: 'false'},
                    {field: 'fapiao_code', title: '发票编码', search: 'false'},
                    {
                        field: 'pre_payment',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '预付款'
                    },

                    {field: 'pre_payment_date', title: '预付款日期', search: 'false'},
                    {field: 'pre_payment_amount', title: '预付款金额', search: 'false'},
                    {field: 'the_balance', title: '余款', search: 'false'},
                    {field: 'date_of_balance', title: '余款支付日期', search: 'false'},
                    {
                        field: 'balance_done',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '余款付清',
                        search: 'false'
                    },
                    {
                        field: 'generate_demand',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '生成项目需求'
                    },
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'customerInformation.department', title: '客户部门', search: 'false',},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false',},
                    {field: 'contract.company_address', title: '客户地址', search: 'false',},
                    {field: 'customer_file_request', title: '客户要求', search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', search: 'false'},
                    {field: 'payment_time', title: '付款完成时间', search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
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