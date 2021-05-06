<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;

class Basicfile extends TimeModel
{

    protected $name = "project_basicfile";

    protected $deleteTime = "delete_time";



    //关联类型
    public function label()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'label_id', 'id');
    }
    //关联文件
    public function basic()
    {
        return $this->belongsTo('app\admin\model\project\Basic', 'basic_id', 'id');
    }
}