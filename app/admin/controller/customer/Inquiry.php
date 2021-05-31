<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\Customer;
use app\admin\model\customer\Customeraa;
use app\admin\model\customer\CustomerContract;
use app\admin\model\customer\CustomerDemand;
use app\admin\model\customer\CustomerqQuotation;
use app\admin\model\setting\DatabaseContent;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Cache;
use think\facade\Db;
use app\admin\model\SystemAdmin;

/**
 * @ControllerAnnotation(title="来稿需求")
 */
class Inquiry extends AdminController
{
//    protected $relationSearch = true;
//    protected $searchFields=
    use \app\admin\traits\Curd;

//    protected $layout=false;
    public function __construct(App $app)
    {
        parent::__construct($app);
        //单位
        $d = Cache::get('dw');
        //服务
        $g = Cache::get('fw');
        $n = [];
        foreach ($g as $k => $v) {
            $n[$k]['name'] = $v['content'];
            $n[$k]['value'] = $v['id'];
        }
        //语种
        $h = Cache::get('yz');
        //文件类型
        $f = Cache::get('file_type');
        //税率
        $s = Cache::get('sl');

        //项目经理
        $b = SystemAdmin::where('auth_ids', 'find in set', 12)->select();
//        dump($s->toarray());
        $admin = $this->admininfo();
        $this->assign([
            'd' => $d, 'g' => $n, 'h' => $h, 'f' => $f, 's' => $s, 'st' => $admin, 'b' => $b
        ]);
//        $this->assign('filestatus', $this->model->getFileStatusList());
//        dump($a);die;
        $this->model = new \app\admin\model\customer\Customeraa();
//        dump($this->model->getFileStatusList());


    }

    /**
     * @NodeAnotation(title="文件列表")
     */
    public function index()
    {
        $a = $this->request->param('id');
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'contract'
                    ,
                ], 'LEFT')
                ->when($a, function ($query) use ($a) {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'contract'], 'LEFT')
                ->when($a, function ($query) use ($a) {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
                ->page($page, $limit)
                ->order($this->sort)
                ->select();

            $data = [
                'code' => 0,
                'msg' => '',
                'count' => $count,
                'data' => $list,
            ];
            return json($data);
        }
        $this->assign(['demand_id' => $a]);
        return $this->fetch();
    }



}