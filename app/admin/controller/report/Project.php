<?php


namespace app\admin\controller\report;

use app\admin\model\customer\Customeraa;
use app\admin\model\customer\CustomerContract;
use app\common\controller\AdminController;
use think\App;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use app\admin\traits\Curd;

/**
 * Class Admin
 * @package app\admin\controller\system
 * @ControllerAnnotation(title="项目")
 */
class Project extends AdminController
{


    /**
     * @NodeAnotation(title="翻译对比")
     */
    public function trcompare($y = 0,$limit=50,$page=1)
    {
        //->field('contract_id')->group('contract_id')
        $gs = Customeraa::with(['contract'])->field('contract_id, sum(page) page')->group('contract_id')->select();
//        dump($gs);
        $year = date('Y');
        $arr = [];
        $c_arr = [];
        if ($y == '') {
            $y = $year;
        }
        // 预定义 月份数组
        $m = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'];
        // 预定义 字段下标
        $b = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l'];
        // 每年 的第一天
        $ys = intval($y . '0101');
        // 每年 最后一天
        $yd = intval($y . '1231');
//        $list_date=Customeraa::with(['contract'])->whereBetweenTime('create_time', '20170101', '20210602')->field(['contract_id','sum(page) page'])->group('contract_id')->select();
//        dump($list_date->toArray());
        $arr = [];
        for ($i = 1; $i < 13; $i++) {
            // 时间为条件
            $s = $y . $m[$i - 1] . '01';
            $d = $y . $m[$i - 1] . '31';
//            dump($s);
//            dump($d);


            foreach ($gs as $k => $v) {
                $list_date = Customeraa::with(['contract'])->whereBetweenTime('create_time', $s, $d)
                    ->where('contract_id', $v['contract_id'])->sum('page');
//                        ->field(['contract_id','sum(page) page'])
//                        ->group('contract_id')->select()->toarray();
                $arr[$k]['gongsi'] = $v['contract']['company_name'];

                $arr[$k]['page'][$i] = intval($list_date);

                $arr[$k]['total'] = array_sum($arr[$k]['page']);
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


    public function trevaluate()
    {
        
    }


}