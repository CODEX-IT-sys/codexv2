<?php

namespace app\admin\model\customer;

use app\admin\model\MainCompany;
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
        return $this->belongsTo(Customer::class, 'customer_id', 'id');
    }


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
        return $this->belongsTo(SystemAdmin::class, 'sales_id', 'id');
    }

    //关联公司
    public function company()
    {
        return $this->belongsTo(MainCompany::class, 'company_id', 'id');
    }
    //关联录入人
    public function write()
    {
        return $this->belongsTo(SystemAdmin::class, 'writer_id', 'id');
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