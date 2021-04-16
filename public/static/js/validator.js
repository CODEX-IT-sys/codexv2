// 策略对象
var strategies = {
    require: function (value, errorMsg) {
        return value === '' ? errorMsg : void 0;
    },

    max: function (value, length, errorMsg) {
        return value.length > length ? errorMsg : void 0;
    },

    length: function (value, length, errorMsg) {
        var index = length.indexOf(',');
        if (index !== -1) {
            var lengthArr = length.split(',');
            return value.length < lengthArr[0] || value.length > lengthArr[1] ? errorMsg : void 0;
        }

        return value.length !== parseInt(length) ? errorMsg : void 0;
    },

    in: function (value, range, errorMsg) {
        return range.split(',').indexOf(value) === -1 ? errorMsg : void 0;
    },

    gt: function (value, number, errorMsg) {
        return value <= number ? errorMsg : void 0;
    },

    phone: function (value, errorMsg) {
        return !/^(?:(?:(?:\d{0,3}-)?\d{8})|(?:\d{11}))$/.test(value) ? errorMsg : void 0;
    },

    email: function (value, errorMsg) {
        return !/^([a-zA-Z0-9_.\-])+@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value) ? errorMsg : void 0;
    },

    price: function (value, errorMsg) {
        return !/((^[1-9]\d*)|^0)(\.\d{0,2}){0,1}$/.test(value) ? errorMsg : void 0;
    },

    confirm: function (value, confirmValue, errorMsg) {
        return value !== confirmValue ? errorMsg : void 0;
    },

    zhName: function (value, errorMsg) {
        return !/^[\u4e00-\u9fa5]+(?:·[\u4e00-\u9fa5]+)?$/.test(value) ? errorMsg : void 0;
    },

    alphaNum: function (value, errorMsg) {
        return !/^[a-zA-Z0-9]+$/.test(value) ? errorMsg : void 0;
    },

    isNum: function (value, errorMsg) {
        return !/^\d+$/.test(value) ? errorMsg : void 0;
    },

    chs: function (value, errorMsg) {
        return !/^[\u4e00-\u9fa5]+$/.test(value) ? errorMsg : void 0;
    },

    variate: function (value, errorMsg) {
        return !/^[a-zA-Z]{1}\w*$/.test(value) ? errorMsg : void 0;
    }
};

// Validator类
function Validator() {
    this.cache = [];  // 保存验证规则
}

Validator.prototype = {
    add: function (name, rules) {
        var inputEle = $('[name=' + name + ']');
        var inputVal = $.trim(inputEle.val());

        if (rules[0].rule !== 'require') {
            if (inputVal === '') {
                return;
            }
        }

        var validator = this;
        for (var i = 0, len = rules.length; i < len; i++) {
            (function () {
                var ruleObj = rules[i];

                var strategyArr = ruleObj.rule.split(':');
                if (strategyArr[0] === 'confirm') {
                    strategyArr[1] = $('[name=' + name + '_confirm]').val();
                }

                validator.cache.push(function () {
                    var strategy = strategyArr.shift();

                    strategyArr.unshift(inputVal);
                    strategyArr.push(ruleObj.msg);

                    return strategies[strategy].apply(inputEle, strategyArr);
                });
            })();
        }
    },

    start: function () {
        for (var i = 0, len = this.cache.length; i < len; i++) {
            var validatorFunc = this.cache[i];

            var errorMsg = validatorFunc();
            if (errorMsg) {
                return errorMsg;
            }
        }
    }
};