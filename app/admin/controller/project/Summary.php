<?php

namespace app\admin\controller\project;

use app\admin\model\customer\Customeraa;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\project\Basic;

/**
 * @ControllerAnnotation(title="项目总结")
 */
class Summary extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $basic = Basic::field(['project_name', 'id'])->select();
//        $basic = Basic::field(['project_name', 'id'])->where('write_id|principal_id', 'find in set', $this->admininfo()['id'])->select();
        $ba = $this->xmdata($basic, 'sd', 'project_name');
        $this->assign(['basic' => $ba]);
        $this->model = new \app\admin\model\project\Summary();

    }

    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $ne = \app\admin\model\project\Description::field('id, basic_id')->where('basic_id', $post['basic_id'])->find();
            $post['Involved_products'] = $ne['related_products'];
//            $post['language'] = '语种';
            $post['summary_write_id'] = $this->admininfo()['id'];
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        return $this->fetch();
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
                ->where($where)
                ->withJoin(['basic', 'write'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['basic', 'write'
                ], 'LEFT')
                ->page($page, $limit)
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
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        $row = $this->model->find($id);
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);

        $basic = Basic::field(['project_name', 'id'])->where('write_id|principal_id', 'find in set', $this->admininfo()['id'])->select();

        $staff = array();
        foreach ($basic as $k => $v) {
            $staff[$k]['name'] = $v['project_name'];
            $staff[$k]['value'] = $v['id'];
            if ($v['id'] == $row['basic_id']) {
                $staff[$k]['selected'] = true;
            }
        }

        $this->assign(['basic' => $staff]);
        return $this->fetch();
    }

}