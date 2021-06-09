<?php


namespace app\admin\controller\report;

use app\admin\model\customer\Customeraa;
use app\admin\model\customer\CustomerContract;
use app\admin\model\project\Assess;
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
    public function trcompare($y = 0, $limit = 50, $page = 1)
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
                $list_date = Customeraa::with(['contract'])->whereBetweenTime('filecreate_at', $s, $d)
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

    /**
     * @NodeAnotation(title="翻译人员质量评估")
     */
    public function trevaluate()
    {
//        算法有问题,损耗过大
        $s = $this->request->param('start', '20000101');
        $d = $this->request->param('end', '20990701');
        if ($s == '' || $d == '') {
            $s = '20000101';
            $d = '20990701';
        }
        $tr_arr = Assess::with('tr')->where('pj_dtranslation_id', '<>', '')
            ->field('pj_dtranslation_id')->whereBetweenTime('create_time', $s, $d)->group('pj_dtranslation_id')->select();
//        dump($tr_arr->toarray());
        // 评价等级 数组
        $p = ['1', '2', '3', '4'];
        $pl = count($p);
        // 分组 查询 整体评价 为 ABCD 各有多少个
        $arr = [];
        for ($n = 0; $n < $pl; $n++) {
            foreach ($tr_arr as $k => $v) {
                $arr[$k]['name'] = $v['tr']['username'];
                $arr[$k]['num'][$p[$n]] = Assess::with('tr')->where('pj_dtranslation_id', $v['pj_dtranslation_id'])->where('type', 3)
                    ->where('tr_overall_evaluation', $p[$n])->whereBetweenTime('create_time', $s, $d)
                    ->count();
//                dump( $arr[$v['pj_dtranslation_id']]);
                $arr[$k]['total'] = array_sum($arr[$k]['num']);

            }

        }

        foreach ($arr as $k1 => $v1) {

            if ($v1['num']['3'] >= ($v1['total'] / 2) or $v1['num']['4'] >= ($v1['total'] / 2)) {

                $arr[$k1]['result'] = '质量不可接受';

            } elseif ($v1['num']['1'] > ($v1['total'] / 2) && $v1['num']['3'] == 0 && $v1['num']['4'] == 0) {

                $arr[$k1]['result'] = '质量优秀';
            } else {
                $arr[$k1]['result'] = '质量可接受';
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
     * @NodeAnotation(title="预排版人员质量评估")
     */
    public function pbevaluate()
    {

        $s = $this->request->param('start', '20000101');
        $d = $this->request->param('end', '20990701');
        if ($s == '' || $d == '') {
            $s = '20000101';
            $d = '20990701';
        }
        $yp_arr = Assess::with('yp')->where('pj_dbefore_ty_id', '<>', '')->where('type', 1)
            ->field('pj_dbefore_ty_id')->whereBetweenTime('create_time', $s, $d)->group('pj_dbefore_ty_id')->select();
//        dump($yp_arr->toarray());
        // 评价等级 数组
        $p = ['1', '2', '3', '4'];
        $pl = count($p);
        // 分组 查询 整体评价 为 ABCD 各有多少个
        $arr = [];
        // 分组 查询 整体评价 为 ABCD 各有多少个
        $arr = [];
        for ($n = 0; $n < $pl; $n++) {
            foreach ($yp_arr as $k => $v) {
                $arr[$k]['name'] = $v['yp']['username'];
                $arr[$k]['num'][$p[$n]] = Assess::with('yp')->where('pj_dbefore_ty_id', $v['pj_dbefore_ty_id'])->where('type', 1)
                    ->where('yp_overall_evaluation', $p[$n])->whereBetweenTime('create_time', $s, $d)
                    ->count();
//                dump( $arr[$v['pj_dtranslation_id']]);
                $arr[$k]['total'] = array_sum($arr[$k]['num']);

            }

        }

        foreach ($arr as $k1 => $v1) {

            if ($v1['num']['3'] >= ($v1['total'] / 2) or $v1['num']['4'] >= ($v1['total'] / 2)) {

                $arr[$k1]['result'] = '质量不可接受';

            } elseif ($v1['num']['1'] > ($v1['total'] / 2) && $v1['num']['3'] == 0 && $v1['num']['4'] == 0) {

                $arr[$k1]['result'] = '质量优秀';
            } else {
                $arr[$k1]['result'] = '质量可接受';
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


}