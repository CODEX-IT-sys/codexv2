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
        $trvalue = explode(',', $row['translation_id']);
        $ypvalue = explode(',', $row['before_ty_id']);
        $hpvalue = explode(',', $row['after_ty_id']);
        $xdvalue = explode(',', $row['proofreader_id']);

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
        empty($row) && $this->error('数据不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            // 启动事务
            Db::startTrans();
            try {

                $save = $row->save($post);
                $res=$this->model->where('id',$id)->find();

                //同步更新项目汇总信息,查询相同文件
                $neq=  Db::name('project_description')->where('file_id',$res['file_id'])->field(['translation_id','proofreader_id','before_ty_id','after_ty_id'
                ,'tr_start_time','tr_end_time'
                ,'pr_start_time','pr_end_time'
                ,'be_start_time','be_end_time'
                ,'after_start_time','after_start_time'
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
                $translation=[];
                $proofreader=[];
                $before=[];
                $after=[];
                foreach ($neq as $k=>$v)
                {
                    $translation[]=$v['translation_id'];
                    $proofreader[]=$v['proofreader_id'];
                    $before[]=$v['before_ty_id'];
                    $after[]=$v['after_ty_id'];
                }

              $uq=  Customeraa::where('id',$res['file_id'])->update([
                    'translation_id'=>implode(',',array_unique(array_filter($translation))),
                    'proofreader_id'=>implode(',',array_unique(array_filter($proofreader))),
                    'before_ty_id'=>implode(',',array_unique(array_filter($before))),
                    'after_ty_id'=>implode(',',array_unique(array_filter($after)))
                ]);

                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                $this->error('保存失败',$e->getMessage());
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
                ->withJoin(['fileaa','basic','assignor'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa','basic','assignor'
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
                ->withJoin(['fileaa','basic','assignor'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa','basic','assignor'
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
        return $this->fetch('index');
    }

    /**
     * @NodeAnotation(title="预排")
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
                ->withJoin(['fileaa','basic','assignor'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa','basic','assignor'
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
        return $this->fetch('index');
    }

    /**
     * @NodeAnotation(title="留言")
     */

    public function comment()
    {
        $data=  $this->request->param();
        //留言信息
        $re= Comment::with(['user'])->where('description_id',$data['id'])->order('create_time','desc')->select()->toArray();
        //文件信息
        $ne= $this->model->field('file_name_project,file_code_project')->find($data['id']);
        //人员信息
        $man=SystemAdmin::field('username,id')->select()->toArray();
        $staff= array();
        foreach ($man as $k => $v) {
            $staff[$k]['name'] = $v['username'];
            $staff[$k]['value'] = $v['id'];
        }
        //删除自己
        unset($staff[ $this->admininfo()['id']]);
        if ($this->request->isAjax()) {
            $res = new \app\admin\model\project\Comment();
            $res->title = $data['title'];
            $res->content = $data['content'];
            $res->user_id = $this->admininfo()['id'];
            $res->description_id = $data['id'];
            $res->mentioned_id = $data['staff'];
            $res->save();
        }

        $this->assign([
            'id'=>$data['id'],'re'=>$re,'ne'=>$ne,'staff'=>array_values($staff)
        ]);
        return $this->fetch('/project/comment/comment');
    }

    public function comment1()
    {

        if ($this->request->isAjax()) {
            $data=  $this->request->post();

          return  json_encode('打算打');
        }else{
            return $this->fetch('/project/comment/comment');
        }

    }

}