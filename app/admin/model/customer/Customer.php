<?php

namespace app\admin\model\customer;

use app\admin\model\SystemAdmin;
use app\common\model\TimeModel;

class Customer extends TimeModel
{

    protected $name = "customer_information";

    protected $deleteTime = false;
//    设置时间
    protected $dateFormat = 'Ymd';
    // 定义时间戳字段名
    protected $createTime = 'customercreate_at';
    protected $updateTime = 'customerupdate_at';

    // 设置废弃字段
    protected $disuse = [ 'contract_code',];
    //关联录入人
    public function write()
    {
        return $this->belongsTo(SystemAdmin::class, 'information_writer_id', 'id');
    }

    public function contract()
    {
        return $this->belongsTo(CustomerContract::class, 'contract_id', 'id');
    }

    

}