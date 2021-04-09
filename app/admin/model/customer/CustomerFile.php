<?php

namespace app\admin\model\customer;

use app\common\model\TimeModel;

class CustomerFile extends TimeModel
{

    protected $name = "customer_file";

    protected $deleteTime = false;

    protected $type = [
        'customer_submit_date' => 'timestamp',
    ];

    public function demand()
    {
        return $this->belongsTo('app\admin\model\customer\CustomerDemand', 'demand_id', 'id');

    }
}