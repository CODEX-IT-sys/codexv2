<?php

namespace app\admin\controller\project;

use app\admin\model\SystemAdmin;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;

/**
 * @ControllerAnnotation(title="评估")
 */
class Assess extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\Assess();

        $this->assign('getYpLayoutFormatList', $this->model->getYpLayoutFormatList());

        $this->assign('getYpContentCheckList', $this->model->getYpContentCheckList());

        $this->assign('getYpCustomerRequestList', $this->model->getYpCustomerRequestList());

        $this->assign('getYpOverallEvaluationList', $this->model->getYpOverallEvaluationList());

        $this->assign('getHpLayoutFormatList', $this->model->getHpLayoutFormatList());

        $this->assign('getHpContentCheckList', $this->model->getHpContentCheckList());

        $this->assign('getHpCustomerRequestList', $this->model->getHpCustomerRequestList());

        $this->assign('getHpOverallEvaluationList', $this->model->getHpOverallEvaluationList());

        $this->assign('getTrOmissionsList', $this->model->getTrOmissionsList());

        $this->assign('getTrRedundantList', $this->model->getTrRedundantList());

        $this->assign('getTrUnderstandingList', $this->model->getTrUnderstandingList());

        $this->assign('getTrInputErrorList', $this->model->getTrInputErrorList());

        $this->assign('getTrNotUniformList', $this->model->getTrNotUniformList());

        $this->assign('getTrNotUniformWithList', $this->model->getTrNotUniformWithList());

        $this->assign('getTrInappropriateTerminologyList', $this->model->getTrInappropriateTerminologyList());

        $this->assign('getTrImproperPunctuationList', $this->model->getTrImproperPunctuationList());

        $this->assign('getTrOutHabitList', $this->model->getTrOutHabitList());

        $this->assign('getTrSyntaxErrorList', $this->model->getTrSyntaxErrorList());

        $this->assign('getTrFluencyOfExpressionList', $this->model->getTrFluencyOfExpressionList());

        $this->assign('getTrReferenceList', $this->model->getTrReferenceList());

        $this->assign('getTrRepeatedlyList', $this->model->getTrRepeatedlyList());

    }

    /**
     * @NodeAnotation(title="预排评估")
     */
    public function assessyp()
    {
        $data = $this->request->param();

        if ($this->request->isPost()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $file = \app\admin\model\project\Description::field(['id', 'file_code_project', 'file_name_project'])->select();

        $this->assign(['type' => 1]);
        $this->assign(['file' => $file]);
        if (isset($data['id'])) {
            $this->assign(['id' => $data['id']]);
        }
        return $this->fetch('add');
    }

    /**
     * @NodeAnotation(title="后排评估")
     */
    public function assesshp()
    {
        $data = $this->request->param();

        if ($this->request->isPost()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $file = \app\admin\model\project\Description::field(['id', 'file_code_project', 'file_name_project'])->select();

        $this->assign(['type' => 2]);
        $this->assign(['file' => $file]);
        if (isset($data['id'])) {
            $this->assign(['id' => $data['id']]);
        }
        return $this->fetch('add');
    }

    /**
     * @NodeAnotation(title="翻译评估")
     */
    public function assesstr()
    {
        $data = $this->request->param();

        if ($this->request->isPost()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $file = \app\admin\model\project\Description::field(['id', 'file_code_project', 'file_name_project'])->select();

        $this->assign(['type' => 3]);
        $this->assign(['file' => $file]);
        if (isset($data['id'])) {
            $this->assign(['id' => $data['id']]);
        }
        return $this->fetch('add');
    }


    /**
     * @NodeAnotation(title="评估保存")
     */

    public function save()
    {
        $post = $this->request->post();
        $post['write_id'] = $this->admininfo()['id'];


//        $post['pj_dbefore_ty_id'] = \app\admin\model\project\Description::where('id', $post['description_id'])->value('dbefore_ty_id');

        if ($post['type'] == 2) {
            $post['pj_dafter_ty_id'] = \app\admin\model\project\Description::where('id', $post['description_id'])->value('dafter_ty_id');
            if ($post['pj_dafter_ty_id'] == '') {
                echo '<script>
   alert(\'保存失败:后排人员尚未指定\');
                </script>';
                echo "<script>history.go(-1);</script>";
                return;
            }

            $f = [$post['hp_layout_format'], $post['hp_content_check'], $post['hp_customer_request']];
            // 对数组中的所有值进行计数
            $num = array_count_values($f);
            $n['A'] = isset($num['1']) ? $num['1'] : 0;
            $n['B'] = isset($num['2']) ? $num['2'] : 0;
            $n['C'] = isset($num['3']) ? $num['3'] : 0;
            $n['D'] = isset($num['4']) ? $num['4'] : 0;
            if ($n['A'] == 3) {

                $post['hp_overall_evaluation'] = '1';

            } elseif ($n['A'] + $n['B'] >= 2 && $n['D'] == 0) {

                $post['hp_overall_evaluation'] = '2';

            } elseif ($n['C'] + $n['D'] == 3 or $n['D'] >= 2) {

                $post['hp_overall_evaluation'] = '4';
            } else {
                $post['hp_overall_evaluation'] = '3';
            }
        } elseif ($post['type'] == 3) {
            $post['pj_dtranslation_id'] = \app\admin\model\project\Description::where('id', $post['description_id'])->value('dtranslation_id');
            if ($post['pj_dtranslation_id'] == '') {
                echo '<script>
   alert(\'保存失败:后排人员尚未指定\');
                </script>';
                echo "<script>history.go(-1);</script>";
                return;
            }
            $f = [$post['tr_omissions'], $post['tr_redundant'], $post['tr_understanding'],
                $post['tr_input_error'], $post['tr_not_uniform'],
                $post['tr_not_uniform_with'], $post['tr_inappropriate_terminology'],
                $post['tr_improper_punctuation'], $post['tr_out_habit'],
                $post['tr_syntax_error'], $post['tr_fluency_of_expression'],
                $post['tr_reference'], $post['tr_repeatedly'],
            ];
            // 对数组中的所有值进行计数
            $num = array_count_values($f);
            $n['A'] = isset($num['1']) ? $num['1'] : 0;
            $n['B'] = isset($num['2']) ? $num['2'] : 0;
            $n['C'] = isset($num['3']) ? $num['3'] : 0;
            $n['D'] = isset($num['4']) ? $num['4'] : 0;
            if ($n['A'] >= 10 && $n['C'] == 0 && $n['D'] == 0) {

                $post['tr_overall_evaluation'] = '1';

            } elseif ($n['A'] + $n['B'] >= 8 && $n['D'] == 0) {

                $post['tr_overall_evaluation'] = '2';

            } elseif ($n['C'] + $n['D'] >= 10 && $n['D'] >= 5) {

                $post['tr_overall_evaluation'] = '4';
            } else {
                $post['tr_overall_evaluation'] = '3';
            }

        } elseif ($post['type'] == 1) {
            $post['pj_dbefore_ty_id'] = \app\admin\model\project\Description::where('id', $post['description_id'])->value('dbefore_ty_id');
            if ($post['pj_dbefore_ty_id'] == '') {
                echo '<script>
   alert(\'保存失败:后排人员尚未指定\');
                </script>';
                echo "<script>history.go(-1);</script>";
                return;
            }

            /*计算 整体评价*/
            $f = [$post['yp_layout_format'], $post['yp_font'], $post['yp_directory_link']
                , $post['yp_table_img'], $post['yp_content_check'], $post['yp_customer_request']
            ];
            // 对数组中的所有值进行计数
            $num = array_count_values($f);
            $n['A'] = isset($num['1']) ? $num['1'] : 0;
            $n['B'] = isset($num['2']) ? $num['2'] : 0;
            $n['C'] = isset($num['3']) ? $num['3'] : 0;
            $n['D'] = isset($num['4']) ? $num['4'] : 0;
            if ($n['A'] >= 5 && $n['C'] == 0 && $n['D'] == 0) {
                $post['yp_overall_evaluation'] = '1';
            } elseif ($n['A'] + $n['B'] >= 5 && $n['D'] == 0) {
                $post['yp_overall_evaluation'] = '2';
            } elseif ($n['C'] + $n['D'] == 3 or $n['D'] >= 2) {
                $post['yp_overall_evaluation'] = '4';
            } else {
                $post['yp_overall_evaluation'] = '3';
            }
        }
        try {

            $save = $this->model->save($post);
        } catch (\Exception $e) {
            $this->error('保存失败:' . $e->getMessage());
        }
        echo '<script>
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index); //再执行关闭 
    </script>';

    }

    /**
     * @NodeAnotation(title="预排评估表")
     */
    public function ypindex()
    {

        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id', 'in', $this->admininfo()['top_id']);
                })
                ->where('type', 1)
                ->withJoin(['file', 'write', 'yp'
                ])
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id', 'in', $this->admininfo()['top_id']);
                })
                ->where('type', 1)
                ->withJoin(['file', 'write', 'yp'
                ])
                ->page($page, $limit)
                ->order($this->sort)
                ->select();

//            dump($list);die;
//            foreach ($list as $k=>$v)
//            {
//                    $list[$k]['yp']=SystemAdmin::where('id',$v['file']['dbefore_ty_id'])->value('username');
//            }

//            dump($list);die;
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
//withjoin不能嵌套查询,
//A id a
//B aid b
//C bid C
//不能嵌套查询如何通过查C获取A表的值
    /**
     * @NodeAnotation(title="后排评估表")
     */
    public function hpindex()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id', 'in', $this->admininfo()['top_id']);
                })
                ->where('type', 2)
                ->withJoin(['file', 'write', 'hp'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('type', 2)
                ->withJoin(['file', 'write', 'hp'
                ], 'LEFT')
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id', 'in', $this->admininfo()['top_id']);
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
        return $this->fetch('index');
    }

    /**
     * @NodeAnotation(title="翻译评估表")
     */
    public function trindex()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id', 'in', $this->admininfo()['top_id']);
                })
                ->where('type', 3)
                ->withJoin(['file', 'write', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id', 'in', $this->admininfo()['top_id']);
                })
                ->where('type', 3)
                ->withJoin(['file', 'write', 'tr'
                ], 'LEFT')
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
        return $this->fetch('index');
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
//            dump($post);die;
            $rule = [];
            $this->validate($post, $rule);
            try {
                if ($post['type'] == 2) {
                    $f = [$post['hp_layout_format'], $post['hp_content_check'], $post['hp_customer_request']];
                    // 对数组中的所有值进行计数
                    $num = array_count_values($f);
                    $n['A'] = isset($num['1']) ? $num['1'] : 0;
                    $n['B'] = isset($num['2']) ? $num['2'] : 0;
                    $n['C'] = isset($num['3']) ? $num['3'] : 0;
                    $n['D'] = isset($num['4']) ? $num['4'] : 0;
                    if ($n['A'] == 3) {

                        $post['hp_overall_evaluation'] = '1';

                    } elseif ($n['A'] + $n['B'] >= 2 && $n['D'] == 0) {

                        $post['hp_overall_evaluation'] = '2';

                    } elseif ($n['C'] + $n['D'] == 3 or $n['D'] >= 2) {

                        $post['hp_overall_evaluation'] = '4';
                    } else {
                        $post['hp_overall_evaluation'] = '3';
                    }
                } elseif ($post['type'] == 3) {
                    $f = [$post['tr_omissions'], $post['tr_redundant'], $post['tr_understanding'],
                        $post['tr_input_error'], $post['tr_not_uniform'],
                        $post['tr_not_uniform_with'], $post['tr_inappropriate_terminology'],
                        $post['tr_improper_punctuation'], $post['tr_out_habit'],
                        $post['tr_syntax_error'], $post['tr_fluency_of_expression'],
                        $post['tr_reference'], $post['tr_repeatedly'],
                    ];
                    // 对数组中的所有值进行计数
                    $num = array_count_values($f);
                    $n['A'] = isset($num['1']) ? $num['1'] : 0;
                    $n['B'] = isset($num['2']) ? $num['2'] : 0;
                    $n['C'] = isset($num['3']) ? $num['3'] : 0;
                    $n['D'] = isset($num['4']) ? $num['4'] : 0;
                    if ($n['A'] >= 10 && $n['C'] == 0 && $n['D'] == 0) {

                        $post['tr_overall_evaluation'] = '1';

                    } elseif ($n['A'] + $n['B'] >= 8 && $n['D'] == 0) {

                        $post['tr_overall_evaluation'] = '2';

                    } elseif ($n['C'] + $n['D'] >= 10 && $n['D'] >= 5) {

                        $post['tr_overall_evaluation'] = '4';
                    } else {
                        $post['tr_overall_evaluation'] = '3';
                    }

                } elseif ($post['type'] == 1) {
                    /*计算 整体评价*/
                    $f = [$post['yp_layout_format'], $post['yp_font'], $post['yp_directory_link']
                        , $post['yp_table_img'], $post['yp_content_check'], $post['yp_customer_request']
                    ];
                    // 对数组中的所有值进行计数
                    $num = array_count_values($f);
                    $n['A'] = isset($num['1']) ? $num['1'] : 0;
                    $n['B'] = isset($num['2']) ? $num['2'] : 0;
                    $n['C'] = isset($num['3']) ? $num['3'] : 0;
                    $n['D'] = isset($num['4']) ? $num['4'] : 0;
                    if ($n['A'] >= 5 && $n['C'] == 0 && $n['D'] == 0) {
                        $post['yp_overall_evaluation'] = '1';
                    } elseif ($n['A'] + $n['B'] >= 5 && $n['D'] == 0) {
                        $post['yp_overall_evaluation'] = '2';
                    } elseif ($n['C'] + $n['D'] == 3 or $n['D'] >= 2) {
                        $post['yp_overall_evaluation'] = '4';
                    } else {
                        $post['yp_overall_evaluation'] = '3';
                    }
                }
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败',$e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $file = \app\admin\model\project\Description::field(['id', 'file_code_project', 'file_name_project'])->select();
        $this->assign(['file' => $file]);
//        dump($row);die;
        $this->assign('row', $row);
        return $this->fetch();
    }

}