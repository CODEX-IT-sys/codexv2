<?php

namespace app\admin\controller\customer;

use app\admin\model\MainCompany;
use app\admin\model\customer\Customer;
use app\admin\model\setting\DatabaseContent;
use app\admin\model\SystemAdmin;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Cache;

/**
 * @ControllerAnnotation(title="合同")
 */
class Contract extends AdminController
{

    use \app\admin\traits\Curd;
    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\customer\CustomerContract();

        //主体公司
        $a = MainCompany::field('id,chinese_company_name')->select();


        //销售人员
        $c=DatabaseContent::where('list_id',18)->select();
        $d = Cache::get('dw');
        $g = Cache::get('fw');
        $h = Cache::get('yz');
        $e = Cache::get('bz');
        //税率
        $s = Cache::get('sl');

//        dump($g);die;
        $this->assign(['a' => $a, 'c' => $c, 'd' => $d, 'e' => $e
            , 'g' => $g, 'h' => $h,'s'=>$s
        ]);
//        die;
        $this->assign('getInvoicingRulesList', $this->model->getInvoicingRulesList());
        $this->assign('getConfidentialityAgreementList', $this->model->getConfidentialityAgreementList());

    }


    /**
     * @NodeAnotation(title="列表")
     */
    public function index()
    {


//        dump($this->admininfo());
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->withJoin([  'company', 'write', 'dw', 'bz', 'fw'], 'LEFT')
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('writer_id', 'in', $this->admininfo()['top_id']);
                })
                ->where($where)
                ->count();
            $list = $this->model
                ->withJoin([  'company', 'write', 'dw', 'bz', 'fw'], 'LEFT')
                ->where($where)
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('writer_id', 'in', $this->admininfo()['top_id']);
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
//        return json($data);
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
            $admin = session('admin');
            $post['writer_id'] = $admin['id'];
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

    /**
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        $row = $this->model->find($id)->toArray();

        $row['effective_date']=date("Y-m-d",strtotime($row['effective_date']));
        $row['expiration_date']=date("Y-m-d",strtotime($row['expiration_date']));
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $row = $this->model->find($id);
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $admin = session('admin');
                $post['up_id'] = $admin['id'];
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败',$e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }

        $this->assign('row', $row);
        return $this->fetch();
    }

}