<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\Customeraa;
use app\admin\model\customer\CustomerqQuotation;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Db;

/**
 * @ControllerAnnotation(title="报价单")
 */
class Quotation extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\customer\CustomerqQuotation();

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
                ->withJoin(['contract', 'company','customerInformation','write'], 'LEFT')
                ->where($where)
                ->count();
            $list = $this->model
                ->where($where)
                ->page($page, $limit)
                ->withJoin(['contract', 'company','customerInformation','write'], 'LEFT')
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

    /**
     * @NodeAnotation(title="打印预览")
     */
    public function print_view()
    {
        $id = $this->request->param('id');
        //报价单信息
        $a = CustomerqQuotation::with(['customerInformation', 'contract.bz', 'company'])->where('id', $id)->find()->toArray();
//        dump($a);die;
        $b = Customeraa::where('id', 'in', json_decode($a['quotation_file']))->with(['type', 'rate', 'yz', 'dw',])->select()->toArray();
        $num1 = 0;
        $num2 = 0;
        foreach ($b as $k => $v) {

            $num1 += $v['quotation_price'];//报价金额
            $num2 += $v['vat'];//报价金额
        }
        $num3 = $num1 - $num2;//报价金额
        $a['num1'] = $num1;
        $a['num2'] = $num2;
        $a['num3'] = $num3;

        $this->assign(['a' => $a, 'b' => $b]);

        return $this->fetch('print_view_cn');
    }
}