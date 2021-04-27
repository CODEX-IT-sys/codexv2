<?php

namespace app\admin\model\project;

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


}