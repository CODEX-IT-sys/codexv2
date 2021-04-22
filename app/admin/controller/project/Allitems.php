<?php

namespace app\admin\controller\project;

use app\admin\model\customer\Customeraa;
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
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm',
                    'assignor', 'tyevel', 'trevel'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->where('file_status', 4)
                ->withJoin(['type', 'rate', 'yz', 'dw', 'customerInformation', 'xm',
                    'assignor', 'tyevel', 'trevel'
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
            if (in_array($v['content'], $value)) {
                $c[$k]['selected'] = true;
            }
        }
        //翻译
        $d = array();
        foreach ($tr as $k => $v1) {
            $d[$k]['name'] = $v1['username'];
            $d[$k]['value'] = $v1['id'];
            if (in_array($v1['username'], $trvalue)) {
                $d[$k]['selected'] = true;
            }
        }
        //预排
        $e = array();
        foreach ($yp as $k => $v1) {
            $e[$k]['name'] = $v1['username'];
            $e[$k]['value'] = $v1['id'];
            if (in_array($v1['username'], $ypvalue)) {
                $e[$k]['selected'] = true;
            }
        }
        //后排
        $f = array();
        foreach ($hp as $k => $v1) {
            $f[$k]['name'] = $v1['username'];
            $f[$k]['value'] = $v1['id'];
            if (in_array($v1['username'], $hpvalue)) {
                $f[$k]['selected'] = true;
            }
        }
        //  校对
        $g = array();
        foreach ($xd as $k => $v1) {
            $g[$k]['name'] = $v1['username'];
            $g[$k]['value'] = $v1['id'];
            if (in_array($v1['username'], $xdvalue)) {
                $g[$k]['selected'] = true;
            }
        }
        //服务
        $fw = Cache::get('fw');
        $n = [];
        $value = explode(',', $row['service']);
        foreach ($fw as $k => $v) {
            $n[$k]['name'] = $v['content'];
            $n[$k]['value'] = $v['id'];
            if (in_array($v['content'], $value)) {
                $n[$k]['selected'] = true;
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
                $this->error('保存失败', $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        $this->assign([
            'c' => $c, 'd' => $d, 'e' => $e, 'f' => $f, 'g' => $g,'fw'=>$n
        ]);
        return $this->fetch();
    }
    /**
     * @NodeAnotation(title="交稿")
     */
    public function deliver($id)
    {

        try {
            $res=Customeraa::find($id);
            $res->file_status=4;
            $res->save();
        } catch (\Exception $e) {
            // 这是进行异常捕获
            $this->error('交稿失败', $e->getMessage());
        }
        $this->success('交稿成功') ;
    }

    /**
     * @NodeAnotation(title="总经理批准")
     */
    public function general()
    {
        $post = $this->request->post();
        try {
            $admin=$this->admininfo();
            //分配权限时注意一下,此处暂不写验证是否当前职位
            Customeraa::wherein('id',$post['id'])->update(['general_approval'=>$admin['username']]);
        } catch (\Exception $e) {
            // 这是进行异常捕获
            $this->error('批准失败', $e->getMessage());
        }
        $this->success('批准成功') ;
    }

    /**
     * @NodeAnotation(title="项目经理批准")
     */
    public function m()
    {
        $post = $this->request->post();
        try {
            $admin=$this->admininfo();
            Customeraa::wherein('id',$post['id'])->update(['m_approval'=>$admin['username']]);
        } catch (\Exception $e) {
            // 这是进行异常捕获
            $this->error('批准失败', $e->getMessage());
        }
        $this->success('批准成功') ;
    }


}