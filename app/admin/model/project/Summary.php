<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;

class Summary extends TimeModel
{

    protected $name = "project_summary";

    protected $deleteTime = "delete_time";


    //基本信息
    public function basic()
    {
        return $this->belongsTo('app\admin\model\project\Basic', 'basic_id', 'id');
    }
    //关联录入人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'summary_write_id', 'id');
    }


}