<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;

class Feedback extends TimeModel
{

    protected $name = "project_feedback";

    protected $deleteTime = "delete_time";

    protected $type = [
        'feedback_time' => 'timestamp',

    ];


    public function getFeedbackList()
    {
        return ['1'=>'Non','2'=>'Good','3'=>'Bad','4'=>'Other',];
    }

    //关联录入人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'feedback_write_id', 'id');
    }
    //关联项目文件
    public function fileaa()
    {
        return $this->belongsTo('app\admin\model\customer\Customeraa', 'file_id', 'id');
    }
    //项目助理
    public function pa()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'pa', 'id');
    }


}