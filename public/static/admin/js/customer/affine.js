define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'customer.affine/index',
        add_url: 'customer.filaa/add',
        edit_url: 'customer.filaa/edit',
        delete_url: 'customer.filaa/delete',
        export_url: 'customer.filaa/export',
        modify_url: 'customer.filaa/modify',
        quotation_url: 'customer.filaa/quotation',
    };

    var Controller = {
        index: function () {
            ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                ,even: true, //开启隔行背景
                size:'sm', //小尺寸的表格
                limit:5,
                totalRow:true,
                cols: [[
                    {field: 'customer_file_code', title: '文件编号',fixed:true,width:200},
                    {type: 'checkbox'},
                    {field: 'id', title: 'id',search:'false'},
                    {field: 'file_status', search: 'select', selectList: {"1":"接受","2":"拒绝","0":"未确定"}, title: '文件状态',sort:true},
                    // {field: 'demand.contract_code', title: '合同编号'},
                    {field: 'customer_file_name', title: '文件名称',edit:true,sort:true},
                    {field: 'customerInformation.company_name', title: '公司名称',edit:true,sort:true},
                    {field: 'type.content', title: '类型',search:'false',},
                    {field: 'page', title: '页数',edit:true,search:'false'},
                    {field: 'number_of_words', title: '源语数量',edit:true,search:'false'},
                    {field: 'fw', title: '服务',search:'false'},
                    {field: 'yz.content', title: '语种',search:'false',},
                    {field: 'unit_price', title: '单价',search:'false',edit:true},
                    {field: 'dw.content', title: '单位',search:'false'},
                    {field: 'quotation_number', title: '报价数量',search:'false',edit:true},
                    {field: 'rate.content', title: '税率',search:'false'},
                    {field: 'vat', title: '增值税',search:'false',totalRow:true,totalRowText:'合计',},
                    {field: 'quotation_price', title: '报价金额',search:'false'},
                    {field: 'customer_submit_date', title: '客户期望提交日期',search:'false'},
                    {field: 'customerInformation.department', title: '客户部门',search:'false',hide:true},
                    {field: 'customerInformation.customer_contact', title: '客户联系人',search:'false',hide:true},
                    {field: 'customerInformation.company_address', title: '客户地址',search:'false',hide:true},
                    {field: 'customer_submit_date', title: '客户期望提交日期',sort:true},
                    {field: 'customer_file_request', title: '客户要求','hide':true,search:'false'},
                    {field: 'customer_file_reference', title: '参考文件','hide':true,search:'false'},
                    {field: 'customer_file_remark', title: '参考文件备注','hide':true,search:'false'},
                    {field: 'create_time', title: '创建时间',sort:true},
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