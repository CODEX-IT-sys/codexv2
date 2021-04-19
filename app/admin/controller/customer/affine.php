<?php

namespace app\admin\controller\customer;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Db;
/**
 * @ControllerAnnotation(title="customer_filaa")
 */
class affine extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\CustomerFilaa();
        
    }


    /**
     * @NodeAnotation(title="来稿确认列表")
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw','customerInformation'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw','customerInformation'], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
//            foreach ($list as $k => $v) {
//                foreach ($v['service'] as $k1 => $v1) {
//                    $v['service'][$k1] = Db::name('database_content')->where('id', $v1)->value('content');
//                }
//                $list[$k]['fw'] = implode(",", $v['service']);
//            }
            $data = [
                'code' => 0,
                'msg' => '',
                'count' => $count,
                'data' => $list,
            ];
            return json($data);
        }
        return $this->fetch();
    }
}