<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;
use think\facade\Db;
class Description extends TimeModel
{

    protected $name = "project_description";

    protected $deleteTime = "delete_time";


    protected $type = [
        'customer_submit_date' => 'timestamp',
        'completion_date' => 'timestamp',
        'pr_start_time' => 'timestamp',
        'pr_end_time' => 'timestamp',
        'tr_start_time' => 'timestamp',
        'tr_end_time' => 'timestamp',
        'after_start_time' => 'timestamp',
        'after_end_time' => 'timestamp',
        'be_end_time' => 'timestamp',
        'be_start_time' => 'timestamp',
        'final_delivery_time' => 'timestamp',
    ];

    //翻译人员proofreader_id
    public function getTranslationIdAttr($val)
    {
        $val= explode(",", $val);
        $arr=[];
        foreach ($val as $k1 => $v1) {
            $arr[] = Db::name('system_admin')->where('id', $v1)->value('username');
        }
        return  implode(",", $arr);
    }
    //校对人员
    public function getProofreaderIdAttr($val)
    {
        $val= explode(",", $val);
        $arr=[];
        foreach ($val as $k1 => $v1) {
            $arr[] = Db::name('system_admin')->where('id', $v1)->value('username');
        }
        return  implode(",", $arr);
    }
    public function getBeforeTyIdAttr($val)
    {
        $val= explode(",", $val);
        $arr=[];
        foreach ($val as $k1 => $v1) {
            $arr[] = Db::name('system_admin')->where('id', $v1)->value('username');
        }
        return  implode(",", $arr);
    }
    public function getAfterTyIdAttr($val)
    {
        $val= explode(",", $val);
        $arr=[];
        foreach ($val as $k1 => $v1) {
            $arr[] = Db::name('system_admin')->where('id', $v1)->value('username');
        }
        return  implode(",", $arr);
    }
    //关联项目文件
    public function fileaa()
    {
        return $this->belongsTo('app\admin\model\customer\Customeraa', 'file_id', 'id');
    }
    //基本信息
    public function basic()
    {
        return $this->belongsTo('app\admin\model\project\Basic', 'basic_id', 'id');
    }
    //项目助理
    public function assignor()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'assistant_id', 'id');
    }
    //翻译
    public function tr()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'translation_id', 'id');
    }

    //预排
    public function yp()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'before_ty_id', 'id');
    }
    //校对
    public function xd()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'proofreader_id', 'id');
    }
    //后排
    public function hp()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'after_ty_id', 'id');
    }
}