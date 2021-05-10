define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.assess/index',
        add_url: 'project.assess/add',
        edit_url: 'project.assess/edit',
        delete_url: 'project.assess/delete',
        export_url: 'project.assess/export',
        modify_url: 'project.assess/modify',
    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'description_id', title: 'description_id'},
                    {field: 'type', title: '评估类型'},
                    {field: 'yp_layout_format', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排布局格式'},
                    {field: 'yp_content_check', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排内容检查'},
                    {field: 'yp_customer_request', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排客户要求'},
                    {field: 'yp_overall_evaluation', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排综合评估'},
                    {field: 'yp_remark', title: '预排备注'},
                    {field: 'hp__layout_format', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排排布局格式'},
                    {field: 'hp_content_check', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排内容检查'},
                    {field: 'hp_customer_request', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排客户要求'},
                    {field: 'hp_overall_evaluation', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排综合评估'},
                    {field: 'hp_remark', title: '后排备注'},
                    {field: 'tr_omissions', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译漏译'},
                    {field: 'tr_redundant', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译多译'},
                    {field: 'tr_understanding', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译理解程度'},
                    {field: 'tr_input_error', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '打字,数据错误'},
                    {field: 'tr_not_uniform', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译自身术语不统一'},
                    {field: 'tr_not_uniform_with', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译未和其他译者统一术语'},
                    {field: 'tr_inappropriate_terminology', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '术语翻译不恰当'},
                    {field: 'tr_improper_punctuation', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译标点符号不恰当'},
                    {field: 'tr_out_habit', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译不符合习惯'},
                    {field: 'tr_syntax_error', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译语法错误'},
                    {field: 'tr_fluency_of_expression', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译表达流畅度'},
                    {field: 'tr_reference', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译是否认真参考参考文件'},
                    {field: 'tr_repeatedly', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译既往纠正问题反复'},
                    {field: 'tr_overall_evaluation', title: '翻译综合评估'},
                    {field: 'tr_remark', title: '翻译备注'},
                    {field: 'create_time', title: '创建时间'},
                    {width: 250, title: '操作', templet: ea.table.tool},

                ]],
            });

            ea.listen();
        },
        ypindex: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.assess/ypindex',
                add_url: 'project.assess/assessyp',
                edit_url: 'project.assess/edit',
                delete_url: 'project.assess/delete',
                export_url: 'project.assess/export',
                modify_url: 'project.assess/modify',
            };
            ea.table.render({
                init: init,
                skin: 'line ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                overflow: 'tips',
                toolbar: ['refresh',
                    [{
                        text: '添加',
                        url: init.add_url+'?type=1',
                        method: 'open',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    'delete',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'yp.username', title: '预排人员'},
                    {field: 'file.file_name_project', title: '文件名称'},
                    {field: 'file.file_code_project', title: '文件编号'},
                    {field: 'yp_layout_format', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排布局格式',search:false},
                    {field: 'yp_content_check', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排内容检查',search:false},
                    {field: 'yp_customer_request', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排客户要求',search:false},
                    {field: 'yp_overall_evaluation', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '预排综合评估',search:false},
                    {field: 'yp_remark', title: '预排备注',search:false},
                    {field: 'write.username', title: '填表人'},
                    {field: 'create_time', title: '创建时间',search:false},
                    {width: 250, title: '操作',fixed:"right", templet: ea.table.tool},

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                // ,autoColumnWidth: {
                //     init: true
                // },

                ,done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        hpindex: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.assess/hpindex',
                add_url: 'project.assess/assesshp',
                edit_url: 'project.assess/edit',
                delete_url: 'project.assess/delete',
                export_url: 'project.assess/export',
                modify_url: 'project.assess/modify',
            };
            ea.table.render({
                init: init,
                skin: 'line ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                overflow: 'tips',
                toolbar: ['refresh',
                    [{
                        text: '添加',
                        url: init.add_url+'?type=2',
                        method: 'open',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    'delete',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'hp.username', title: '后排人员'},
                    {field: 'file.file_name_project', title: '文件名称'},
                    {field: 'file.file_code_project', title: '文件编号'},
                    {field: 'hp_layout_format', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排排布局格式',search:false},
                    {field: 'hp_content_check', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排内容检查',search:false},
                    {field: 'hp_customer_request', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排客户要求',search:false},
                    {field: 'hp_overall_evaluation', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '后排综合评估',search:false},
                    {field: 'hp_remark', title: '后排备注',search:false},
                    {field: 'write.username', title: '填表人'},
                    {field: 'create_time', title: '创建时间',search:false},
                    {width: 250, title: '操作',fixed:"right", templet: ea.table.tool},

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                // ,autoColumnWidth: {
                //     init: true
                // },

                ,done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        trindex: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.assess/trindex',
                add_url: 'project.assess/assesstr',
                edit_url: 'project.assess/edit',
                delete_url: 'project.assess/delete',
                export_url: 'project.assess/export',
                modify_url: 'project.assess/modify',
            };
            ea.table.render({
                init: init,
                skin: 'line ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',
                    [{
                        text: '添加',
                        url: init.add_url+'?type=3',
                        method: 'open',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        icon: 'fa fa-plus ',
                        extend: 'data-full="true"',
                    }],
                    'delete',],
                overflow: 'tips',
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'tr.username', title: '翻译人员'},
                    {field: 'file.file_name_project', title: '文件名称'},
                    {field: 'file.file_code_project', title: '文件编号'},
                    {field: 'tr_omissions', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译漏译',search:false},
                    {field: 'tr_redundant', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译多译',search:false},
                    {field: 'tr_understanding', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译理解程度',search:false},
                    {field: 'tr_input_error', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '打字,数据错误',search:false},
                    {field: 'tr_not_uniform', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译自身术语不统一',search:false},
                    {field: 'tr_not_uniform_with', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译未和其他译者统一术语',search:false},
                    {field: 'tr_inappropriate_terminology', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '术语翻译不恰当',search:false},
                    {field: 'tr_improper_punctuation', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译标点符号不恰当',search:false},
                    {field: 'tr_out_habit', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译不符合习惯',search:false},
                    {field: 'tr_syntax_error', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译语法错误',search:false},
                    {field: 'tr_fluency_of_expression', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译表达流畅度',search:false},
                    {field: 'tr_reference', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译是否认真参考参考文件',search:false},
                    {field: 'tr_repeatedly', search: 'select', selectList: {"1":"A","2":"B","3":"C","4":"D"}, title: '翻译既往纠正问题反复',search:false},
                    {field: 'tr_overall_evaluation', title: '翻译综合评估',search:false},
                    {field: 'tr_remark', title: '翻译备注',search:false},
                    {field: 'write.username', title: '填表人'},
                    {field: 'create_time', title: '创建时间',search:false},
                    {width: 250, title: '操作',fixed:"right", templet: ea.table.tool},

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                ,autoColumnWidth: {
                    init: true
                }

                ,done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
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