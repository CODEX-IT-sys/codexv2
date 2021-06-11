<?php

namespace app\admin\controller\database;

use app\admin\model\setting\DatabaseDirectory;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;

/**
 * @ControllerAnnotation(title="词库词条")
 */
class Content extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $a=DatabaseDirectory::field('id,title')->select();
        $this->assign([
            'a'=>$a
        ]);
        $this->model = new \app\admin\model\setting\DatabaseContent();
        
    }

    /**
     * @NodeAnotation(title="词库内容")
     */
    public function index()
    {

        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $list = $this->model
                ->withJoin('directory', 'LEFT')
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
//            dump($list);die;
            $data = [
                'code'  => 0,
                'msg'   => '',
                'count' => count($list),
                'data'  => $list,
            ];
            return json($data);
        }
        return $this->fetch();
    }




}