<?php

namespace app\admin\model\customer;

use app\common\model\TimeModel;
use think\model\concern\SoftDelete;
class Customerqingkuan extends TimeModel
{

    protected $name = "customer_qingkuan";

    protected $deleteTime = "delete_time";

    use SoftDelete;

//    protected $deleteTime = false;

    //关联录入人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'write_id', 'id');
    }
    //关联客户信息
    public function customerInformation()
    {
        return $this->belongsTo('app\admin\model\customer\Customer', 'customer_id', 'id');
    }
    //关联合同
    public function contract()
    {
        return $this->belongsTo('app\admin\model\customer\CustomerContract', 'contract_id', 'id');
    }
    public function company()
    {
        return $this->belongsTo('app\admin\model\MainCompany', 'company_id', 'id');
    }



}