<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\project\Description;

/**
 * @ControllerAnnotation(title="project_schedule")
 */
class Schedule extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\schedule();

        $this->assign('getLateSubmissionList', $this->model->getLateSubmissionList());

        $this->assign('getSelfInspectionStatusList', $this->model->getSelfInspectionStatusList());

        $this->assign('getUpdateMainLibraryList', $this->model->getUpdateMainLibraryList());

        $this->assign('getTerminologySubmitList', $this->model->getTerminologySubmitList());

        $this->assign('getFinalizedSubmitList', $this->model->getFinalizedSubmitList());

    }


    /**
     * @NodeAnotation(title="进度列表")
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
//                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation'
//                    ,
//                ], 'LEFT')
                ->when($a, function ($query, $a) {
                    // 满足条件后执行
                    return $query->where('description_id', $a);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->when($a, function ($query, $a) {
                    // 满足条件后执行
                    return $query->where('description_id', $a);
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
        $this->assign(['description_id' => $a]);
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
                //计算实际用时
                $post['actual_time'] = round((strtotime($post['end_time']) - strtotime($post['start_time'])) / 3600, 2);
                // 计算中文字数=(原总字数*(100-总重复率/100)-扣除字数
                //查询项目描述
                $description = Description::find($post['description_id']);
                $post['chinese_word_count'] = ($post['original_word_count'] * (100 - $description['repetition_rateall']) / 100) - $description['deduction_number'];
                //计算效率=中文字数/实际用时
                $post['efficiency'] = round($post['chinese_word_count'] / $post['actual_time'], 2);
//                dump($post);die;
                $admin = session('admin');
                $post['writer_id'] = $admin['id'];
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }

        $this->assign('description_id', $a);
        return $this->fetch();
    }

}