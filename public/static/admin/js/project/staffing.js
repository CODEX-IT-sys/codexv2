define(["jquery", "easy-admin"], function ($, ea) {

    var init = {
        table_elem: '#currentTable',
        table_render_id: 'currentTableRenderId',
        index_url: 'project.staffing/index',
        rc_url: 'project.staffing/rc',

    };
    var soulTable = layui.soulTable;
    var Controller = {

        index: function () {
            ea.table.render({
                init: init,
                overflow: 'tips',
                skin: 'line  ' //行边框风格
                , even: true, //开启隔行背景
                toolbar: ['refresh',],
                cols: [[
                    {type: 'checkbox'},
                    {field: 'id', title: 'id'},
                    {field: 'username', title: '姓名'},
                    {field: 'auth', title: '职位',search:false},
                    {width: 250, title: '操作', templet: ea.table.tool,
                        operat: [
                            [ {
                                text: '人员日程',
                                url: init.rc_url,
                                method: 'open',
                                auth: 'rc',
                                class: 'layui-btn layui-btn-xs layui-btn-normal',
                                extend: 'data-full="true"',
                            }],
                           ]},
                ]],
                filter: {
                    items: ['column', 'data', 'condition', 'editCondition', 'excel', 'clearCache'],
                    cache: true
                },
                // autoColumnWidth: {
                //     init: true
                // },

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

layui.use(['table','form'], function(){
    var table = layui.table, form = layui.form;
    var field = '{$field}'; var keyword = '{$keyword}';
    // 切换语言
    var language = "{:session('language') == '中文'? '中文' : 'english'}";
    // 数据表格字段
    var data = '{$colsData|raw}';
    var colsData = JSON.parse(data);

    // 通用表头生成器
    function commonCols(language,colsData){
        // 左侧勾选栏
        var cols = [{type: 'checkbox', fixed: 'left'}];
        var l = colsData.length;

        // 遍历所有字段
        for(var i = 0; i < l; i++){
            if(colsData[i].Field !== 'delete_time'){
                if(colsData[i].Field !== 'id'){
                    if(language === '中文'){
                        cols.push({field: colsData[i].Field ,title: colsData[i].Comment, sort:true, minWidth:180, totalRow:true});
                    }else{
                        cols.push({field: colsData[i].Field ,title: colsData[i].Field, sort:true, minWidth:200, totalRow:true});
                    }
                }
            }
        }
        // 右侧操作工具
        if(language === '中文') {
            cols.push({fixed: 'right', title: '操作', align: 'center', toolbar: '#barDemo', width: 150});
        }else{
            cols.push({fixed: 'right', title: 'Action', align: 'center', toolbar: '#barDemo', width: 150});
        }

        return [cols];
    }
    var search_type = '{$search_type}';
    // 生成表格
    tableIns = table.render({
        elem: '#test'
        ,url:"{:url('index')}"
        ,where: {field: field, keyword: keyword,search_type:search_type}
        ,toolbar: '#forwardBar'
        ,defaultToolbar: ['filter', 'exports', 'print']
        ,title: '每日进度（翻译校对）表'
        ,cols : commonCols(language, colsData)
        ,page: true, limit:50, 			height: 'full-200',
        even: true
    });

    // 回车亦可以搜索
    $(document).keyup(function (event) {
        if (event.keyCode == 13) {
            $(".search_btn").trigger("click");
        }
    });

    // 表头搜索
    $('.search_btn').click(function () {

        var searchfield = $('#field').val();
        var searchkeyword = $.trim($('#keyword').val());

        if (!searchkeyword) {
            if(language === '中文') {
                layer.msg('搜索内容不能为空');
            }else{
                layer.msg('Please input keyword');
            }
            return false;
        }
        // 页面 带参跳转 可以记住搜索参数
        window.location.href = "{:url('index')}" + '?field=' + searchfield + '&keyword=' + searchkeyword;

        // 表格重载
        /*table.reload('test', {
         url: "{:url('index')}",
         where: {field: searchfield, keyword: searchkeyword},  // 设定异步数据接口的额外参数
         page: true, limit:50
         });*/
    });

    // 多条件 搜索弹框
    $(function(){
        var index;
        $(".addCondition").live("click",function(){
            index = parent.layer.open({ //在父窗口打开
                type: 2,
                title: '条件查询',
                maxmin: true,
                shadeClose: true, //点击遮罩关闭层
                area : ['700px' , '560px'],
                content: "{:url('pj_daily_progress_tr_re/condition')}",
                end: function () {
                    var search_type = localStorage.getItem('search_type');
                    var s = localStorage.getItem('field');
                    var i = localStorage.getItem('keyword');
                    window.location.href = "{:url('index')}" + '?field=' + s + '&keyword=' + i + '&search_type=' + search_type;
                    // 表格重载
                    // table.reload('test', {
                    // 	url: "{:url('pj_daily_progress_tr_re/index')}",
                    // 	where: {search_type : search_type, field: s, keyword: i},  // 设定异步数据接口的额外参数
                    // 	page: true, limit:50
                    // });
                }
            });
        });
    });

    //批量删除(多选操作)
    $('#del').click(function () {
        var checkStatus = table.checkStatus('test');
        var idstr = ''; var cd = checkStatus.data.length;

        if(cd !== 0){
            for(var i=0; i<cd; i++){
                idstr +=  checkStatus.data[i].id + ',';
            }
            // 去除多余符号
            idstr = idstr.substring(0, idstr.length - 1);

            layer.confirm('确认删除？', function(index){
                // 向服务器发送删除请求
                $.ajax({
                    type: 'get',
                    url: "{:url('pj_daily_progress_tr_re/batchdelete')}",
                    data: {id : idstr},
                    // 删除成功
                    success: function (res) {
                        layer.alert(res.msg, {title: '提示'}, function (index) {
                            // 表格重载
                            tableIns.reload();
                            // 关闭alert
                            layer.close(index);
                        });
                    },
                    error: function (jqXHR) {
                        // 删除失败
                        if (jqXHR.status === 422) {
                            layer.alert(jqXHR.responseText, {title: '提示'}, function (index) {
                                layer.close(index);
                            });
                        }
                    }
                });
            });
        }else{
            if(language === '中文') {
                layer.alert('请先勾选要删除的数据再操作');
            }else{
                layer.msg('Please check the box before operating');
            }
        }
    });

    //监听行工具事件
    table.on('tool(test)', function(obj){
        //获得当前行数据
        var id = obj.data.id;

        // 删除
        if(obj.event === 'del'){
            layer.confirm('确认删除？', function(index){
                // 向服务器发送删除请求
                $.ajax({
                    type: 'delete',
                    contentType: 'application/json',
                    url: replaceEditUrlId("{:url('pj_daily_progress_tr_re/delete', ['id' => 1])}", id),
                    dataType: 'json',
                    // 删除成功
                    success: function (res) {
                        layer.alert(res.msg, {title: '提示'}, function (index) {
                            // 表格重载
                            tableIns.reload();
                            // 关闭alert
                            layer.close(index);
                        });
                    },
                    error: function (jqXHR) {
                        // 删除失败
                        if (jqXHR.status === 422) {
                            layer.alert(jqXHR.responseText, {title: '提示'}, function (index) {
                                layer.close(index);
                            });
                        }
                    }
                });
            });

        } else if(obj.event === 'edit'){

            window.location.href =  replaceEditUrlId("{:url('pj_daily_progress_tr_re/edit', ['id' => 1])}", id);

        } else if(obj.event === 'look'){

            window.location.href = replaceEditUrlId("{:url('pj_daily_progress_tr_re/read', ['id' => 1])}", id);
        }
    });

    /*字段筛选 全选 反选*/
    table.on('toolbar()', function (obj) {
        var config = obj.config;
        var btnElem = $(this);
        var tableId = config.id;
        var tableView = config.elem.next();
        switch (obj.event) {
            case 'LAYTABLE_COLS':
                // 给筛选列添加全选还有反选的功能
                var panelElem = btnElem.find('.layui-table-tool-panel');
                var checkboxElem = panelElem.find('[lay-filter="LAY_TABLE_TOOL_COLS"]');
                var checkboxCheckedElem = panelElem.find('[lay-filter="LAY_TABLE_TOOL_COLS"]:checked');
                $('<li class="layui-form select_lead" lay-filter="LAY_TABLE_TOOL_COLS_FORM">' +
                    '<input type="checkbox" lay-skin="primary" lay-filter="LAY_TABLE_TOOL_COLS_ALL" '+ ((checkboxElem.length === checkboxCheckedElem.length) ? 'checked' : '') + ' title="全选">' +
                    '<span class="invert_select"><i class="iconfont icon-fanxuan"></i>反选</span>' +
                    '</li>')
                    .insertBefore(panelElem.find('li').first())
                    .on('click', '.invert_select', function (event) {
                        layui.stope(event);
                        // 反选逻辑
                        panelElem.find('[lay-filter="LAY_TABLE_TOOL_COLS"]+').click();
                    });

                form.render('checkbox', 'LAY_TABLE_TOOL_COLS_FORM');
                break;
        }
    });

    // 监听筛选列panel中的全选
    form.on('checkbox(LAY_TABLE_TOOL_COLS_ALL)', function (obj) {
        $(obj.elem).closest('ul')
            .find('[lay-filter="LAY_TABLE_TOOL_COLS"]' + (obj.elem.checked ? ':not(:checked)' : ':checked') + '+').click();
    });

    // 监听筛选列panel中的单个记录的change
    $(document).on('change', 'input[lay-filter="LAY_TABLE_TOOL_COLS"]', function (event) {
        var elemCurr = $(this);
        // 筛选列单个点击的时候同步全选的状态
        $('input[lay-filter="LAY_TABLE_TOOL_COLS_ALL"]')
            .prop('checked',
                elemCurr.prop('checked') ? (!$('input[lay-filter="LAY_TABLE_TOOL_COLS"]').not(':checked').length) : false);
        form.render('checkbox', 'LAY_TABLE_TOOL_COLS_FORM');
    });

    $('#sjth').click(function () {
        var checkStatus = table.checkStatus('test');
        var num = 0
        var num2 = 0
        var num3 = 0
        var num4 = 0
        for (v in checkStatus.data) {
            num4 += checkStatus.data[v]['Actual_Work_Time']||0;
            num3 += parseInt(checkStatus.data[v]['Original_Chinese_Characters'])||0;
            num2 += parseInt(checkStatus.data[v]['Total_Chinese_Characters'])||0;
            num += parseInt(checkStatus.data[v]['Number_of_Pages_Completed'])||0;
        }
        var msg = "完成页码:" + num + ';中文字数统计:' + num2+';原总字数:'+num3+';实际用时:'+num4.toFixed(2);

        $('#jisuan').html(msg)
        layer.alert(msg);
        // console.log(num);
    });

    $('#xzedit').click(function () {

        var option =  '{foreach name="select_field" item="v" key="k"}<option value="{$v.Field}" {$field==$v.Field?\'selected\':\'\'}">  {$v.Comment}</option>{/foreach}'
        // if(option.indexOf('value="'+pid+'"') != -1){
        //     option = option.replace('value="'+pid+'"','value="'+pid+'" selected');
        // }

        var html = '';
        html +=  '<div class="layui-form-item" >'
        html +=     '<label class="layui-form-label" style="width:70px;padding:9px 5px">字段:</label>'
        html +=    '<div class="layui-input-inline ">'
        html +=         '<select name="field" lay-verify="" lay-search class="layui-input"style="margin-left:15px; width:100px;">'
        html +=             option
        html +=        '</select>'
        html +=     '</div>'
        html +=   '</div>'
        html += '<div class="layui-form-item" style="margin:15px 10px">'
        html += '  <label class="layui-form-label" style="width:70px;padding:9px 5px">修改的值：</label>'
        html += '  <div class="layui-input-block" style="margin-left:85px">'
        html += '    <input class="layui-input" style="width:70%;float:left" name="numsss" id="editstr" value="" /><span  class="h38" style="display:block;float:left;margin-left:5px;"></span>'
        html += '  </div>'
        html += '</div>'

        layer.open({
            area: ['320px', '300px'], //宽高
            title: '批量修改',
            btn: ['确定', '取消'],
            content: html,
            yes: function (index, layero) {
                var field = $('select[name="field"]').val();
                var editstr = $('input[name="numsss"]').val();
                var checkStatus = table.checkStatus('test');
                console.log(checkStatus.data)
                var arr=new Object();
                for(var i=0;i<checkStatus.data.length;i++){
                    arr[i] = checkStatus.data[i]['id']
                }
                console.log(arr);
                // 向服务器发送删除请求
                $.ajax({
                    type: 'post',
                    url: "{:url('Batch_edit')}",
                    data: {arr: arr,field:field,numsss:editstr},
                    // 删除成功
                    success: function (res) {
                        if(res.code==9999){
                            layer.msg('修改失败');
                        }else{
                            tableIns.reload();
                            layer.close(index);
                            layer.msg(res);
                        }

                    },

                });
                console.log(field);
            },
            btn2: function (index, layero) {
                layer.close(index);
            },
        });

    })

});