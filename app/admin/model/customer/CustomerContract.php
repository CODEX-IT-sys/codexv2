<?php

namespace app\admin\model\customer;

use app\admin\model\MainCompany;
use app\admin\model\setting\DatabaseContent;
use app\admin\model\SystemAdmin;
use app\common\model\TimeModel;

class CustomerContract extends TimeModel
{

    protected $name = "customer_contract";

    protected $deleteTime = false;
//    设置时间
    protected $dateFormat = 'Y-m-d';

    //关联客户
    public function customerInformation()
    {
        return $this->belongsTo('app\admin\model\customer\Customer', 'customer_id', 'id');
    }
//
//    public function cate()
//{
//    return $this->belongsTo('app\admin\model\MallCate', 'cate_id', 'id');
//}


    public function getInvoicingRulesList()
    {
        return ['1' => '专票', '2' => '普票', '0' => 'N/A',];
    }

    public function getConfidentialityAgreementList()
    {
        return ['1' => 'yes', '2' => 'no', '0' => 'N/A',];
    }

    protected $type = [
        'effective_date' => 'timestamp',
        'expiration_date' => 'timestamp',
    ];

    //关联销售
    public function sale()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'sales_id', 'id');
    }

    //关联公司
    public function company()
    {
        return $this->belongsTo('app\admin\model\MainCompany', 'company_id', 'id');
    }
    //关联录入人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'writer_id', 'id');
    }
    //关联单位
    public function dw()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'unit', 'id');
    }
    //关联币种
    public function bz()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'currency', 'id');
    }
    //关联语种
    public function yz()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'language', 'id');
    }
    //关联服务
    public function fw()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'service', 'id');
    }
    //
    //添加两个字段;
    protected $append = ['remaining', 'status'];

    //获取数据时自动添加字段
    public function getRemainingAttr($value, $data)
    {
        return intval(($data['expiration_date'] - time()) / 86400);
    }

    public function getStatusAttr($value, $data)
    {
        if (intval(($data['expiration_date'] - time()) / 86400) < 0) {
            return '无效';
        } else {
            return '有效';
        }
    }

    public static function onBeforeWrite($model)
    {
        $a = Customer::where('id', $model->customer_id)->value('company_code');
        $model->contract_code = 'C-' . $a . date("Ymd");
//        dump($model);die;
    }


}