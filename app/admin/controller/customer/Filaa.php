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
 * @ControllerAnnotation(title="来稿文件")
 */
class Filaa extends AdminController
{
    protected $relationSearch = true;
//    protected $searchFields=
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
        $b=SystemAdmin::where('auth_ids','find in set', 12)->select();

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
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation'
                    ,

                ], 'LEFT')
                ->when($a, function ($query)use ($a)  {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation'], 'LEFT')
                ->when($a, function ($query)use ($a)  {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
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
        $this->assign(['demand_id' => $a]);
        return $this->fetch();
    }


    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        $a = $this->request->param('id');

        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $admin = session('admin');
                $post['writer_id'] = $admin['id'];
                //增值税报价金额
                $post['vat'] = $post['unit_price'] * $post['quotation_number'] * $post['tax_rate'] / 100;
                $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'] + $post['vat'];
                //客户id参数为来稿的id
                $post['customer_id'] = CustomerDemand::where('id', $post['demand_id'])->value('customer_id');
//                是否首次合作
                $post['cooperation_first'] = CustomerDemand::where('id', $post['demand_id'])->value('cooperation_first');
                //文件状态为接受时生成文件编号
                if (isset($post['file_status'])) {
                    if ($post['file_status'] == 1) {
//                    客户公司编码
                        $company_code = Customer::where('id', $post['customer_id'])->value('company_code');
                        //生成文件编号
                        $post['customer_file_code'] = filing_number($company_code);
                    }
                }

                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }

        $this->assign('a', $a);
        return $this->fetch();
    }


    /**
     * @NodeAnotation(title="编辑")
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
                if ($post['file_status'] == 1) {
                    // 客户公司编码
                    $company_code = Customer::where('id', $post['customer_id'])->value('company_code');
                    //生成文件编号
                    $post['customer_file_code'] = filing_number($company_code);
                }
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        $this->assign('n', $n);
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="生成报价单")
     */

    public function quotation()
    {
        // 启动事务
        Db::startTrans();
        try {
            $post = $this->request->post();

            //查询其中一个文件
            $a = Customeraa::where('id', $post['id']['0'])->find();
            //来稿需求编号
            $b = CustomerDemand::find($a['demand_id']);
            //合同信息
            $c = CustomerContract::find($b['contract_id']);
            //该客户报价单的数量+1
            $d = CustomerqQuotation::where('customer_id', $c['customer_id'])->count();
            //客户信息
            $e = Customer::find($c['customer_id']);
            //合同编码 $c['contract_code']
            $info = [];
            // 报价单编码
            $info['quotation_code'] = 'Q-' . $e['company_code'] . '-' . date('Ymd') . '-' . ($d + 1);
            //客户id
            $info['customer_id'] = $c['customer_id'];
            //合同id
            $info['contract_id'] = $b['contract_id'];
            //写入人id
            $admin = $this->admininfo();
            $info['write_id'] = $admin['id'];
            //税额报价金额*数量*税额/100和报价金额:金额*数量+税额
            $num = 0;
            $info['quotation_amount'] = 0;
            foreach ($post['id'] as $k => $v) {
                $res = Customeraa::where('id', $v)->find();
                $num += $res['unit_price'] * $res['quotation_number'] * $res['tax_rate'] / 100;
                $info['quotation_amount'] += ($res['unit_price'] * $res['quotation_number']) + ($res['unit_price'] * $res['quotation_number'] * $res['tax_rate'] / 100);
            }
            $info['tax'] = $num;
            //来稿需求文件编号
            $info['demand_id'] = $a['demand_id'];
            //报价单包含的文件编号
            $info['quotation_file'] = json_encode($post['id']);
//            dump($info);
            //生成报价单
            CustomerqQuotation::create($info);
            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
            $this->error('执行错误');
            // 回滚事务
            Db::rollback();
        }
        $this->success('生成成功');

    }

    /**
     * @NodeAnotation(title="批量接受")
     */
    public function approve()
    {
        $post = $this->request->post();
        try {
            //查询其中一个文件
            $a = Customeraa::where('id', $post['id']['0'])->find();
            // 客户公司编码
            $company_code = Customer::where('id', $a['customer_id'])->value('company_code');
            $admin = session('admin');


            foreach ($post['id'] as $k => $v) {
                //增值税报价金额
                $res = Customeraa::where('id', $v)->find();
                $res->vat = $res['unit_price'] * $res['quotation_number'] * $res['tax_rate'] / 100;
                $res->quotation_price = $res['unit_price'] * $res['quotation_number'] + $res['vat'];
                $res->customer_id = CustomerDemand::where('id', $res['demand_id'])->value('customer_id');
                $res->file_status = 2;
                $res->customer_file_code = filing_number($company_code) . $k;
                $res->up_id = $admin['id'];
                $res->save();
            }

        } catch (\Exception $e) {
            $this->error('执行错误');
        }
        $this->success('批量接受成功');
    }

    /**
     * @NodeAnotation(title="属性修改")
     */
    public function modify()
    {
        $post = $this->request->post();
        $rule = [
            'id|ID' => 'require',
            'field|字段' => 'require',
            'value|值' => 'require',
        ];
        $this->validate($post, $rule);
        $row = $this->model->find($post['id']);
        if (!$row) {
            $this->error('数据不存在');
        }
        if (!in_array($post['field'], $this->allowModifyFields)) {
            $this->error('该字段不允许修改：' . $post['field']);
        }
        try {

            $row->save([
                $post['field'] => $post['value'],
            ]);
        } catch (\Exception $e) {
            $this->error($e->getMessage());
        }
        $this->success('保存成功');
    }

}