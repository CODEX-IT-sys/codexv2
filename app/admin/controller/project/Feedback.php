<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\customer\Customeraa;
/**
 * @ControllerAnnotation(title="客户反馈")
 */
class Feedback extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\Feedback();
        
        $this->assign('getFeedbackList', $this->model->getFeedbackList());
        $basic = Customeraa::field(['customer_file_code', 'id'])->where('file_status', 'in', '3,4')->select();
        $ba = $this->xmdata($basic, 'sd', 'customer_file_code');
        $this->assign(['file_id' => $ba]);
    }



    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $post['feedback_write_id']=$this->admininfo()['id'];

            $file=Customeraa::find($post['file_id']);
            $post['tr']=$file['translation_id'];
            $post['yp']=$file['before_ty_id'];
            $post['hp']=$file['after_ty_id'];
            $post['xd']=$file['proofreader_id'];
            $post['pa']=$file['assistant_id'];
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $this->model->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败:'.$e->getMessage());
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
                ->withJoin(['fileaa', 'write','pa'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa', 'write','pa'
                ], 'LEFT')
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
                $this->error('保存失败',$e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

    
}