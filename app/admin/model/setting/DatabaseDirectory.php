<?php

namespace app\admin\model\setting;

use app\common\model\TimeModel;

class DatabaseDirectory extends TimeModel
{

    protected $name = "database_directory";

    protected $deleteTime = false;

    
    public function content()
    {
        return $this->hasMany(DatabaseContent::class,'list_id','id');
    }

}