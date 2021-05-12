<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\SystemAdmin;
use think\facade\Cache;
use app\admin\model\setting\DatabaseContent;
/**
 * @ControllerAnnotation(title="项目基本信息")
 */
class Basic extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        //人员信息
        $man = SystemAdmin::field('username,id')->select();
        $fz = array();
        foreach ($man as $k => $v) {
            $fz[$k]['name'] = $v['username'];
            $fz[$k]['value'] = $v['id'];
            //删除自己
            if ($fz[$k]['value'] == $this->admininfo()['id']) {
                unset($fz[$k]);
            }
        }
//        负责人列表

        $this->assign(['fz'=>array_values($fz)]);
        $this->model = new \app\admin\model\project\basic();
        
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
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id|principal_id','find in set',$this->admininfo()['id'])->whereor('write_id|principal_id','in',$this->admininfo()['top_id']);
                })
                ->where($where)
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query->where('write_id|principal_id','find in set',$this->admininfo()['id'])->whereor('write_id|principal_id','in',$this->admininfo()['top_id']);
                })
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
            $data = [
                'code'  => 0,
                'msg'   => '',
                'count' => $count,
                'data'  => $list,
            ];
            return json($data);
        }
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $post['write_id']=$this->admininfo()['id'];


                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:'.$e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        $row = $this->model->find($id);
        //人员信息
        $man = SystemAdmin::field('username,id')->select();
        $fz = array();
        foreach ($man as $k => $v) {
            $fz[$k]['name'] = $v['username'];
            $fz[$k]['value'] = $v['id'];
            //删除自己
            if ($fz[$k]['value'] == $this->admininfo()['id']) {
                unset($fz[$k]);
            }
        }
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
        $this->assign([
           'fz'=>array_values($fz)
        ]);
        return $this->fetch();
    }




}