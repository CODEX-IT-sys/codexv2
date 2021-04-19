<?php

namespace app\admin\model;

use app\common\model\TimeModel;
use think\model\concern\SoftDelete;
class CustomerFilaa extends TimeModel
{

    protected $name = "customer_filaa";
    use SoftDelete;
    protected $deleteTime = 'delete_time';
//    protected $deleteTime = false;
    protected $type = [
        'customer_submit_date' => 'timestamp',
    ];

    public function getServiceAttr($val)
    {
        return explode(",", $val);
    }
    public function getFileStatusList()
    {

        $status = ['1'=>'接受','2'=>'拒绝','0'=>'未确定',];
        return $status;
    }
    //关联来稿需求
    public function demand()
    {
        return $this->belongsTo('app\admin\model\customer\CustomerDemand', 'demand_id', 'id');
    }
    //关联文件类型
    public function type()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'customer_file_type', 'id');
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
    //关联税率
    public function rate()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'tax_rate', 'id');
    }

    //关联大内
    public function dw()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'unit', 'id');
    }
    //关联客户信息
    public function customerInformation()
    {
        return $this->belongsTo('app\admin\model\customer\Customer', 'customer_id', 'id');
    }

}