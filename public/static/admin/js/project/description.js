define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.description/index',
        add_url: 'project.description/add',
        edit_url: 'project.description/edit',
        delete_url: 'project.description/delete',
        export_url: 'project.description/export',
        modify_url: 'project.description/modify',
        comment_url: 'project.description/comment',
    };
    var soulTable = layui.soulTable;
    var Controller = {
        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                fixResize: false,
                toolbar: ['refresh', 'delete'],
                text: {none: '无数据'},
                cols: [[
                    {type: 'checkbox', fixed: 'left'},
                    {field: 'id', title: 'id', search: false, fixed: 'left'},
                    {
                        field: 'description_status',
                        search: 'select',
                        selectList: {"1": "待翻译", "2": "待校对", "0": "待预排", '3': "待后排", '4': "已完成"},
                        title: '文件状态',
                        sort: true,
                        fixed: 'left'
                    },
                    {field: 'file_name_project', title: '文件名称', fixed: 'left'},
                    {field: 'file_code_project', title: '文件编号', fixed: 'left'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {
                        title: '翻译人员', templet: function (d) {
                            if (d.tr == null) {
                                return ''
                            } else {
                                return d.tr.username
                            }
                        }
                    },
                    {field: 'tr_start_time', title: '翻译开始时间', search: false},
                    {field: 'tr_end_time', title: '翻译结束时间', search: false},
                    {
                        title: '校对', templet: function (d) {
                            if (d.xd == null) {
                                return ''
                            } else {
                                return d.xd.username
                            }
                        }
                    },
                    {field: 'pr_start_time', title: '校对开始时间', search: false},
                    {field: 'pr_end_time', title: '校对结束时间', search: false},
                    {
                        title: '预排人员', templet: function (d) {
                            if (d.yp == null) {
                                return ''
                            } else {
                                return d.yp.username
                            }
                        }
                    },
                    {field: 'be_start_time', title: '预排开始时间', search: false},
                    {field: 'be_end_time', title: '预排结束时间', search: false},
                    {
                        title: '后排人员', templet: function (d) {
                            if (d.hp == null) {
                                return ''
                            } else {
                                return d.hp.username
                            }
                        }
                    },
                    {field: 'after_start_time', title: '后排开始时间', search: false},
                    {field: 'after_end_time', title: '后排结束时间', search: false},
                    {field: 'project_page', title: '页数', search: false},
                    {field: 'project_words_actual', title: '源语数量', search: false},
                    {field: 'repetition_rate95', title: '95%~99%总重复率', search: false},
                    {field: 'repetition_rate100', title: '100%重复率', search: false},
                    {field: 'deduction_number', title: '扣除字数', search: false},
                    {field: 'repetition_rateall', title: '总重复率', search: false},
                    {field: 'number_of_words_actual', title: '实际源语数量', search: false},
                    {field: 'final_delivery_time', title: '最终交付时间', search: false},
                    {field: 'assignor.username', title: '项目助理'},
                    {field: 'file_specification', title: '文件用途和规范', search: false},
                    {field: 'related_products', title: '涉及产品', search: false},

                    {field: 'create_time', title: '创建时间', search: false},
                    {
                        width: 250, title: '操作', fixed: "right", templet: ea.table.tool, operat: [
                            [{
                                text: '留言',
                                url: init.comment_url,
                                method: 'open',
                                auth: 'comment',
                                extend: 'data-full="true"',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }],
                            'edit', 'delete']
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },

                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        nostarttime: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.description/nostarttime',
                add_url: 'project.description/add',
                edit_url: 'project.description/edit',
                delete_url: 'project.description/delete',
                export_url: 'project.description/export',
                modify_url: 'project.description/modify',
                assessyp_url: 'project.assess/assessyp',
                assesshp_url: 'project.assess/assesshp',
                assesstr_url: 'project.assess/assesstr',
            };
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id', search: false},
                    {field: 'file_name_project', title: '文件名称'},
                    {field: 'file_code_project', title: '文件编号'},
                    {
                        field: 'description_status',
                        search: 'select',
                        selectList: {"1": "待翻译", "2": "待校对", "0": "待预排", '3': "待后排", '4': "已完成"},
                        title: '文件状态',
                        sort: true
                    },
                    {field: 'basic.project_name', title: '项目名称'},
                    {
                        title: '翻译人员', templet: function (d) {
                            if (d.tr == null) {
                                return ''
                            } else {
                                return d.tr.username
                            }
                        }
                    },
                    {field: 'tr_end_time', title: '翻译结束时间', search: false},
                    {
                        title: '校对', templet: function (d) {
                            if (d.xd == null) {
                                return ''
                            } else {
                                return d.xd.username
                            }
                        }
                    },
                    {field: 'pr_end_time', title: '校对结束时间', search: false},
                    {
                        title: '预排人员', templet: function (d) {
                            if (d.yp == null) {
                                return ''
                            } else {
                                return d.yp.username
                            }
                        }
                    },
                    {field: 'be_end_time', title: '预排结束时间', search: false},
                    {
                        title: '后排人员', templet: function (d) {
                            if (d.hp == null) {
                                return ''
                            } else {
                                return d.hp.username
                            }
                        }
                    },
                    {field: 'after_end_time', title: '后排结束时间', search: false},
                    {field: 'project_page', title: '页数', search: false},
                    {field: 'project_words_actual', title: '源语数量', search: false},
                    {field: 'repetition_rate95', title: '95%~99%总重复率', search: false},
                    {field: 'repetition_rate100', title: '100%重复率', search: false},
                    {field: 'deduction_number', title: '扣除字数', search: false},
                    {field: 'repetition_rateall', title: '总重复率', search: false},
                    {field: 'number_of_words_actual', title: '实际源语数量', search: false},
                    // {field: 'final_delivery_time', title: '最终交付时间',search:false},
                    {field: 'assignor.username', title: '项目助理'},
                    {field: 'create_time', title: '创建时间', search: false},
                    {
                        width: 250, title: '操作', fixed: "right", templet: ea.table.tool, operat: [
                            [{
                                text: '预排评估',
                                url: init.assessyp_url,
                                method: 'open',
                                auth: 'assessyp',

                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            },
                                {
                                    text: '翻译评估',
                                    url: init.assesstr_url,
                                    method: 'open',
                                    auth: 'assesstr',

                                    class: 'layui-btn layui-btn-xs layui-btn-normal',
                                },
                                {
                                    text: '后排评估',
                                    url: init.assesshp_url,
                                    method: 'open',
                                    auth: 'assesshp',

                                    class: 'layui-btn layui-btn-xs layui-btn-normal',
                                }],
                        ]
                    },
                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },
                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        yp: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.description/yp',
                add_url: 'project.description/add',
                edit_url: 'project.description/edit',
                delete_url: 'project.description/delete',
                export_url: 'project.description/export',
                modify_url: 'project.description/modify',
                schedule_url: 'project.schedule/ypindex',
                comment_url: 'project.description/comment',
                ypstock_url: 'project.description/ypstock',
            }
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id', search: false},
                    {field: 'file_name_project', title: '文件名称'},
                    {field: 'file_code_project', title: '文件编号'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {
                        title: '预排人员', templet: function (d) {
                            if (d.yp == null) {
                                return ''
                            } else {
                                return d.yp.username
                            }
                        }
                    },
                    {field: 'be_start_time', title: '预排开始时间', search: false},
                    {field: 'be_end_time', title: '预排结束时间', search: false},
                    {field: 'project_page', title: '页数', search: false},
                    {field: 'project_words_actual', title: '源语数量', search: false},
                    {field: 'repetition_rate95', title: '95%~99%总重复率', search: false},
                    {field: 'repetition_rate100', title: '100%重复率', search: false},
                    {field: 'deduction_number', title: '扣除字数', search: false},
                    {field: 'repetition_rateall', title: '总重复率', search: false},
                    {field: 'number_of_words_actual', title: '实际源语数量', search: false},
                    {field: 'final_delivery_time', title: '最终交付时间', search: false},
                    {field: 'assignor.username', title: '项目助理'},
                    {field: 'create_time', title: '创建时间', search: false},
                    {
                        width: 250, title: '操作', fixed: "right", templet: ea.table.tool, operat: [
                            [{
                                text: '进度',
                                url: init.schedule_url+'?type=1',
                                method: 'open',
                                auth: 'schedule',
                                class: 'layui-btn layui-btn-xs layui-btn-success',
                                extend: 'data-full="true"',
                            }, {
                                text: '留言',
                                url: init.comment_url,
                                method: 'open',
                                auth: 'comment',
                                extend: 'data-full="true"',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            },
                                {
                                    text: '预排完成',
                                    url: init.ypstock_url,
                                    method: 'request',
                                    auth: 'ypstock',
                                    class: 'layui-btn layui-btn-xs layui-btn-normal',
                                }],
                        ]
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },

                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        tr: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.description/tr',
                add_url: 'project.description/add',
                edit_url: 'project.description/edit',
                delete_url: 'project.description/delete',
                export_url: 'project.description/export',
                modify_url: 'project.description/modify',
                schedule_url: 'project.schedule/trindex',
                comment_url: 'project.description/comment',
                trstock_url: 'project.description/trstock',
            }
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id', search: false},
                    {field: 'file_name_project', title: '文件名称'},
                    {field: 'file_code_project', title: '文件编号'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {
                        title: '翻译人员', templet: function (d) {
                            if (d.tr == null) {
                                return ''
                            } else {
                                return d.tr.username
                            }
                        }
                    },
                    {field: 'tr_start_time', title: '翻译开始时间', search: false},
                    {field: 'tr_end_time', title: '翻译结束时间', search: false},
                    {field: 'project_page', title: '页数', search: false},
                    {field: 'project_words_actual', title: '源语数量', search: false},
                    {field: 'repetition_rate95', title: '95%~99%总重复率', search: false},
                    {field: 'repetition_rate100', title: '100%重复率', search: false},
                    {field: 'deduction_number', title: '扣除字数', search: false},
                    {field: 'repetition_rateall', title: '总重复率', search: false},
                    {field: 'number_of_words_actual', title: '实际源语数量', search: false},
                    {field: 'final_delivery_time', title: '最终交付时间', search: false},
                    {field: 'assignor.username', title: '项目助理'},
                    {field: 'create_time', title: '创建时间', search: false},
                    {
                        width: 250, title: '操作', fixed: "right", templet: ea.table.tool, operat: [
                            [{
                                text: '进度',
                                url: init.schedule_url+'?type=2',
                                method: 'open',
                                auth: 'schedule',
                                class: 'layui-btn layui-btn-xs layui-btn-success',
                                extend: 'data-full="true"',
                            }, {
                                text: '留言',
                                url: init.comment_url,
                                method: 'open',
                                auth: 'comment',
                                extend: 'data-full="true"',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            },
                                {
                                    text: '翻译完成',
                                    url: init.trstock_url,
                                    method: 'request',
                                    auth: 'trstock',
                                    class: 'layui-btn layui-btn-xs layui-btn-normal',
                                }],
                        ]
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },

                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        xd: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.description/xd',
                add_url: 'project.description/add',
                edit_url: 'project.description/edit',
                delete_url: 'project.description/delete',
                export_url: 'project.description/export',
                modify_url: 'project.description/modify',
                schedule_url: 'project.schedule/trindex',
                comment_url: 'project.description/comment',
                xdstock_url: 'project.description/xdstock',
            }
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id', search: false},
                    {field: 'file_name_project', title: '文件名称'},
                    {field: 'file_code_project', title: '文件编号'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {
                        title: '校对', templet: function (d) {
                            if (d.xd == null) {
                                return ''
                            } else {
                                return d.xd.username
                            }
                        }
                    },
                    {field: 'pr_start_time', title: '校对开始时间', search: false},
                    {field: 'pr_end_time', title: '校对结束时间', search: false},
                    {field: 'project_page', title: '页数', search: false},
                    {field: 'project_words_actual', title: '源语数量', search: false},
                    {field: 'repetition_rate95', title: '95%~99%总重复率', search: false},
                    {field: 'repetition_rate100', title: '100%重复率', search: false},
                    {field: 'deduction_number', title: '扣除字数', search: false},
                    {field: 'repetition_rateall', title: '总重复率', search: false},
                    {field: 'number_of_words_actual', title: '实际源语数量', search: false},
                    {field: 'final_delivery_time', title: '最终交付时间', search: false},
                    {field: 'assignor.username', title: '项目助理'},
                    {field: 'create_time', title: '创建时间', search: false},
                    {
                        width: 250, title: '操作', fixed: "right", templet: ea.table.tool, operat: [
                            [{
                                text: '进度',
                                url: init.schedule_url+'?type=3',
                                method: 'open',
                                auth: 'schedule',
                                class: 'layui-btn layui-btn-xs layui-btn-success',
                                extend: 'data-full="true"',
                            }, {
                                text: '留言',
                                url: init.comment_url,
                                method: 'open',
                                auth: 'comment',
                                extend: 'data-full="true"',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }, {
                                text: '校对完成',
                                url: init.xdstock_url,
                                method: 'request',
                                auth: 'xdstock',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }],
                        ]
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },

                done: function () {
                    // 在 done 中开启
                    soulTable.render(this)
                }
            });

            ea.listen();
        },
        hp: function () {
            var init = {
                table_elem: '#currentTable',
                table_render_id: 'currentTableRenderId',
                index_url: 'project.description/hp',
                add_url: 'project.description/add',
                edit_url: 'project.description/edit',
                delete_url: 'project.description/delete',
                export_url: 'project.description/export',
                modify_url: 'project.description/modify',
                schedule_url: 'project.schedule/ypindex',
                comment_url: 'project.description/comment',
                hpstock_url: 'project.description/hpstock',
            }
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                size: 'sm', //小尺寸的表格
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id', search: false},
                    {field: 'file_name_project', title: '文件名称'},
                    {field: 'file_code_project', title: '文件编号'},
                    {field: 'basic.project_name', title: '项目名称'},
                    {
                        title: '后排人员', templet: function (d) {
                            if (d.hp == null) {
                                return ''
                            } else {
                                return d.hp.username
                            }
                        }
                    },
                    {field: 'after_start_time', title: '后排开始时间', search: false},
                    {field: 'after_end_time', title: '后排结束时间', search: false},
                    {field: 'project_page', title: '页数', search: false},
                    {field: 'project_words_actual', title: '源语数量', search: false},
                    {field: 'repetition_rate95', title: '95%~99%总重复率', search: false},
                    {field: 'repetition_rate100', title: '100%重复率', search: false},
                    {field: 'deduction_number', title: '扣除字数', search: false},
                    {field: 'repetition_rateall', title: '总重复率', search: false},
                    {field: 'number_of_words_actual', title: '实际源语数量', search: false},
                    {field: 'final_delivery_time', title: '最终交付时间', search: false},
                    {field: 'assignor.username', title: '项目助理'},
                    {field: 'create_time', title: '创建时间', search: false},
                    {
                        width: 250, title: '操作', fixed: "right", templet: ea.table.tool, operat: [
                            [{
                                text: '进度',
                                url: init.schedule_url+'?type=4',
                                method: 'open',
                                auth: 'schedule',
                                class: 'layui-btn layui-btn-xs layui-btn-success',
                                extend: 'data-full="true"',
                            }, {
                                text: '留言',
                                url: init.comment_url,
                                method: 'open',
                                auth: 'comment',
                                extend: 'data-full="true"',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }, {
                                text: '后排完成',
                                url: init.hpstock_url,
                                method: 'request',
                                auth: 'hpstock',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                            }],
                        ]
                    },

                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                autoColumnWidth: {
                    init: true
                },

                done: function () {
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
