<?php


namespace app\admin\controller\report;

use app\common\controller\AdminController;
use think\App;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use app\admin\traits\Curd;
/**
 * Class Admin
 * @package app\admin\controller\system
 * @ControllerAnnotation(title="市场")
 */
class Customer extends AdminController
{


    /**
     * @NodeAnotation(title="市场")
     */
    public function test()
    {
       return $this->fetch();
    }

}