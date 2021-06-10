<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\Customerqingkuan;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\customer\Customeraa;
/**
 * @ControllerAnnotation(title="customer_qingkuan")
 */
class Qingkuan extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\customer\Customerqingkuan();
        
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
     * @NodeAnotation(title="打印预览")
     */
    public function print_view()
    {
        $id = $this->request->param('id');
        //报价单信息
        $a = Customerqingkuan::with(['customerInformation', 'contract.bz', 'company'])->where('id', $id)->find()->toArray();
//        dump($a);
        $b = Customeraa::where('id', 'in', json_decode($a['quotation_file']))->with(['type',  'rate', 'dw',])->select()->toArray();

//        dump($b);die;
        $num1 = 0;
        $num2 = 0;
        foreach ($b as $k => $v) {
            $num1 += $v['quotation_price1'];//报价金额
            $num2 += $v['vat1'];//报价金额
        }
        $num3 = $num1 - $num2;//报价金额
        $a['num1'] = number_format($num1,2);
        $a['num2'] = number_format($num2,2);
        $a['num3'] = number_format($num3,2);

        $this->assign(['a' => $a, 'b' => $b]);

        return $this->fetch('print_view_cn');
    }

    
}