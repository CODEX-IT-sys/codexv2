<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\setting\DatabaseContent;
use app\admin\model\SystemAdmin;
use think\facade\Db;
/**
 * @ControllerAnnotation(title="人员日程")
 */
class Staffing extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new SystemAdmin();

    }


    /**
     * @NodeAnotation(title="人员列表")
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
                ->count();
            $list = $this->model
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select()->toArray();
            foreach ($list as $k=>$v)
            {

                $arr=[];
                foreach (explode(",", $v['auth_ids']) as $k1 => $v1) {
                    $arr[] = Db::name('system_auth')->where('id', $v1)->value('title');

                }
                $list[$k]['auth']=  implode(",", $arr);
            }

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
     * @NodeAnotation(title="人员日程")
     */
    public function rc($id)
    {
        $tr=\app\admin\model\project\Description::where('dtranslation_id',$id)->select()->toArray();
        $xd=\app\admin\model\project\Description::where('dproofreader_id',$id)->select()->toArray();
        $yp=\app\admin\model\project\Description::where('dbefore_ty_id',$id)->select()->toArray();
        $hp=\app\admin\model\project\Description::where('dafter_ty_id',$id)->select()->toArray();
        $man= array_merge($tr,$xd,$yp,$hp);
        $a=[];
        foreach ($man as $k=>$v)
        {
            $a[$k]['title']="文件编号:$v[file_code_project]\r"."文件名称:$v[file_name_project]\r"."开始时间:$v[tr_start_time]\r"."结束时间:$v[tr_end_time]";
            $a[$k]['start']=$v['tr_start_time'];
            $a[$k]['end']=$v['tr_end_time'];
        }
        $this->assign(['a'=>json_encode($a)]);
        return $this->fetch('test');
    }
}