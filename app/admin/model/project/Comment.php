<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;

class Comment extends TimeModel
{

    protected $name = "project_comment";

    protected $deleteTime = "delete_time";


    //人
    public function user()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'user_id', 'id');
    }


}