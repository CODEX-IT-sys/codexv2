<?php

namespace app\admin\model\customer;

use app\admin\model\SystemAdmin;
use app\common\model\TimeModel;

//来稿需求
class CustomerDemand extends TimeModel
{

    protected $name = "customer_demand";

    protected $deleteTime = false;

    public function getCooperationFirstList()
    {
        return ['1' => 'yes', '2' => 'no', '0' => 'N/A',];
    }

    protected $dateFormat = 'Y-m-d';
    protected $type = [
        'submission_time' => 'timestamp',
    ];

    //合同关联
    public function contract()
    {
        return $this->belongsTo('app\admin\model\customer\CustomerContract', 'contract_id', 'id');
    }

    //录入人关联
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'demand_writer_id', 'id');
    }

    //项目经理
    public function xm()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'mid', 'id');
    }

    //关联公司
    public function company()
    {
        return $this->belongsTo('app\admin\model\MainCompany', 'company_id', 'id');
    }

    //关联客户
    public function customerInformation()
    {
        return $this->belongsTo('app\admin\model\customer\Customer', 'customer_id', 'id');
    }

    //关联单位
    public function dw()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'unit', 'id');
    }

    //关联文件
    public function file()
    {
        return $this->hasMany('app\admin\model\setting\Customeraa', 'demand_id', 'id');
    }


}