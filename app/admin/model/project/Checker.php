<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;

class Checker extends TimeModel
{

    protected $name = "project_checker";

    protected $deleteTime = "delete_time";

    //关联录入人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'checker_write_id', 'id');
    }
    //关联项目文件
    public function fileaa()
    {
        return $this->belongsTo('app\admin\model\customer\Customeraa', 'file_id', 'id');
    }
    
    public function getTrCheckerList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getTerminologyList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getLanguageQualityList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getProperNounsList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getUnitsMeasurementList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getSymbolList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getChartList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getAbbreviationList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getLayoutFormatList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getOtherList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getExistingProblemList()
    {
        return ['1'=>'C','2'=>'NC',];
    }

    public function getCorrectSituationList()
    {
        return ['1'=>'C','2'=>'NC',];
    }


}