<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;
use think\facade\Db;
class Uploadfile extends TimeModel
{

    protected $name = "project_uploadfile";

    protected $deleteTime = "delete_time";

    //关联标签
    public function label()
    {
        return $this->belongsTo('app\admin\model\setting\DatabaseContent', 'label_id', 'id');
    }
}