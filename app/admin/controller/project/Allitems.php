<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Db;
use think\facade\Cache;
use app\admin\model\SystemAdmin;

/**
 * @ControllerAnnotation(title="项目汇总")
 */
class Allitems extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        //单位
        $d = Cache::get('dw');
        //服务
        $g = Cache::get('fw');
        $n=[];
        foreach ($g as $k=>$v)
        {
            $n[$k]['name'] = $v['username'];
            $n[$k]['value'] = $v['id'];
        }

        //语种
        $h = Cache::get('yz');
        //文件类型
        $f = Cache::get('file_type');
        //税率
        $s = Cache::get('sl');
        //文件分类
        $cate = Cache::get('cate');
        //项目经理
        $b = SystemAdmin::wherein('auth_ids', [12])->select();
        //项目助理
        $Assignor = SystemAdmin::wherein('auth_ids', [15])->select();
        //难度
        $level = Cache::get('level');
        $admin = $this->admininfo();
        $this->assign([
            'd' => $d, 'i' => $n, 'h' => $h, 'n' => $f, 's' => $s, 'st' => $admin, 'b' => $b, 'level' => $level, 'Assignor' => $Assignor, 'cate' => $cate
        ]);


        $this->model = new \app\admin\model\customer\Customeraa();

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
                ->where('file_status', 3)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm',
                    'assignor', 'tyevel', 'trevel'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 3)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm',
                    'assignor', 'tyevel', 'trevel'
                ], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
//            dump($list);die;
//            foreach ($list as $k => $v) {
//                foreach ($v['service'] as $k1 => $v1) {
//                    $v['service'][$k1] = Db::name('database_content')->where('id', $v1)->value('content');
//                }
//                $list[$k]['fw'] = implode(",", $v['service']);
//            }
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
     * @NodeAnotation(title="已交稿")
     */
    public function handover()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->where('file_status', 4)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 4)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm'], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
            foreach ($list as $k => $v) {
                foreach ($v['service'] as $k1 => $v1) {
                    $v['service'][$k1] = Db::name('database_content')->where('id', $v1)->value('content');
                }
                $list[$k]['fw'] = implode(",", $v['service']);
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
     * @NodeAnotation(title="未交稿")
     */
    public function undelivered()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->where('file_status', 3)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm'], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 3)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm'], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
            foreach ($list as $k => $v) {
                foreach ($v['service'] as $k1 => $v1) {
                    $v['service'][$k1] = Db::name('database_content')->where('id', $v1)->value('content');
                }
                $list[$k]['fw'] = implode(",", $v['service']);
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
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        //文件分类
        $cate = Cache::get('cate');
        //翻译人员
        $tr = Cache::get('tr');
        $yp = Cache::get('yp');
        $hp = Cache::get('hp');
        $xd = Cache::get('xd');
        $row = $this->model->find($id);
        $value = explode(',', $row['file_cate']);
        $trvalue = explode(',', $row['translation_id']);
        $ypvalue = explode(',', $row['before_ty_id']);
        $hpvalue = explode(',', $row['after_ty_id']);
        $xdvalue = explode(',', $row['proofreader_id']);
        $c = array();
        foreach ($cate as $k => $v) {
            $c[$k]['name'] = $v['content'];
            $c[$k]['value'] = $v['id'];
            if (in_array($v['id'], $value)) {
                $c[$k]['selected'] = true;
            }
        }
        //翻译
        $d = array();
        foreach ($tr as $k => $v1) {
            $d[$k]['name'] = $v1['username'];
            $d[$k]['value'] = $v1['id'];
            if (in_array($v1['id'], $trvalue)) {
                $d[$k]['selected'] = true;
            }
        }
        //预排
        $e = array();
        foreach ($yp as $k => $v1) {
            $e[$k]['name'] = $v1['username'];
            $e[$k]['value'] = $v1['id'];
            if (in_array($v1['id'], $ypvalue)) {
                $e[$k]['selected'] = true;
            }
        }
        //后排
        $f = array();
        foreach ($hp as $k => $v1) {
            $f[$k]['name'] = $v1['username'];
            $f[$k]['value'] = $v1['id'];
            if (in_array($v1['id'], $hpvalue)) {
                $f[$k]['selected'] = true;
            }
        }
        //  校对
        $g = array();
        foreach ($xd as $k => $v1) {
            $g[$k]['name'] = $v1['username'];
            $g[$k]['value'] = $v1['id'];
            if (in_array($v1['id'], $xdvalue)) {
                $g[$k]['selected'] = true;
            }
        }
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $post['service'] = implode(",", ($post['service']));
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败', $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        $this->assign([
            'c' => $c, 'd' => $d, 'e' => $e, 'f' => $f, 'g' => $g
        ]);
        return $this->fetch();
    }


}