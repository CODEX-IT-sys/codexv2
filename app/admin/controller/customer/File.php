<?php

namespace app\admin\controller\customer;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Cache;
/**
 * @ControllerAnnotation(title="customer_file")
 */
class File extends AdminController
{

    use \app\admin\traits\Curd;
    protected $relationSearch = true;
    public function __construct(App $app)
    {
        parent::__construct($app);
        //单位
        $d = Cache::get('dw');
        //服务
        $g = Cache::get('fw');
        //语种
        $h = Cache::get('yz');
        //文件类型
        $f = Cache::get('file_type');
        //税率
        $s = Cache::get('sl');
        $a=$this->request->param('id');
        $this->assign([
           'd'=>$d,'g'=>$g,'h'=>$h,'f'=>$f,'s'=>$s,'a'=>$a
        ]);

        $this->model = new \app\admin\model\customer\CustomerFile();
        
    }

    /**
     * @NodeAnotation(title="列表")
     */
//    public function index()
//    {
//
//
//        if ($this->request->isAjax()) {
//            if (input('selectFields')) {
//                return $this->selectList();
//            }
//            list($page, $limit, $where) = $this->buildTableParames();
//            $count = $this->model
//                ->where($where)
//                ->count();
//            $list = $this->model
//                ->where($where)
//                ->page($page, $limit)
//                ->order($this->sort)
//                ->select();
//            $data = [
//                'code'  => 0,
//                'msg'   => '',
//                'count' => $count,
//                'data'  => $list,
//            ];
//
//            return json($data);
//        }
//
//
//
//        return $this->fetch();
//    }

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
                $post['vat']=$post['unit_price']*$post['quotation_number']*$post['tax_rate']%100;
                $post['quotation_price']=$post['unit_price']*$post['quotation_number']+ $post['vat'];
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
        return $this->fetch();
    }

    
}