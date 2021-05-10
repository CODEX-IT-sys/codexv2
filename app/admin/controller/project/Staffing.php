<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\setting\DatabaseContent;
use app\admin\model\SystemAdmin;
use think\facade\Db;

/**
 * @ControllerAnnotation(title="人员日程")
 */
class Staffing extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new SystemAdmin();

    }


    /**
     * @NodeAnotation(title="人员列表")
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
                ->count();
            $list = $this->model
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
            foreach ($list as $k => $v) {

                $arr = [];
                foreach (explode(",", $v['auth_ids']) as $k1 => $v1) {
                    $arr[] = Db::name('system_auth')->where('id', $v1)->value('title');

                }
                $list[$k]['auth'] = implode(",", $arr);
            }

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
     * @NodeAnotation(title="人员日程")
     */
    public function rc()
    {
//        $tr = \app\admin\model\project\Description::where('dtranslation_id', $id)->select()->toArray();
////        dump($tr);
//        $xd = \app\admin\model\project\Description::where('dproofreader_id', $id)->select()->toArray();
//        $yp = \app\admin\model\project\Description::where('dbefore_ty_id', $id)->select()->toArray();
//        $hp = \app\admin\model\project\Description::where('dafter_ty_id', $id)->select()->toArray();
//        $man = array_merge($tr, $xd, $yp, $hp);
//        $a = [];
//        foreach ($man as $k => $v) {
//            if (!empty($tr)) {
//                $a[$k]['title'] = "文件编号:$v[file_code_project]\r" . "文件名称:$v[file_name_project]\r" . "开始时间:$v[tr_start_time]\r" . "结束时间:$v[tr_end_time]";
//                $a[$k]['start'] = $v['tr_start_time'];
//                $a[$k]['end'] = $v['tr_end_time'];
//            }
//            if (!empty($xd)) {
//                $a[$k]['title'] = "文件编号:$v[file_code_project]\r" . "文件名称:$v[file_name_project]\r" . "开始时间:$v[pr_start_time]\r" . "结束时间:$v[pr_end_time]";
//                $a[$k]['start'] = $v['pr_start_time'];
//                $a[$k]['end'] = $v['pr_end_time'];
//            }
//            if (!empty($yp)) {
//                $a[$k]['title'] = "文件编号:$v[file_code_project]\r" . "文件名称:$v[file_name_project]\r" . "开始时间:$v[be_start_time]\r" . "结束时间:$v[be_end_time]";
//                $a[$k]['start'] = $v['be_start_time'];
//                $a[$k]['end'] = $v['be_end_time'];
//            }
//            if (!empty($hp)) {
//                $a[$k]['title'] = "文件编号:$v[file_code_project]\r" . "文件名称:$v[file_name_project]\r" . "开始时间:$v[after_start_time]\r" . "结束时间:$v[after_end_time]";
//                $a[$k]['start'] = $v['after_start_time'];
//                $a[$k]['end'] = $v['after_end_time'];
//            }
//
//        }

//        $this->assign(['a' => json_encode($a)]);


        $tr = SystemAdmin::with(['trtree.basic', 'xdtree.basic', 'yptree.basic', 'hptree.basic'])->select()->toArray();

        $trarray = [];
        $num = 0;
        foreach ($tr as $k => $v) {
//            $trarray[$k]['title'] = $v['username'];
//            $trarray[$k]['id'] = $v['id'];

            if (!empty($v['trtree'])) {
                foreach ($v['trtree'] as $k1 => $v1) {
                    $v['trtree'][$k1]['title'] = $v['username'] . "翻译_文件编号:$v1[file_code_project]\r" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v1[tr_start_time]\r" . "结束时间:$v1[tr_end_time]";
                    $trarray[$num]['title'] = $v['trtree'][$k1]['title'];
                    $trarray[$num]['start'] = $v1['tr_start_time'];
                    $trarray[$num]['end'] = $v1['tr_end_time'];
                    $num++;
                }
            }
            if (!empty($v['xdtree'])) {
                foreach ($v['xdtree'] as $k2 => $v2) {
                    $v['trtree'][$k2]['title'] = $v['username'] . "校对_文件编号:$v2[file_code_project]\r" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v2[pr_start_time]\r" . "结束时间:$v2[pr_end_time]";
                    $trarray[$num]['title'] = $v['trtree'][$k2]['title'];;
                    $trarray[$num]['start'] = $v2['pr_start_time'];
                    $trarray[$num]['end'] = $v2['pr_end_time'];
                    $num++;
                }
            }
            if (!empty($v['yptree'])) {
                foreach ($v['yptree'] as $k3 => $v3) {
                    $v['trtree'][$k3]['title'] = $v['username'] . "预排_文件编号:$v3[file_code_project]\r" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v3[be_start_time]\r" . "结束时间:$v3[be_end_time]";
                    $trarray[$num]['title'] = $v['trtree'][$k3]['title'];
                    $trarray[$num]['start'] = $v3['be_start_time'];
                    $trarray[$num]['end'] = $v3['be_end_time'];
                    $num++;
                }
            }
            if (!empty($v['hptree'])) {
                foreach ($v['hptree'] as $k4 => $v4) {
                    $v['trtree'][$k4]['title'] = $v['username'] . "后排_文件编号:文件编号:$v4[file_code_project]\r" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v4[after_start_time]\r" . "结束时间:$v4[after_end_time]";
                    $trarray[$num]['title'] = $v['trtree'][$k4]['title'];
                    $trarray[$num]['start'] = $v4['after_start_time'];
                    $trarray[$num]['end'] = $v4['after_end_time'];
                    $num++;
                }
            }

        }

//        foreach ($trarray as $k5=>$v5)
//        {
//            if(isset($v5['children'])){
//                $trarray[$k5]['children']=array_values($v5['children']);
//            }
//
//        }
//        dump($trarray);
//        die;
        $this->assign(['a' => json_encode($trarray)]);


        return $this->fetch('test');
    }

    /**
     * @NodeAnotation(title="人员日程树形图")
     */
    public function tree()
    {
        if ($this->request->isAjax()) {
            $tr = SystemAdmin::with(['trtree.basic', 'xdtree.basic', 'yptree.basic', 'hptree.basic'])->select()->toArray();

            $trarray = [];
            foreach ($tr as $k => $v) {
                $trarray[$k]['title'] = $v['username'];
                $trarray[$k]['id'] = $v['id'];
                $trarray[$k]['spread'] = true;
                if (!empty($v['trtree'])) {
                    foreach ($v['trtree'] as $k1 => $v1) {
                        $v['trtree'][$k1]['title'] = "翻译_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v1[tr_start_time]\r" . "结束时间:$v1[tr_end_time]";
                        $trarray[$k]['children'][$k1]['title'] = $v['trtree'][$k1]['title'];

                    }
                }
                if (!empty($v['xdtree'])) {
                    foreach ($v['xdtree'] as $k2 => $v2) {
                        $v['trtree'][$k2]['title'] = "校对_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v2[pr_start_time]\r" . "结束时间:$v2[pr_end_time]";
                        $trarray[$k]['children'][$k1 + 1 + $k2]['title'] = $v['trtree'][$k2]['title'];

                    }
                }
                if (!empty($v['yptree'])) {
                    foreach ($v['yptree'] as $k3 => $v3) {
                        $v['trtree'][$k3]['title'] = "预排_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v3[be_start_time]\r" . "结束时间:$v3[be_end_time]";
                        $trarray[$k]['children'][$k1 + 1 + $k2 + 1 + $k3]['title'] = $v['trtree'][$k3]['title'];

                    }
                }
                if (!empty($v['hptree'])) {
                    foreach ($v['hptree'] as $k4 => $v4) {
                        $v['trtree'][$k4]['title'] = "后排_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v4[after_start_time]\r" . "结束时间:$v4[after_end_time]";
                        $trarray[$k]['children'][$k1 + 1 + $k2 + 1 + $k3 + 1 + $k4]['title'] = $v['trtree'][$k4]['title'];
                    }
                }

            }
            foreach ($trarray as $k5 => $v5) {
                if (isset($v5['children'])) {
                    $trarray[$k5]['children'] = array_values($v5['children']);
                }

            }

            return json($trarray);
        }

        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="人员日程表格图")
     */
    public function table()
    {
        $tr = SystemAdmin::with(['trtree.basic', 'xdtree.basic', 'yptree.basic', 'hptree.basic'])->select()->toArray();

        $trarray = [];
        foreach ($tr as $k => $v) {
            $trarray[$k]['title'] = $v['username'];
            $trarray[$k]['id'] = $v['id'];
            $trarray[$k]['spread'] = true;
            if (!empty($v['trtree'])) {
                foreach ($v['trtree'] as $k1 => $v1) {
                    $v['trtree'][$k1]['title'] = "翻译_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v1[tr_start_time]\r" . "结束时间:$v1[tr_end_time]";
                    $trarray[$k]['children'][$k1]['title'] = $v['trtree'][$k1]['title'];

                }
            }
            if (!empty($v['xdtree'])) {
                foreach ($v['xdtree'] as $k2 => $v2) {
                    $v['trtree'][$k2]['title'] = "校对_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v2[pr_start_time]\r" . "结束时间:$v2[pr_end_time]";
                    $trarray[$k]['children'][$k1 + 1 + $k2]['title'] = $v['trtree'][$k2]['title'];

                }
            }
            if (!empty($v['yptree'])) {
                foreach ($v['yptree'] as $k3 => $v3) {
                    $v['trtree'][$k3]['title'] = "预排_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v3[be_start_time]\r" . "结束时间:$v3[be_end_time]";
                    $trarray[$k]['children'][$k1 + 1 + $k2 + 1 + $k3]['title'] = $v['trtree'][$k3]['title'];

                }
            }
            if (!empty($v['hptree'])) {
                foreach ($v['hptree'] as $k4 => $v4) {
                    $v['trtree'][$k4]['title'] = "后排_" . "项目名称:" . $v1['basic']['project_name'] . "\r" . "开始时间:$v4[after_start_time]\r" . "结束时间:$v4[after_end_time]";
                    $trarray[$k]['children'][$k1 + 1 + $k2 + 1 + $k3 + 1 + $k4]['title'] = $v['trtree'][$k4]['title'];
                }
            }

        }
        foreach ($trarray as $k5 => $v5) {
            if (isset($v5['children'])) {
                $trarray[$k5]['children'] = array_values($v5['children']);
            }
        }

//        dump($trarray);
        $this->assign(['trarray' => $trarray]);

        return $this->fetch();
    }
}