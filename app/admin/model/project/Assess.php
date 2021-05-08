<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;
use app\admin\model\SystemAdmin;
class Assess extends TimeModel
{

    protected $name = "project_assess";

    protected $deleteTime = "delete_time";

    
    
    public function getYpLayoutFormatList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getYpContentCheckList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getYpCustomerRequestList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getYpOverallEvaluationList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getHpLayoutFormatList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getHpContentCheckList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getHpCustomerRequestList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getHpOverallEvaluationList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrOmissionsList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrRedundantList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrUnderstandingList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrInputErrorList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrNotUniformList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrNotUniformWithList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrInappropriateTerminologyList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrImproperPunctuationList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrOutHabitList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrSyntaxErrorList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrFluencyOfExpressionList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrReferenceList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    public function getTrRepeatedlyList()
    {
        return ['1'=>'A','2'=>'B','3'=>'C','4'=>'D',];
    }

    //关联文件
    public function file()
    {
        return $this->belongsTo('app\admin\model\project\Description', 'description_id', 'id');
    }
    //关联录入人
    public function write()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'write_id', 'id');
    }

//description_id
//    public function fileyp()
//    {
//        return $this->hasOneThrough('app\admin\model\SystemAdmin', 'app\admin\model\project\Description', 'id','id','description_id','dbefore_ty_id');
//    }
    //翻译
    public function tr()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'pj_dtranslation_id', 'id');
    }
    //预排
    public function yp()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'pj_dbefore_ty_id', 'id');
    }
    //后排
    public function hp()
    {
        return $this->belongsTo('app\admin\model\SystemAdmin', 'pj_dafter_ty_id', 'id');
    }

}