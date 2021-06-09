<?php

namespace app\admin\model\project;

use app\admin\model\SystemAdmin;
use app\common\model\TimeModel;

class Schedule extends TimeModel
{

    protected $name = "project_schedule";

    protected $deleteTime = "delete_time";
    protected $type = [
        'start_time' => 'timestamp',
        'end_time' => 'timestamp',
        'work_date' => 'timestamp',

    ];




    public function getLateSubmissionList()
    {
        return ['1'=>'yes','0'=>'no',];
    }

    public function getSelfInspectionStatusList()
    {
        return ['1'=>'yes','0'=>'no',];
    }

    public function getUpdateMainLibraryList()
    {
        return ['1'=>'yes','2'=>'no','0'=>'N/A',];
    }

    public function getTerminologySubmitList()
    {
        return ['1'=>'yes','2'=>'no','0'=>'N/A',];
    }

    public function getFinalizedSubmitList()
    {
        return ['1'=>'yes','2'=>'no','0'=>'N/A',];
    }

    public function desciption()
    {
        return $this->belongsTo(Description::class,'description_id','id');
    }
    public function write()
    {
        return $this->belongsTo(SystemAdmin::class,'schedule_write_id','id');
    }
/*    public function topics()
    {
        return $this->hasManyThrough('Topic','User');
    }*/


}