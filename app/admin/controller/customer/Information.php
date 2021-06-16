<?php

namespace app\admin\controller\customer;

use app\admin\model\customer\CustomerContract;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;

/**
 * @ControllerAnnotation(title="客户联系人")
 */
class Information extends AdminController
{

    use \app\admin\traits\Curd;
    public function __construct(App $app)
    {
        parent::__construct($app);
//        客户
        $b = CustomerContract::order('id','desc')->select();
//        dump($b->toArray());
        $this->assign('b', $b);
        $this->model = new \app\admin\model\customer\Customer();

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
                ->withJoin(['write','contract'], 'LEFT')
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('information_writer_id', 'in', $this->admininfo()['top_id']);
                })
                ->where($where)
                ->count();
            $list = $this->model
                ->when($this->admininfo()['id'] != 1, function ($query) {
                    // 满足条件后执行
                    return $query->where('information_writer_id', 'in', $this->admininfo()['top_id']);
                })
                ->withJoin(['write','contract'], 'LEFT')
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select();

//            dump($list->toArray());die;
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
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $admin = session('admin');
                $post['information_writer_id'] = $admin['id'];
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        return $this->fetch();
    }


}