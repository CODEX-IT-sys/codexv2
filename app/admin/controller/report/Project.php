<?php


namespace app\admin\controller\report;

use app\admin\controller\customer\Filaa;
use app\admin\model\customer\Customeraa;
use app\admin\model\customer\CustomerContract;
use app\admin\model\project\Assess;
use app\admin\model\project\Schedule;
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

    /**
     * @NodeAnotation(title="每日项目通道")
     */
    public function projectpage()
    {
        $data=request()->param('month');

        if(isset($data)){
            $time= strtotime($data);
            $year = date("Y", $time);
            $month = date("m", $time);
            $day = date("d", $time);
            // 本月一共有几天
            $firstTime = mktime(0, 0, 0, $month, 1, $year);     // 创建本月开始时间
            $day = date('t',$firstTime);
            $lastTime = $firstTime + 86400 * $day  - 1; //结束时间戳
            $firstTime=date("Ymd",$firstTime);
            $lastTime=date("Ymd",$lastTime);
            if($data==''){
                $firstTime=19701201;
                $lastTime=20351201;

                $time= time();
                $year = date("Y", $time);

                $month = date("m", $time);

                $day = date("d", $time);
                // 本月一共有几天
                $firstTime = mktime(0, 0, 0, $month, 1, $year);     // 创建本月开始时间
                $day = date('t',$firstTime);
                $lastTime = $firstTime + 86400 * $day  - 1; //结束时间戳
                $firstTime=date("Ymd",$firstTime);
                $lastTime=date("Ymd",$lastTime);
            }
        }else{

            $time= time();
            $year = date("Y", $time);

            $month = date("m", $time);

            $day = date("d", $time);
            // 本月一共有几天
            $firstTime = mktime(0, 0, 0, $month, 1, $year);     // 创建本月开始时间
            $day = date('t',$firstTime);
            $lastTime = $firstTime + 86400 * $day  - 1; //结束时间戳
            $firstTime=date("Ymd",$firstTime);
            $lastTime=date("Ymd",$lastTime);
        }

        $mt = Customeraa::whereBetweenTime('completion_date',$firstTime,$lastTime)->where('file_status','in','3,4')->field('sum(page) as sumpage,FROM_UNIXTIME(completion_date,"%Y-%m-%d") as date')->group('date')->select()->toArray();

        $yp=Schedule::whereBetweenTime('work_date',$firstTime,$lastTime)->where('type',1)->field('sum(completion_page) as yppage,FROM_UNIXTIME(work_date,"%Y-%m-%d") as date')->group('date')->select()->toArray();
        $hp=Schedule::whereBetweenTime('work_date',$firstTime,$lastTime)->where('type',4)->field('sum(completion_page) as hppage,FROM_UNIXTIME(work_date,"%Y-%m-%d") as date')->group('date')->select()->toArray();
        $xd=Schedule::whereBetweenTime('work_date',$firstTime,$lastTime)->where('type',3)->field('sum(completion_page) as xdpage,FROM_UNIXTIME(work_date,"%Y-%m-%d") as date')->group('date')->select()->toArray();
        $tr=Schedule::whereBetweenTime('work_date',$firstTime,$lastTime)->where('type',2)->field('sum(completion_page) as trpage,FROM_UNIXTIME(work_date,"%Y-%m-%d") as date')->group('date')->select()->toArray();
        $hb=[];
        $c = array_merge($hp,$yp,$mt,$tr,$xd);

        foreach ($c as $k1=>$v1)
        {
            if(isset($v1['yppage'])){
                $hb[$v1['date']]['yppage']= intval($v1['yppage']);
            }
            if(isset($v1['hppage'])){
                $hb[$v1['date']]['hppage']= intval($v1['hppage']);
            }
            if(isset($v1['trpage'])){
                $hb[$v1['date']]['trpage']= intval($v1['trpage']);
            }
            if(isset($v1['xdpage'])){
                $hb[$v1['date']]['xdpage']= intval($v1['xdpage']);
            }
            if(isset($v1['sumpage'])){
                $hb[$v1['date']]['sumpage']= intval($v1['sumpage']);
            }

        }
        $list=[];
        foreach ($hb as $k2=>$v)
        {
            $hb[$k2]['date']=$k2;
            $list[]=$hb[$k2];
        }
        if(!isset($list)){
            return '无数据';
        }

        if (!request()->isAjax()) {
            $this->assign(['list'=>$list]);
            return $this->fetch();
        }
        return [
            'code'  => 0,
            'msg'   => '',
            'count' => count($list),
            'data'  =>$list,
        ];

    }

    /**
     * @NodeAnotation(title="PA项目助理文件统计")
     */
    public function pa()
    {
        $data=request()->param('month');

        if(isset($data)){
            $time= strtotime($data);
            $year = date("Y", $time);
            $month = date("m", $time);
            $day = date("d", $time);
            // 本月一共有几天
            $firstTime = mktime(0, 0, 0, $month, 1, $year);     // 创建本月开始时间
            $day = date('t',$firstTime);
            $lastTime = $firstTime + 86400 * $day  - 1; //结束时间戳
            $firstTime=date("Ymd",$firstTime);
            $lastTime=date("Ymd",$lastTime);
            if($data==''){
                $firstTime=19701201;
                $lastTime=20351201;

                $time= time();
                $year = date("Y", $time);

                $month = date("m", $time);

                $day = date("d", $time);
                // 本月一共有几天
                $firstTime = mktime(0, 0, 0, $month, 1, $year);     // 创建本月开始时间
                $day = date('t',$firstTime);
                $lastTime = $firstTime + 86400 * $day  - 1; //结束时间戳
                $firstTime=date("Ymd",$firstTime);
                $lastTime=date("Ymd",$lastTime);
            }
        }else{

            $time= time();
            $year = date("Y", $time);

            $month = date("m", $time);

            $day = date("d", $time);
            // 本月一共有几天
            $firstTime = mktime(0, 0, 0, $month, 1, $year);     // 创建本月开始时间
            $day = date('t',$firstTime);
            $lastTime = $firstTime + 86400 * $day  - 1; //结束时间戳
            $firstTime=date("Ymd",$firstTime);
            $lastTime=date("Ymd",$lastTime);
        }

        $pa=Customeraa::with('assistant')->whereBetweenTime('completion_date',$firstTime,$lastTime)->where('assistant_id','<>','null')
            ->where('file_status','in','3,4')->field('assistant_id,sum(page) as sumpage,count(id) as num')->group('assistant_id')->select()->toarray();
        $pa2=Customeraa::with('assistant')->whereBetweenTime('completion_date','19701201','20351201')
            ->where('assistant_id','<>','null')
            ->where('file_status','3')->field('assistant_id,sum(page) as sumpage1,count(id) as num')->group('assistant_id')->select()->toarray();
//        dump($pa2);
//        dump($pa);
        if (!request()->isAjax()) {
            $this->assign(['pa2'=>$pa2]);
            return $this->fetch();
        }
        return [
            'code'  => 0,
            'msg'   => '',
            'count' => 0,
            'data'  =>$pa,
        ];
    }

}