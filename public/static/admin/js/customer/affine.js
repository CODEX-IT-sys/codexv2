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
                limit: 50,
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
                    'delete',],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox'},
                    {field: 'id', title: 'id', search: 'false'},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准"},
                        title: '文件状态',
                        sort: true
                    },
                    // {field: 'demand.contract_code', title: '合同编号'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'customerInformation.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false', totalRow: true, totalRowText: '合计',},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'customerInformation.department', title: '客户部门', search: 'false', hide: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customerInformation.company_address', title: '客户地址', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', 'hide': true, search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
                    {width: 250, title: '操作', templet: ea.table.tool},

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
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
            };
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                limit: 50,
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
                    'delete',],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    // {field: 'demand.contract_code', title: '合同编号'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'customerInformation.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false', },
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'customerInformation.department', title: '客户部门', search: 'false', hide: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customerInformation.company_address', title: '客户地址', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', 'hide': true, search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
                    {width: 250, title: '操作', templet: ea.table.tool, fixed: "right",},

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
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
            };
            ea.table.render({
                init: init, overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                limit: 50,
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
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    // {field: 'demand.contract_code', title: '合同编号'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'customerInformation.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false',},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'customerInformation.department', title: '客户部门', search: 'false', hide: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customerInformation.company_address', title: '客户地址', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', 'hide': true, search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
                    {width: 250, title: '操作', templet: ea.table.tool, fixed: "right",},

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
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
                limit: 50,
                totalRow: true,
                toolbar: ['refresh'],
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id', search: 'false', fixed: true,},
                    {
                        field: 'file_status',
                        search: 'select',
                        selectList: {"1": "拒绝", "2": "接受", "0": "未确定", '3': "已批准"},
                        title: '文件状态',
                        sort: true,
                        fixed: true,
                    },
                    // {field: 'demand.contract_code', title: '合同编号'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'customerInformation.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'unit_price', title: '单价', search: 'false', edit: true},
                    {field: 'dw.content', title: '单位', search: 'false'},
                    {field: 'quotation_number', title: '报价数量', search: 'false', edit: true},
                    {field: 'rate.content', title: '税率', search: 'false'},
                    {field: 'vat', title: '增值税', search: 'false'},
                    {field: 'quotation_price', title: '报价金额', search: 'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'customerInformation.department', title: '客户部门', search: 'false', hide: true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customerInformation.company_address', title: '客户地址', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '参考文件备注', 'hide': true, search: 'false'},
                    {field: 'create_time', title: '创建时间', sort: true, search: 'false'},
                    {width: 250, title: '操作', templet: ea.table.tool, fixed: "right",},

                ]],
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
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