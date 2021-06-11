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
        'm_approval',
        'general_approval'
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
                ->withJoin(['type', 'rate', 'dw', 'contract' ,'customerInformation'], 'LEFT')
                ->when($a, function ($query) use ($a) {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'dw', 'contract','customerInformation'], 'LEFT')
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
                $post['file_writer_id'] = $admin['id'];
                //增值税报价金额
                $tax_rate= Db::name('database_content')->where('id', $post['tax_rate'])->value('content');
                if(isset($post['unit_price'])&&$post['quotation_number']&&$post['tax_rate']){
//                    单价不含税
                // 未税金额=单价x数量
                ////增值税额=未税金额x税率（6%）
                ////报价金额=未税金额+增值税额
                    if($post['tax_radio']==0)
                    {
                        $post['no_vat']=$post['unit_price'] * $post['quotation_number'];//100 10*10
                        $post['vat'] = $post['unit_price'] * $post['quotation_number'] * $tax_rate / 100;
                        $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'] + $post['vat'];
                    }else{
//单价含税
//未税金额=（单价x数量）/（1+税率）
//增值税额=报价金额-未税金额
//报价金额=单价x数量
                        $post['no_vat']=$post['unit_price'] * $post['quotation_number']/(1+$tax_rate / 100);
                        $post['vat'] = $post['unit_price'] * $post['quotation_number'] -  $post['no_vat'];
                        $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'];
                    }

                }
                //客户id参数为来稿的id
                $post['customer_id'] = CustomerDemand::where('id', $post['demand_id'])->value('customer_id');
                //合同id
                $post['contract_id'] = CustomerDemand::where('id', $post['demand_id'])->value('contract_id');
//                是否首次合作
                $post['cooperation_first'] = CustomerDemand::where('id', $post['demand_id'])->value('cooperation_first');
                $post['mid'] = CustomerDemand::where('id', $post['demand_id'])->value('mid');
                //项目经理同步
                $post['entrust_date']=strtotime($post['entrust_date']);

                //文件状态为接受时生成文件编号
                if (isset($post['file_status'])) {
                    if ($post['file_status'] == 2) {
//                    客户公司编码
                        $company_code = CustomerContract::where('id', $post['contract_id'])->value('company_code');

                        //生成文件编号
                        $post['customer_file_code'] = filing_number($company_code,$post['entrust_date']);
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
        $row = $this->model->find($id)->toArray();
        $row['entrust_date'] =date("Y-m-d",strtotime($row['entrust_date']));
        $row['customer_submit_date'] =date("Y-m-d H:i:s",strtotime($row['customer_submit_date']));
        $row['completion_date'] =date("Y-m-d",strtotime($row['completion_date']));
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
            $row = $this->model->find($id);
            $post = $this->request->post();

            $rule = [];
            $this->validate($post, $rule);
            try {
                //写入更新人
                $admin = session('admin');
                $post['up_id'] = $admin['id'];



                $tax_rate= Db::name('database_content')->where('id', $post['tax_rate'])->value('content');

                if(isset($post['unit_price'])&&$post['quotation_number']&&$post['tax_rate']){
//                    单价不含税
                    // 未税金额=单价x数量
                    ////增值税额=未税金额x税率（6%）
                    ////报价金额=未税金额+增值税额
                    if($post['tax_radio']==0)
                    {
                        $post['no_vat']=$post['unit_price'] * $post['quotation_number'];
                        $post['vat'] = $post['unit_price'] * $post['quotation_number'] * ($tax_rate / 100);
                        $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'] + $post['vat'];
                    }else{
//单价含税
//未税金额=（单价x数量）/（1+税率）
//增值税额=报价金额-未税金额
//报价金额=单价x数量
                        $post['no_vat']=$post['unit_price'] * $post['quotation_number']/(1+$tax_rate / 100);
                        $post['vat'] = $post['unit_price'] * $post['quotation_number'] -  $post['no_vat'];
                        $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'];
                    }

                }

                //合同id
                $post['contract_id'] = CustomerDemand::where('id', $post['demand_id'])->value('contract_id');
                //客户id
                $post['customer_id'] = CustomerDemand::where('id', $post['demand_id'])->value('customer_id');

                //文件状态为接受时生成文件编号
                if (isset($post['file_status'])) {
                    if ($post['file_status'] == 2) {
//                    客户公司编码
                        $company_code = CustomerContract::where('id', $post['contract_id'])->value('company_code');

                        //生成文件编号
                        $post['customer_file_code'] = filing_number($company_code,strtotime($post['entrust_date']));

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
//            dump($a);die;
            //来稿需求编号
            $b = CustomerDemand::find($a['demand_id']);
            //合同信息
            $c = CustomerContract::find($a['contract_id']);
            //该客户报价单的数量+1
            $d = CustomerqQuotation::where('contract_id', $a['contract_id'])->count();
            //客户信息
            $e = Customer::find($a['customer_id']);
            //合同编码 $c['contract_code']
            $info = [];

            // 报价单编码
            $info['quotation_code'] = 'Q-' . $c['company_code'] . date('Ymd') . str_pad(($d+1),2,0,STR_PAD_LEFT );
            //客户id
            $info['customer_id'] = $a['customer_id'];
            //合同id
            $info['contract_id'] = $a['contract_id'];
            //主体公司od
            $info['company_id'] = $c['company_id'];
            //写入人id
            $admin = $this->admininfo();
            $info['write_id'] = $admin['id'];
            //税额报价金额*数量*税额/100和报价金额:金额*数量+税额
            $num = 0;
            $num1 = 0;
            $info['quotation_amount'] = 0;
            foreach ($post['id'] as $k => $v) {
                $res = Customeraa::where('id', $v)->find();
//                $num += $res['unit_price'] * $res['quotation_number'] * $res['tax_rate'] / 100;
//                $info['quotation_amount'] += ($res['unit_price'] * $res['quotation_number']) + ($res['unit_price'] * $res['quotation_number'] * $res['tax_rate'] / 100);
                $res['tax_rate']= Db::name('database_content')->where('id', $res['tax_rate'])->value('content');
//                dump($res->toArray());die;
                if(isset($res['unit_price'])&&$res['quotation_number']&&$res['tax_rate']){
//                    单价不含税
// 未税金额=单价x数量
////增值税额=未税金额x税率（6%）
////报价金额=未税金额+增值税额
                    if($res['tax_radio']==0)
                    {
                        $num1 +=$res['unit_price'] * $res['quotation_number'];
                        $num += $res['unit_price'] * $res['quotation_number'] * ($res['tax_rate'] / 100);
                        $info['quotation_amount'] += $res['unit_price'] * $res['quotation_number'] + $res['vat'];
                    }else{
//单价含税
//未税金额=（单价x数量）/（1+税率）
//增值税额=报价金额-未税金额
//报价金额=单价x数量
                        $num1 +=$res['unit_price'] * $res['quotation_number']/(1+$res['tax_rate'] / 100);
                        $num += $res['unit_price'] * $res['quotation_number'] -  $res['no_vat'];
                        $info['quotation_amount'] += $res['unit_price'] * $res['quotation_number'];
                    }

                }

            }
            $info['tax_status'] = $a['tax_radio'];
            $info['tax'] = $num;
            $info['no_tax'] = $num1;
            //来稿需求文件编号
            $info['demand_id'] = $a['demand_id'];
            //报价单包含的文件编号
            $info['quotation_file'] = json_encode($post['id']);
//            dump($info);die;
            //生成报价单
            CustomerqQuotation::create($info);
            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
            $this->error('执行错误',$e->getMessage());
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

            //查询其中一个文件
            $a = Customeraa::where('id', $post['id']['0'])->find();
            // 客户公司编码
            $company_code = CustomerContract::where('id', $a['contract_id'])->value('company_code');
            $admin = session('admin');
        try {

            foreach ($post['id'] as $k => $v) {
                //增值税报价金额
                $res = Customeraa::where('id', $v)->find();

//                $res->vat = $res['unit_price'] * $res['quotation_number'] * $res['tax_rate'] / 100;
//                $res->quotation_price = $res['unit_price'] * $res['quotation_number'] + $res['vat'];
//                $res->customer_id = CustomerDemand::where('id', $res['demand_id'])->value('customer_id');
                $res->file_status = 2;
                //如果文件编号已存在就不生成
                if(empty($res['customer_file_code'])){
                    $res->customer_file_code = filing_number($company_code,strtotime($res['entrust_date']));
                }
                $res->up_id = $admin['id'];

                $res->save();


            }

        } catch (\Exception $e) {
            $this->error('执行错误',$e->getMessage());
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