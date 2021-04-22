define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.allitems/index',
        add_url: 'project.allitems/add',
        edit_url: 'project.allitems/edit',
        delete_url: 'project.allitems/delete',
        export_url: 'project.allitems/export',
        modify_url: 'project.allitems/modify',
    };

    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh', 'export'],
                text: {none: '无数据'},
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'customerInformation.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'xm.username', title: '项目经理', search: 'false'},
                    {field: 'assignor.username', title: '项目助理', search: 'false'},
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'tyevel.content', title: '排版难易度', search: 'false'},
                    {field: 'trevel.content', title: '翻译难易度', search: 'false'},
                    {field: 'customerInformation.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '备注', 'hide': true, search: 'false'},
                    {
                        width: 250, title: '操作', templet: ea.table.tool, operat: [

                            'edit']
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

            var soulTable = layui.soulTable;
            console.log(soulTable);

            ea.listen();
        },
        add: function () {
            ea.listen();
        },
        edit: function () {
            ea.listen();
            ea.listen(function (data) {
                // console.log(data);
                return data;

            })
        },
    };
    return Controller;
});
