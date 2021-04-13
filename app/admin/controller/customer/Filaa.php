<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\Customer;
use app\admin\model\customer\Customeraa;
use app\admin\model\customer\CustomerDemand;
use app\admin\model\setting\DatabaseContent;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Cache;
use think\facade\Db;

/**
 * @ControllerAnnotation(title="customer_filaa")
 */
class Filaa extends AdminController
{
    protected $relationSearch = true;
    use \app\admin\traits\Curd;

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


        $admin = $this->admininfo();
        $this->assign([
            'd' => $d, 'g' => $g, 'h' => $h, 'f' => $f, 's' => $s, 'st' => $admin,
        ]);
//        dump($a);die;
        $this->model = new \app\admin\model\customer\Customeraa();
        $this->assign('filestatus', $this->model->getFileStatusList());

    }


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
                ->withJoin(['type', 'rate', 'yz', 'dw',], 'LEFT')
                ->when($a, function ($query, $a) {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['type', 'rate', 'yz', 'dw',], 'LEFT')
                ->when($a, function ($query, $a) {
                    // 满足条件后执行
                    return $query->where('demand_id', $a);
                })
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();

            foreach ($list as $k => $v) {
                foreach ($v['service'] as $k1 => $v1) {
                    $v['service'][$k1] = Db::name('database_content')->where('id', $v1)->value('content');
                }
                $list[$k]['fw'] = implode(",", $v['service']);
            }
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
                $post['service'] = implode(",", ($post['service']));
                $post['vat'] = $post['unit_price'] * $post['quotation_number'] * $post['tax_rate'] % 100;
                $post['quotation_price'] = $post['unit_price'] * $post['quotation_number'] + $post['vat'];
                //客户id参数为来稿的id
                $post['customer_id'] = CustomerDemand::where('id', $post['demand_id'])->value('customer_id');
                //文件状态为接受时生成文件编号
                if ($post['file_status'] == 1) {
//                    客户公司编码
                    $company_code = Customer::where('id', $post['customer_id'])->value('company_code');

                    //生成文件编号
                    $post['customer_file_code'] = filing_number($company_code, $sum);
                }
//                dump($post);die;
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
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $post['service'] = implode(",", ($post['service']));
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
                    $post['customer_file_code'] =filing_number($company_code);
                }
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="生成报价单")
     */

    public function quotation()
    {
        $post = $this->request->post();
        Customeraa::where('demand_id', 1)->limit(3)->order('id', 'asc')->select();
        dump($post);
        die;
        //用其中一个获取公司编码

    }

}