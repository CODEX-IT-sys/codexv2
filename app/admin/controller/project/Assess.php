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
        $file=\app\admin\model\project\Description::field(['id','file_code_project','file_name_project'])->select();

        $this->assign(['type' => 1]);
        $this->assign(['file' => $file]);
        if(isset( $data['id'])){
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
        $file=\app\admin\model\project\Description::field(['id','file_code_project','file_name_project'])->select();

        $this->assign(['type' => 2]);
        $this->assign(['file' => $file]);
        if(isset( $data['id'])){
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
        $file=\app\admin\model\project\Description::field(['id','file_code_project','file_name_project'])->select();

        $this->assign(['type' => 3]);
        $this->assign(['file' => $file]);
        if(isset( $data['id'])){
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
        try {
            $post['write_id'] = $this->admininfo()['id'];
            $post['pj_dafter_ty_id'] = \app\admin\model\project\Description::where('id',$post['description_id'])->value('dafter_ty_id');
            $post['pj_dbefore_ty_id'] = \app\admin\model\project\Description::where('id',$post['description_id'])->value('dbefore_ty_id');
            $post['pj_dtranslation_id'] = \app\admin\model\project\Description::where('id',$post['description_id'])->value('dtranslation_id');
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
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id','=',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where($where)
                ->where('type',1)
                ->withJoin(['file','write','yp'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id','=',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where('type',1)
                ->withJoin(['file','write','yp'
                ])
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();

//            dump($list);die;
//            foreach ($list as $k=>$v)
//            {
//                    $list[$k]['yp']=SystemAdmin::where('id',$v['file']['dbefore_ty_id'])->value('username');
//            }

//            dump($list);die;
            $data = [
                'code'  => 0,
                'msg'   => '',
                'count' => $count,
                'data'  => $list,
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
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id','find in set',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where('type',2)
                ->withJoin(['file','write','hp'
                ], 'LEFT')
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('dbefore_ty_id',$this->admininfo()['id']);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id','find in set',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where('type',2)
                ->withJoin(['file','write','hp'
                ], 'LEFT')
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('write_id',$this->admininfo()['id']);
                })
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
            $data = [
                'code'  => 0,
                'msg'   => '',
                'count' => $count,
                'data'  => $list,
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
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id','find in set',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where('type',3)
                ->withJoin(['file','write','tr'
                ], 'LEFT')
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('dbefore_ty_id',$this->admininfo()['id']);
                })
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id','find in set',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where('type',3)
                ->withJoin(['file','write','tr'
                ], 'LEFT')
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('write_id',$this->admininfo()['id']);
                })
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
            $data = [
                'code'  => 0,
                'msg'   => '',
                'count' => $count,
                'data'  => $list,
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
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $file=\app\admin\model\project\Description::field(['id','file_code_project','file_name_project'])->select();
        $this->assign(['file' => $file]);
//        dump($row);die;
        $this->assign('row', $row);
        return $this->fetch();
    }

}