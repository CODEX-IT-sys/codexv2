<?php

namespace app\admin\model\customer;

use app\admin\model\SystemAdmin;
use app\common\model\TimeModel;
use think\model\concern\SoftDelete;
//报价单
class CustomerqQuotation extends TimeModel
{

    protected $name = "customer_quotation";
    use SoftDelete;
    protected $deleteTime = 'delete_time';
//    protected $deleteTime = false;



    //关联录入人
    public function write()
    {
        return $this->belongsTo(SystemAdmin::class, 'writer_id', 'id');
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