<?php

namespace app\admin\model\customer;

use app\common\model\TimeModel;
use think\model\concern\SoftDelete;
use think\facade\Db;
//文件模型,多对多太麻烦.直接存字符串
class Customeraa extends TimeModel
{

    protected $name = "customer_filaa";
    use SoftDelete;
    protected $deleteTime = 'delete_time';
//    protected $deleteTime = false;
    protected $type = [
        'customer_submit_date' => 'timestamp',
        'completion_date' => 'timestamp',
        'pr_start_time' => 'timestamp',
        'pr_end_time' => 'timestamp',
        'tr_start_time' => 'timestamp',
        'tr_end_time' => 'timestamp',
        'after_ty_time' => 'timestamp',
        'before_ty_time' => 'timestamp',
    ];

    public function getServiceAttr($val)
    {
        $val= explode(",", $val);
        $arr=[];
        foreach ($val as $k1 => $v1) {
            $arr[] = Db::name('database_content')->where('id', $v1)->value('content');
        }
       return  implode(",", $arr);
    }
    public function getBeforeTyIdAttr($val)
    {
//        $val= explode(",", $val);
//        $arr=[];
//        foreach ($val as $k1 => $v1) {
//            $arr[] = Db::name('database_content')->where('id', $v1)->value('content');
//        }
//        return  implode(",", $arr);
    }
    public function getAfterTyIdAttr($val)
    {
//        $val= explode(",", $val);
//        $arr=[];
//        foreach ($val as $k1 => $v1) {
//            $arr[] = Db::name('database_content')->where('id', $v1)->value('content');
//        }
//        return  implode(",", $arr);
    }
    public function getFileStatusList()
    {

        $status = ['1'=>'拒绝','2'=>'接受','0'=>'未确定',3=>'已批准'];
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
    //项目经理
    public function xm()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'mid', 'id');
    }
    //项目助理
    public function assignor()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'assignor_id', 'id');
    }
    //排版难易程度
    public function tyevel()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'typesetting_evel', 'id');
    }
    //排版难易程度
    public function trevel()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'translation_evel', 'id');
    }
}