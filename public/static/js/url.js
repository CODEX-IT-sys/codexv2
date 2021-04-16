/**
 * 替换url的参数（可替换多个参数，但不适用与edit地址）
 * @param url url地址
 * @returns string
 */
function replaceUrlParam(url) {
    // 新的参数值
    var params = [].slice.call(arguments, 1);

    // 把url用斜杠分割成数组
    var urlElements = url.split('/');

    // 去掉旧的参数值
    urlElements.splice(urlElements.length - params.length, params.length);

    // 把新的参数加入到url数组中
    for (var k in params) {
        urlElements.push(params[k]);
    }

    // 返回拼接后的url地址
    return urlElements.join('/');
}

/**
 * 替换edit地址的url参数（只能替换一个参数）
 * @param url
 * @param id
 * @returns {void|string|*}
 */
function replaceEditUrlId(url, id) {
    return url.replace(/\d+/, id);
}

/**
 * 拼接url参数
 * @param url
 * @param param
 * @returns {string|*}
 */
function addUrlParam(url, param) {
    var names = Object.keys(param);

    if (Object.keys(names).length === 0) {
        return url;
    }

    url = url + '?';

    names.forEach(function (name) {
        url += name + '=' + param[name] + '&';
    });

    return url.slice(0, -1);
}