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
        deliver_url: 'project.allitems/deliver',
        m_url: 'project.allitems/m',
        general_url: 'project.allitems/general',
        batchedit_url: 'project.allitems/batchedit',
        multiplesplit_url: 'project.allitems/multiplesplit',
    };
    var soulTable = layui.soulTable;

    var Controller = {
        index: function () {
            var allitemsa = ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',
                    [{
                        text: '项目经理批准',
                        url: init.m_url,
                        method: 'request ',
                        auth: 'm',
                        checkbox: 'true',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        extend: 'data-full="true"',
                    }],
                    [{
                        text: '总经理批准',
                        url: init.general_url,
                        method: 'request ',
                        auth: 'general',
                        checkbox: 'true',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        extend: 'data-full="true"',
                    }],
                    [{
                        text: '批量编辑',
                        url: init.batchedit_url,
                        method: 'open',
                        checkbox: 'true',

                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    [{
                        text: '多文件拆分',
                        url: init.multiplesplit_url,
                        method: 'open',
                        checkbox: 'true',
                        auth: 'multiplesplit',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                ],
                text: {none: '无数据'},
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'contract.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false', filter: true},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'xm.username', title: '项目经理', search: 'false'},
                    {field: 'assistant.username', title: '项目助理', search: 'false'},
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'tyevel.content', title: '排版难易度', search: 'false'},
                    {field: 'trevel.content', title: '翻译难易度', search: 'false'},
                    {field: 'file_cate', title: '文件分类', search: 'false'},
                    {field: 'translation_id', title: '翻译', search: 'false'},
                    {field: 'tr_start_time', title: '翻译开始时间', search: 'false'},
                    {field: 'tr_end_time', title: '翻译交付时间', search: 'false'},
                    {field: 'proofreader_id', title: '校对', search: 'false'},
                    {field: 'pr_start_time', title: '校对开始时间', search: 'false'},
                    {field: 'pr_end_time', title: '校对交付时间', search: 'false'},
                    {field: 'before_ty_id', title: '预排版', search: 'false'},
                    {field: 'before_ty_time', title: '预排版交付时间', search: 'false'},
                    {field: 'after_ty_id', title: '后排版', search: 'false'},
                    {field: 'after_ty_time', title: '后排版交付时间', search: 'false'},
                    {field: 'quality', title: '质量要求', search: 'false'},
                    {field: 'contract.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'm_approval', title: '项目经理批准', 'hide': true, search: 'false'},
                    {field: 'general_approval', title: '总经理批准', 'hide': true, search: 'false'},
                    {field: 'confirmor_id.username', title: '录入人(项目)', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '备注', 'hide': true, search: 'false'},
                    {
                        width: 250, title: '操作', templet: ea.table.tool, fixed: "right", operat: [
                            [{
                                text: '交稿',
                                url: init.deliver_url,
                                method: 'request',
                                auth: 'deliver',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }],

                            'edit']
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                , autoColumnWidth: {
                    init: true
                },

                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }

            });
            $('#reload').on('click', function () {
                // 表格重载
                allitemsa.reload()
            })
            $('#clear').on('click', function () {
                soulTable.clearCache(allitemsa.config.id)
                layer.msg('已还原！', {icon: 1, time: 1000})
            })

            ea.listen();
        },
        //未交稿
        undelivered: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.allitems/undelivered',
                add_url: 'project.allitems/add',
                edit_url: 'project.allitems/edit',
                delete_url: 'project.allitems/delete',
                export_url: 'project.allitems/export',
                modify_url: 'project.allitems/modify',
                deliver_url: 'project.allitems/deliver',
                m_url: 'project.allitems/m',
                general_url: 'project.allitems/general',
                batchedit_url: 'project.allitems/batchedit',
                split_url: 'project.allitems/split',
            };

            var allitemsb = ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',
                    [{
                        text: '项目经理批准',
                        url: init.m_url,
                        method: 'request ',
                        auth: 'm',
                        checkbox: 'true',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        extend: 'data-full="true"',
                    }],
                    [{
                        text: '总经理批准',
                        url: init.general_url,
                        method: 'request ',
                        auth: 'general',
                        checkbox: 'true',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                        extend: 'data-full="true"',
                    }],
                    [{
                        text: '批量编辑',
                        url: init.batchedit_url,
                        method: 'open',
                        checkbox: 'true',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                    [{
                        text: '多文件拆分',
                        url: init.split_url,
                        method: 'open',
                        checkbox: 'true',
                        auth: 'split',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],
                ],

                text: {none: '无数据'},
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id',fixed: true,},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true, fixed: true,},
                    {field: 'contract.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'xm.username', title: '项目经理', search: 'false'},
                    {
                        title: '项目助理', templet: function (d) {
                            if (d.assistant == null) {
                                return ''
                            } else {
                                return d.assistant.username
                            }
                        },
                        search: 'false'
                    },
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {
                        title: '排版难易度', templet: function (d) {
                            if (d.tyevel == null) {
                                return ''
                            } else {
                                return d.tyevel.content
                            }
                        },
                        search: 'false'
                    },
                    {
                        title: '翻译难易度', templet: function (d) {
                            if (d.trevel == null) {
                                return ''
                            } else {
                                return d.trevel.content
                            }
                        },
                        search: 'false'
                    },
                    {field: 'file_cate', title: '文件分类', search: 'false'},
                    {field: 'translation_id', title: '翻译', search: 'false'},
                    {field: 'tr_start_time', title: '翻译开始时间', search: 'false'},
                    {field: 'tr_end_time', title: '翻译交付时间', search: 'false'},
                    {field: 'proofreader_id', title: '校对', search: 'false'},
                    {field: 'pr_start_time', title: '校对开始时间', search: 'false'},
                    {field: 'pr_end_time', title: '校对交付时间', search: 'false'},
                    {field: 'before_ty_id', title: '预排版', search: 'false'},
                    {field: 'before_ty_time', title: '预排版交付时间', search: 'false'},
                    {field: 'after_ty_id', title: '后排版', search: 'false'},
                    {field: 'after_ty_time', title: '后排版交付时间', search: 'false'},
                    {field: 'quality', title: '质量要求', search: 'false'},
                    {field: 'contract.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'm_approval', title: '项目经理批准', 'hide': true, search: 'false'},
                    {field: 'general_approval', title: '总经理批准', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '备注', 'hide': true, search: 'false'},
                    {
                        width: 250, title: '操作', templet: ea.table.tool, fixed: "right", operat: [
                            [{
                                text: '拆分',
                                url: init.split_url,
                                method: 'open',
                                auth: 'split',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }, {
                                text: '交稿',
                                url: init.deliver_url,
                                method: 'request',
                                auth: 'deliver',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }
                            ],
                            'edit']
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                , autoColumnWidth: {
                    init: true
                },
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            $('#reload').on('click', function () {
                // 表格重载
                allitemsb.reload()
            })
            $('#clear').on('click', function () {
                soulTable.clearCache(allitemsb.config.id)
                layer.msg('已还原！', {icon: 1, time: 1000})
            })
            ea.listen();
        },
        handover: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.allitems/handover',
                add_url: 'project.allitems/add',
                edit_url: 'project.allitems/edit',
                delete_url: 'project.allitems/delete',
                export_url: 'project.allitems/export',
                modify_url: 'project.allitems/modify',
                deliver_url: 'project.allitems/deliver',
                m_url: 'project.allitems/m',
                general_url: 'project.allitems/general',
                batchedit_url: 'project.allitems/batchedit',
            };
            var allitemsc = ea.table.render({
                init: init,
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',

                    [{
                        text: '批量编辑',
                        url: init.batchedit_url,
                        method: 'open',
                        checkbox: 'true',
                        auth: 'add',
                        class: 'layui-btn layui-btn-normal layui-btn-sm',
                    }],

                ],
                text: {none: '无数据'},
                cols: [[
                    {field: 'customer_file_code', title: '文件编号', fixed: true, width: 200},
                    {type: 'checkbox', fixed: true,},
                    {field: 'id', title: 'id'},
                    {field: 'customer_file_name', title: '文件名称', edit: true, sort: true},
                    {field: 'contract.company_name', title: '公司名称', edit: true, sort: true},
                    {field: 'type.content', title: '类型', search: 'false',},
                    {field: 'page', title: '页数', edit: true, search: 'false'},
                    {field: 'number_of_words', title: '源语数量', edit: true, search: 'false'},
                    {field: 'service', title: '服务', search: 'false'},
                    {field: 'yz.content', title: '语种', search: 'false',},
                    {field: 'customer_submit_date', title: '客户期望提交日期', search: 'false'},
                    {field: 'completion_date', title: '交付日期', search: 'false'},
                    {field: 'xm.username', title: '项目经理', search: 'false'},
                    {field: 'assistant.username', title: '项目助理', search: 'false'},
                    {
                        field: 'cooperation_first',
                        search: 'select',
                        selectList: {"1": "yes", "2": "no", "0": "N\/A"},
                        title: '是否首次合作'
                    },
                    {field: 'tyevel.content', title: '排版难易度', search: 'false'},
                    {field: 'trevel.content', title: '翻译难易度', search: 'false'},
                    {field: 'file_cate', title: '文件分类', search: 'false'},
                    {field: 'translation_id', title: '翻译', search: 'false'},
                    {field: 'tr_start_time', title: '翻译开始时间', search: 'false'},
                    {field: 'tr_end_time', title: '翻译交付时间', search: 'false'},
                    {field: 'proofreader_id', title: '校对', search: 'false'},
                    {field: 'pr_start_time', title: '校对开始时间', search: 'false'},
                    {field: 'pr_end_time', title: '校对交付时间', search: 'false'},
                    {field: 'before_ty_id', title: '预排版', search: 'false'},
                    {field: 'before_ty_time', title: '预排版交付时间', search: 'false'},
                    {field: 'after_ty_id', title: '后排版', search: 'false'},
                    {field: 'after_ty_time', title: '后排版交付时间', search: 'false'},
                    {field: 'quality', title: '质量要求', search: 'false'},
                    {field: 'contract.customer_contact', title: '客户联系人', search: 'false', hide: true},
                    {field: 'customer_file_request', title: '客户要求', 'hide': true, search: 'false'},
                    {field: 'customer_file_reference', title: '参考文件', 'hide': true, search: 'false'},
                    {field: 'm_approval', title: '项目经理批准', 'hide': true, search: 'false'},
                    {field: 'general_approval', title: '总经理批准', 'hide': true, search: 'false'},
                    {field: 'customer_file_remark', title: '备注', 'hide': true, search: 'false'},
                    {
                        width: 250, title: '操作', templet: ea.table.tool, fixed: "right", operat: [

                            'edit']
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                }
                , autoColumnWidth: {
                    init: true
                },
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });
            $('#reload').on('click', function () {
                // 表格重载
                allitemsc.reload()
            })
            $('#clear').on('click', function () {
                soulTable.clearCache(allitemsc.config.id)
                layer.msg('已还原！', {icon: 1, time: 1000})
            })
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

