<?php

namespace app\admin\model\customer;

use app\admin\model\SystemAdmin;
use app\common\model\TimeModel;

class Customer extends TimeModel
{

    protected $name = "customer_information";

    protected $deleteTime = false;


    // 设置废弃字段
    protected $disuse = [ 'contract_code',];
    //关联录入人
    public function write()
    {
        return $this->belongsTo(SystemAdmin::class, 'writer_id', 'id');
    }
    

}