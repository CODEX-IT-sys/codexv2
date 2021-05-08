<?php

// +----------------------------------------------------------------------
// | EasyAdmin
// +----------------------------------------------------------------------
// | PHP交流群: 763822524
// +----------------------------------------------------------------------
// | 开源协议  https://mit-license.org 
// +----------------------------------------------------------------------
// | github开源项目：https://github.com/zhongshaofa/EasyAdmin
// +----------------------------------------------------------------------

namespace app\admin\model;


use app\common\model\TimeModel;

class SystemAdmin extends TimeModel
{

    protected $deleteTime = 'delete_time';

    public function getAuthList()
    {
        $list = (new SystemAuth())
            ->where('status', 1)
            ->column('title', 'id');
        return $list;
    }


    public function trtree()
    {
        return $this->hasMany('app\admin\model\project\Description','dtranslation_id','id');
    }
    public function xdtree()
    {
        return $this->hasMany('app\admin\model\project\Description','dproofreader_id','id');
    }
    public function yptree()
    {
        return $this->hasMany('app\admin\model\project\Description','dbefore_ty_id','id');
    }
    public function hptree()
    {
        return $this->hasMany('app\admin\model\project\Description','dafter_ty_id','id');
    }



}