<?php

namespace app\admin\controller\customer;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Db;
use think\facade\Cache;
use app\admin\model\customer\Customer;
use app\admin\model\customer\CustomerDemand;
use app\admin\model\customer\Customeraa;
use think\facade\View;
use app\admin\model\SystemAdmin;

/**
 * @ControllerAnnotation(title="文件管理")
 */
class affine extends AdminController
{

    use \app\admin\traits\Curd;
    /**
     * 允许修改的字段
     * @var array
     */
    protected $allowModifyFields = [
        'customer_file_name',
        'page',
        'number_of_words',
        'unit_price',
        'quotation_number',
        'status',
        'sort',
        'remark',
        'is_delete',
        'is_auth',
        'title',
    ];

    public function __construct(App $app)
    {
        parent::__construct($app);
        //单位
        $d = Cache::get('dw');
        //服务
        $g = Cache::get('fw');
        //语种
        $h = Cache::get('yz');
        //文件类型
        $f = Cache::get('file_type');
        //税率
        $s = Cache::get('sl');

        $b=SystemAdmin::where('auth_ids','find in set', 12)->select();
        //结算状态
        $js=Cache::get('jsstatus');
        $admin = $this->admininfo();
        $this->assign([
            'd' => $d, 'g' => $g, 'h' => $h, 'f' => $f, 's' => $s, 'st' => $admin, 'b' => $b,'jsstatus'=>$js
        ]);
        $this->model = new \app\admin\model\customer\Customeraa();
        $this->assign('getCooperationFirstList', $this->model->getCooperationFirstList());
        $this->assign('filestatus', $this->model->getFileStatusList());

    }

    /**
     * @NodeAnotation(title="来稿需求文件列表")
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
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation'], 'LEFT')
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
     * @NodeAnotation(title="来稿需求拒绝列表")
     */
    public function refuse()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where('file_status', 'in',[1,0])
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation','demand','contract','jsstatus'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 'in',[1,0])
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation','demand','contract','jsstatus'], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();

            $data = [
                'code' => 0,
                'msg' => '',
                'count' => $count,
                'data' => $list,
            ];
            return json($data);
        }
        return View::fetch('index');

    }

    /**
     * @NodeAnotation(title="来稿需求文件接受列表")
     */
    public function accept()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where('file_status', 2)
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation','demand','contract','jsstatus'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 2)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation','demand','contract','jsstatus'], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();

            $data = [
                'code' => 0,
                'msg' => '',
                'count' => $count,
                'data' => $list,
            ];
            return json($data);
        }
        return View::fetch('index');
    }

    /**
     * @NodeAnotation(title="来稿需求文件已批准列表")
     */
    public function passed()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where('file_status', 3)
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation','demand','contract','jsstatus'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 3)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation','demand','contract','jsstatus'], 'LEFT')
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
        return $this->fetch('index');
    }

    /**
     * @NodeAnotation(title="来稿确认编辑")
     */
    public function edit($id)
    {
        $row = $this->model->find($id);
        //服务
        $g = Cache::get('fw');
        $n = [];
        $value = explode(',', $row['service']);
        foreach ($g as $k => $v) {
            $n[$k]['name'] = $v['content'];
            $n[$k]['value'] = $v['id'];
            if (in_array($v['content'], $value)) {
                $n[$k]['selected'] = true;
            }
        }
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                //写入更新人
                $admin = session('admin');
                $post['up_id'] = $admin['id'];
                //增值税报价金额
                $post['vat'] = $post['unit_price'] * $post['quotation_number'] * $post['tax_rate'] / 100;
                $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'] + $post['vat'];
                //客户id
                $post['customer_id'] = CustomerDemand::where('id', $post['demand_id'])->value('customer_id');
                //文件状态为接受时生成文件编号
                if (isset($post['file_status'])) {
                    if ($post['file_status'] == 1) {
//                    客户公司编码
                        $company_code = Customer::where('id', $post['customer_id'])->value('company_code');
                        //生成文件编号
                        $post['customer_file_code'] = filing_number($company_code);
                    }
                }
                $save = $row->save($post);

            } catch (\Exception $e) {
                $this->error('保存失败',$e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        $this->assign('n', $n);
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="来稿批准")
     */
    public function approve()
    {
        $post = $this->request->post();
        // 启动事务
        Db::startTrans();
        try {
            //批量确认流入项目
            $admin = session('admin');
            foreach ($post['id'] as $k => $v) {
                //增值税报价金额
                $res = Customeraa::where('id', $v)->find();
                if ($res['customer_file_code'] == '') {
//                    客户公司编码
                    $company_code = Customer::where('id', $res['customer_id'])->value('company_code');
                    //生成文件编号
                    $res->customer_file_code = filing_number($company_code) . $k;
                }
                $res->confirmor_id = $admin['id'];
                $res->file_status = 3;
                $res->save();
            }

            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
            $this->error('批准失败');
            // 回滚事务
            Db::rollback();
        }
        $this->success('批量批准成功');

    }
}