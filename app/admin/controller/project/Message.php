<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;

/**
 * @ControllerAnnotation(title="project_message")
 */
class Message extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\Message();

    }

    /**
     * @NodeAnotation(title="列表")
     */
    public function message()
    {

        $messagelist2 = $this->model->with(['write','addressee'])->where('addressee_id', $this->admininfo()['id'])->where('status','0')->order('create_time','desc')->select();
        $messagelist1 = $this->model->with(['write','addressee'])->where('addressee_id', $this->admininfo()['id'])->where('status','1')->order('create_time','desc')->select();

        $this->assign('message1',$messagelist1);
        $this->assign('message2',$messagelist2);
        return $this->fetch();
    }
    /**
     * @NodeAnotation(title="消息标记已读")
     */
    public function read($id)
    {
        $row=$this->model->where('id', $id)->find();
        $row->status=1;
        $row->save();
        return json(['code' => 1, 'msg' => '成功']);
    }
    /**
     * @NodeAnotation(title="定时未读消息检测")
     */
    public function remind()
    {
       $num= $this->model->where('addressee_id', $this->admininfo()['id'])->where('status','0')->order('create_time','desc')->count();

       if($num>0)
       {
           return json(['code' => 1, 'msg' => 'yes']);
       }else{
           return json(['code' => 2, 'msg' => 'no']);
       }
    }
    /**
     * @NodeAnotation(title="未读消息提醒")
     */
    public function new()
    {
        return $this->fetch();
    }
}