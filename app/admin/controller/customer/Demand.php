<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\Customer;
use app\admin\model\customer\CustomerContract;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\traits\Curd;
use app\admin\model\SystemAdmin;

/**
 * @ControllerAnnotation(title="来稿需求")
 */
class Demand extends AdminController
{

    use Curd;
//    use \app\admin\traits\Curd;
    protected $relationSearch = true;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\customer\CustomerDemand();
//        合同
        $a = CustomerContract::field('id,contract_code')->select();
        //项目经理
        $b = SystemAdmin::wherein('auth_ids', [12])->select();
        //联系人
        $c= Customer::field('id,customer_contact')->select();
        $this->assign(['a' => $a, 'b' => $b,'c'=>$c]);
        $this->assign('getCooperationFirstList', $this->model->getCooperationFirstList());

    }

    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $contract = CustomerContract::field('id,company_id')->find($post['contract_id']);
                $admin = session('admin');
                $post['writer_id'] = $admin['id'];
                $post['company_id'] = $contract['company_id'];
//                dump($post);die;
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        return $this->fetch();
    }


    /**
     * @NodeAnotation(title="列表")
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();

            $count = $this->model
                ->withJoin(['write', 'contract', 'xm', 'company','customerInformation'], 'LEFT')
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('demand_writer_id', 'in', $this->admininfo()['top_id']);
                })
                ->where($where)
                ->count();
            $list = $this->model
                ->where($where)
//                ->with(['write','contract.customerInformation','contract.company','xm'])
                ->withJoin(['write', 'contract', 'xm', 'company','customerInformation'], 'LEFT')
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('demand_writer_id', 'in', $this->admininfo()['top_id']);
                })
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
//            dump($list->toArray());die;
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

    /**
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        $row = $this->model->find($id);

        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

//  withjoin不能嵌套关联,模型类似于A->B,B->C,从而想让A和C产生关系
//with(['write','contract.a'])
// ->withjoin(['write','contract'],'LEFT')
//Column not found: 1054 Unknown column 'c' in 'where clause'
}