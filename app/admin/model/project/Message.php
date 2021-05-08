<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;

class Message extends TimeModel
{

    protected $name = "project_message";

    protected $deleteTime = "delete_time";



    //发信人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'write_id', 'id');
    }
    //收信人
    public function addressee()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'addressee_id', 'id');
    }
}