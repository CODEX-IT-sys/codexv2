<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
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
        //翻译人员
        $tr = Cache::get('tr');
        $xd = Cache::get('xd');

        $n = [];
        foreach ($tr as $k => $v) {
            $n[$k]['name'] = $v['username'];
            $n[$k]['value'] = $v['id'];
        }
        $m = [];
        foreach ($xd as $k => $v) {
            $m[$k]['name'] = $v['username'];
            $m[$k]['value'] = $v['id'];
        }
//        负责人列表
        $fz=array_merge($n,$m);
        $this->assign(['fz'=>$fz]);
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
                    return $query->where('write_id','find in set',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
                })
                ->where($where)
                ->count();
            $list = $this->model
                ->where($where)
//                ->when($this->admininfo()['id']!=1, function ($query) {
//                    // 满足条件后执行
//                    return $query->where('write_id','find in set',$this->admininfo()['id'])->whereor('write_id','in',$this->admininfo()['top_id']);
//                })
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
        //翻译人员/校对
        $tr = Cache::get('tr');
        $xd = Cache::get('xd');
        $fzvalue = explode(',', $row['principal_id']);
        $n = [];
        foreach ($tr as $k => $v) {
            $n[$k]['name'] = $v['username'];
            $n[$k]['value'] = $v['id'];
        }
        $m = [];
        foreach ($xd as $k => $v) {
            $m[$k]['name'] = $v['username'];
            $m[$k]['value'] = $v['id'];
        }
        $fz=array_merge($n,$m);
        foreach ($fz as $k => $v) {
            if (in_array($v['name'], $fzvalue)) {
                $fz[$k]['selected'] = true;
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
           'fz'=>$fz
        ]);
        return $this->fetch();
    }




}