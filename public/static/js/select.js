// 根据获取的数据，重置下拉框的选项
function appendSelectOption(jQueryElement, optionData, layuiForm) {
    let optionHtml = '';
    optionData.forEach(function (item) {
        optionHtml += '<option value = "' + item.id + '">' + item.name + '</option>';
    });

    jQueryElement.append(optionHtml);
    jQueryElement.next().is(':hidden') && jQueryElement.next().show();

    layuiForm.render('select');
}

// 删除下拉框第一个之外的所有选项
function removeSelectOption(layuiForm) {
    for (var i = 1; i < arguments.length; i++) {
        arguments[i].find('option:gt(0)').remove();
    }

    layuiForm.render('select');
}

// 隐藏下拉框
function hiddenSelect(layuiForm) {
    for (var i = 0; i < arguments.length; i++) {
        arguments[i].next().hide();
    }
}