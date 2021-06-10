<?php


namespace app\admin\controller\report;

use app\admin\model\customer\Customeraa;
use app\common\controller\AdminController;
use think\App;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use app\admin\traits\Curd;
/**
 * Class Admin
 * @package app\admin\controller\system
 * @ControllerAnnotation(title="市场")
 */
class Customer extends AdminController
{


    /**
     * @NodeAnotation(title="市场")
     */
    public function test()
    {
       return $this->fetch();
    }
    /**
     * @NodeAnotation(title="翻译金额对比统计")
     */
    public function tr_amount()
    {
        // 去年
        $s_year = date("Y", strtotime("-1 year"));
        // 今年
        $year = date('Y');  $arr = [];
        //按月
       $data= Customeraa::field('FROM_UNIXTIME(filecreate_at,"%Y-%m") as date')->group('date')->select()->toArray();
       //公司分组
        $gs = Customeraa::with(['contract'])->field('contract_id, sum(page) page')->group('contract_id')->select()->toarray();
        // 预定义 月份数组
        $m = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
        foreach ($gs as $k=>$v)
        {

            for ($i = 1; $i < 13; $i++) {
                // 时间为条件
                $s = $year . $m[$i - 1] . '01';
                $d = $year . $m[$i - 1] . '31';
                $arr[$k]['jamount'][$i] = Customeraa::with('contract')->where('contract_id', $v['contract_id'])->whereBetweenTime('filecreate_at', $s, $d)
                    ->sum('fapiao_amount');
                $arr[$k]['gongsi'] = $v['contract']['company_name'];
                $arr[$k]['jtotal'] =array_sum(  $arr[$k]['jamount']);
            }

            for ($i = 1; $i < 13; $i++) {
                // 时间为条件
                $s = $s_year . $m[$i - 1] . '01';
                $d = $s_year . $m[$i - 1] . '31';
                $arr[$k]['qamount'][$i] = Customeraa::with('contract')->where('contract_id', $v['contract_id'])->whereBetweenTime('filecreate_at', $s, $d)
                    ->sum('fapiao_amount');
                $arr[$k]['gongsi'] = $v['contract']['company_name'];
                $arr[$k]['qtotal'] =array_sum(  $arr[$k]['qamount']);
            }
        }

        if ($this->request->isAjax()) {
            $data = [
                'code' => 0,
                'msg' => '',
                'count' => count($arr),
                'data' => $arr,
            ];
            return json($data);
        }

        return $this->fetch();

    }
    /**
     * @NodeAnotation(title="销售人员销售额汇总")
     */
    public function saleamount()
    {
        $s = $this->request->param('start', '20000101');
        $d = $this->request->param('end', '20990701');
        if ($s == '' || $d == '') {
            $s = '20000101';
            $d = '20990701';
        }
        //结算状态为已付款;
//        $data=Customeraa::with('contract')->whereBetweenTime('filecreate_at', $s, $d)->field('contract.sales,sum(page) page')->group('contract.sales')->select()->toarray();
        $arr=Customeraa::alias('a')->Join('ea_customer_contract w','a.contract_id = w.id')
            ->whereBetweenTime('filecreate_at', $s,$d)
            ->where('c_status',30)
            ->field('sales,sum(no_vat1) as novat ')
            ->group('sales')->select()->toarray();
        if ($this->request->isAjax()) {
            $data = [
                'code' => 0,
                'msg' => '',
                'count' => count($arr),
                'data' => $arr,
            ];
            return json($data);
        }
        return $this->fetch();
    }

}