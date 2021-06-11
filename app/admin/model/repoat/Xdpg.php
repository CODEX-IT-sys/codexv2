<?php

namespace app\admin\model\repoat;

use app\admin\model\project\Basic;
use app\admin\model\project\Description;
use app\common\model\TimeModel;

class Xdpg extends TimeModel
{

    protected $name = "repoat_xdpg";

    protected $deleteTime = "delete_time";


    // 定义时间戳字段名
    protected $createTime = 'xdpg_create_time';
    protected $updateTime = 'xdpg_update_time';

    //管理基本信息,项目名称
    public function basic()
    {
        return $this->belongsTo(Basic::class,'basic_id','id');
    }

    //关联文件
    public function description()
    {
        return $this->belongsTo(Description::class,'file_id','id');
    }
}