<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\CustomerContract;
use app\admin\model\MainCompany;
use app\admin\model\customer\Customer;
use app\admin\model\SystemAdmin;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Cache;

/**
 * @ControllerAnnotation(title="customer_contract")
 */
class Contract extends AdminController
{

    use \app\admin\traits\Curd;
    protected $relationSerach = true;
    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\customer\CustomerContract();
        //主体公司
        $a = MainCompany::field('id,chinese_company_name')->select();

//        客户
        $b = Customer::field('id,company_name')->select();
        //销售人员
        $c = SystemAdmin::where('auth_ids', 9)->select();
//        dump($c);
        $d = Cache::get('dw');
        $e = Cache::get('bz');
        $g = Cache::get('fw');
        $h = Cache::get('yz');
//        dump($d);
        $this->assign(['a' => $a, 'b' => $b, 'c' => $c, 'd' => $d, 'e' => $e
         , 'g' => $g, 'h' => '$h', 'g' => $g, 'h' => $h
        ]);
        $this->assign('getInvoicingRulesList', $this->model->getInvoicingRulesList());
        $this->assign('getConfidentialityAgreementList', $this->model->getConfidentialityAgreementList());

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
            list($page, $limit, $where) = $this->writeauth();

            $count = $this->model
                ->where($where)
                ->count();
            $list = $this->model
                ->withJoin(['customerInformation','sale','company','write'], 'LEFT')
                ->where($where)
//                ->wherein('writer_id',$admin['id'])
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
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
//            $post['effective_date']=strtotime($post['effective_date']);
//            $post['expiration_date']=strtotime($post['expiration_date']);
            $admin= session('admin');
            $post['writer_id']=$admin['id'];
//            dump($post);die;
            $rule = [];
            $this->validate($post, $rule);

            try {
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        return $this->fetch();
    }

}