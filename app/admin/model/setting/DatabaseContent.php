<?php

namespace app\admin\model\setting;

use app\common\model\TimeModel;

class DatabaseContent extends TimeModel
{

    protected $name = "database_content";

    protected $deleteTime = false;


    public function directory()
    {
        return $this->belongsTo(DatabaseDirectory::class, 'list_id', 'id');
    }

}