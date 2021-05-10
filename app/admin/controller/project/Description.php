<?php

namespace app\admin\controller\project;

use app\admin\model\customer\Customer;
use app\admin\model\customer\Customeraa;
use app\admin\model\SystemAdmin;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Cache;
use think\facade\Db;
use app\admin\model\project\Comment;
use app\admin\model\project\Message;
/**
 * @ControllerAnnotation(title="项目描述")
 */
class Description extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\Description();
        $this->assign('status', $this->model->getDescriptionStatusList());

    }


    /**
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        //翻译人员
        $tr = Cache::get('tr');
        $xd = Cache::get('xd');
        $yp = Cache::get('yp');
        $hp = Cache::get('hp');
        $row = $this->model->find($id);
        $trvalue = explode(',', $row['dtranslation_id']);
        $ypvalue = explode(',', $row['dbefore_ty_id']);
        $hpvalue = explode(',', $row['dafter_ty_id']);
        $xdvalue = explode(',', $row['dproofreader_id']);

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
            // 启动事务
            Db::startTrans();
            try {

                $save = $row->save($post);
                $res = $this->model->where('id', $id)->find();

                //同步更新项目汇总信息,查询相同文件
                $neq = Db::name('project_description')->where('file_id', $res['file_id'])->field(['dtranslation_id', 'dproofreader_id', 'dbefore_ty_id', 'dafter_ty_id'
                    , 'tr_start_time', 'tr_end_time'
                    , 'pr_start_time', 'pr_end_time'
                    , 'be_start_time', 'be_end_time'
                    , 'after_start_time', 'after_start_time'
                ])->select()->toArray();
//                时间待同步
                /*                $tr_start_time=  Db::name('project_description')->where('file_id',$res['file_id'])->field(
                                    'min(tr_start_time) as tr_start_time,
                                            max(tr_end_time) as tr_end_time,
                                            min(pr_start_time) as pr_start_time,
                                            max(pr_end_time) as pr_end_time,
                                            min(be_start_time) as be_start_time,
                                            max(be_end_time) as be_end_time,
                                            min(after_start_time) as after_start_time,
                                            max(after_end_time) as after_end_time
                                     '
                //                    'max(tr_start_time) tr_start_time','tr_end_time'
                //                    ,'pr_start_time','pr_end_time'
                //                    ,'be_start_time','be_end_time'
                //                    ,'after_start_time','after_start_time'
                                )->group('tr_start_time,tr_end_time,pr_start_time,pr_end_time,be_start_time,be_end_time,after_start_time,after_end_time')->select();
                                dump($tr_start_time);die;*/
                $translation = [];
                $proofreader = [];
                $before = [];
                $after = [];
                foreach ($neq as $k => $v) {
                    $translation[] = $v['dtranslation_id'];
                    $proofreader[] = $v['dproofreader_id'];
                    $before[] = $v['dbefore_ty_id'];
                    $after[] = $v['dafter_ty_id'];
                }

                $uq = Customeraa::where('id', $res['file_id'])->update([
                    'translation_id' => implode(',', array_unique(array_filter($translation))),
                    'proofreader_id' => implode(',', array_unique(array_filter($proofreader))),
                    'before_ty_id' => implode(',', array_unique(array_filter($before))),
                    'after_ty_id' => implode(',', array_unique(array_filter($after)))
                ]);

                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                $this->error('保存失败', $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        $this->assign([
            'd' => $d, 'e' => $e, 'f' => $f, 'g' => $g,
        ]);
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="项目助理列表")
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
//                ->field(['tr_start_time','tr_end_time','file_id','file_name_project','file_code_project','basic_id',
//                    'translation_id','status','repetition_rate95','repetition_rate100','repetition_rateall','file_specification','project_page',
//                    'deduction_number'晚点再加
//                ])
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
//        dump($list->toArray());die;
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
     * @NodeAnotation(title="无开始时间列表")
     */
    public function nostarttime()
    {
        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
//                ->field(['tr_start_time','tr_end_time','file_id','file_name_project','file_code_project','basic_id',
//                    'translation_id','status','repetition_rate95','repetition_rate100','repetition_rateall','file_specification','project_page',
//                    'deduction_number'晚点再加
//                ])
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
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
     * @NodeAnotation(title="待预排")
     */
    public function yp()
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
                    return $query ->where('dbefore_ty_id',$this->admininfo()['id'])->whereor('dbefore_ty_id','in',$this->admininfo()['top_id']);
                })

                ->where('description_status',0)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('dbefore_ty_id',$this->admininfo()['id']);
                })
                ->where('description_status',0)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
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
        return $this->fetch('index');
    }
    /**
     * @NodeAnotation(title="预排提交")
     */
    public function ypstock($id)
    {
        $row = $this->model->find($id);
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            try {
                $save = $row->save(['description_status'=>1]);
            } catch (\Exception $e) {
                $this->error('提交失败');
            }
            $save ? $this->success('提交成功') : $this->error('提交失败');
        }
    }

    /**
     * @NodeAnotation(title="待翻译")
     */
    public function tr()
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
                    return $query ->where('dtranslation_id',$this->admininfo()['id'])->whereor('dtranslation_id','in',$this->admininfo()['top_id']);
                })
                ->where('description_status',1)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('dtranslation_id',$this->admininfo()['id'])->whereor('dtranslation_id','in',$this->admininfo()['top_id']);
                })
                ->where('description_status',1)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
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
        return $this->fetch('index');
    }
    /**
     * @NodeAnotation(title="翻译提交")
     */
    public function trstock($id)
    {
        $row = $this->model->find($id);
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            try {
                $save = $row->save(['description_status'=>2]);
            } catch (\Exception $e) {
                $this->error('提交失败');
            }
            $save ? $this->success('提交成功') : $this->error('提交失败');
        }
    }

    /**
     * @NodeAnotation(title="待校对")
     */
    public function xd()
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
                    return $query ->where('dproofreader_id',$this->admininfo()['id'])->whereor('dproofreader_id','in',$this->admininfo()['top_id']);
                })
                ->where('description_status',2)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('dproofreader_id',$this->admininfo()['id'])->whereor('dproofreader_id','in',$this->admininfo()['top_id']);
                })
                ->where('description_status',2)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
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
        return $this->fetch('index');
    }
    /**
     * @NodeAnotation(title="待校对提交")
     */
    public function xdstock($id)
    {
        $row = $this->model->find($id);
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            try {
                $save = $row->save(['description_status'=>3]);
            } catch (\Exception $e) {
                $this->error('提交失败');
            }
            $save ? $this->success('提交成功') : $this->error('提交失败');
        }
    }
    /**
     * @NodeAnotation(title="待后排")
     */
    public function hp()
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
                    return $query ->where('dafter_ty_id',$this->admininfo()['id'])->whereor('dafter_ty_id','in',$this->admininfo()['top_id']);
                })
                ->where('description_status',3)
                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->when($this->admininfo()['id']!=1, function ($query) {
                    // 满足条件后执行
                    return $query ->where('dafter_ty_id',$this->admininfo()['id'])->whereor('dafter_ty_id','in',$this->admininfo()['top_id']);
                })

                ->where($where)
                ->where('description_status',3)

                ->withJoin(['fileaa', 'basic', 'assignor', 'yp', 'hp', 'xd', 'tr'
                ], 'LEFT')
                ->page($page, $limit)
                ->order($this->sort)
                ->select();

//            dump($this->admininfo());
//            dump($list);
//            die;
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
     * @NodeAnotation(title="待后排提交")
     */
    public function hpstock($id)
    {
        $row = $this->model->find($id);
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            try {
                $save = $row->save(['description_status'=>4]);
            } catch (\Exception $e) {
                $this->error('提交失败');
            }
            $save ? $this->success('提交成功') : $this->error('提交失败');
        }
    }
    /**
     * @NodeAnotation(title="留言")
     */

    public function comment()
    {
        $data = $this->request->param();
        //留言信息
        $re = Comment::with(['user'])->where('description_id', $data['id'])->order('create_time', 'desc')->select()->toArray();
        //文件信息
        $ne = $this->model->field('file_name_project,file_code_project')->find($data['id']);
        //人员信息
        $man = SystemAdmin::field('username,id')->select()->toArray();
        $staff = array();
        foreach ($man as $k => $v) {
            $staff[$k]['name'] = $v['username'];
            $staff[$k]['value'] = $v['id'];
            //删除自己
            if($staff[$k]['value']==$this->admininfo()['id'])
            {
                unset($staff[$k]);
            }
        }
        // 启动事务
        Db::startTrans();
        try {
            if ($this->request->isAjax()) {
                $res = new \app\admin\model\project\Comment();
                $res->title = $data['title'];
                $res->content = $data['content'];
                $res->user_id = $this->admininfo()['id'];
                $res->description_id = $data['id'];
                $res->mentioned_id = $data['staff'];
                $res->save();
                //存储到消息通知表
                $addressee= explode(",", $data['staff']);
                foreach ($addressee as $k=>$v)
                {
                    $message=new Message();
                    $message->write_id= $this->admininfo()['id'];
                    $message->addressee_id= $v;
                    $message->link='/admin/index#/admin/project.description/comment.html?id='.$data['id'];
                    $message->topic= $data['title'];
                    $message->message_content=  $data['content'];
                    $message->topic= $data['title'];
                    $message->save();
                }

            }
            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('失败',$e->getMessage());
        }

        $this->assign([
            'id' => $data['id'], 're' => $re, 'ne' => $ne, 'staff' => array_values($staff)
        ]);
        return $this->fetch('/project/comment/comment');
    }



}