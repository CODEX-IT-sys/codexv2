$(function () {
    // 顶部悬浮下拉菜单，需要用到element模块
    // iframe中用到的layer基本来自于顶级页面
    layui.use(['element', 'layer']);

    // 菜单栏选中状态
    $('.hn_menu .layui-nav li dl dd').each(function () {
        $(this).click(function () {
            $(this).parents('li').addClass('layui-this');
        })
    });

    // iframe引入
    $(".hn_menu .layui-nav li a").on("click", function () {
        let address = $(this).attr("lay-href");
        $("iframe").attr("src", address);
    });

    // 折叠菜单栏
    $('.folded_btn').click(function () {
        $(this).toggleClass("foldedIn");
        $(".hnBox").toggleClass("hnBox_folded");
    });
});

