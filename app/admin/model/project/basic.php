<?php

namespace app\admin\model\project;

use app\common\model\TimeModel;
use think\facade\Db;
class basic extends TimeModel
{

    protected $name = "project_basic";

    protected $deleteTime = "delete_time";

    //负责人
    public function getPrincipalIdAttr($val)
    {
        $val= explode(",", $val);
        $arr=[];
        foreach ($val as $k1 => $v1) {
            $arr[] = Db::name('system_admin')->where('id', $v1)->value('username');
        }
        return  implode(",", $arr);
    }
}