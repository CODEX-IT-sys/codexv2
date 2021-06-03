<?php

namespace app\admin\controller\project;

use app\admin\model\customer\Customeraa;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;

/**
 * @ControllerAnnotation(title="项目放行")
 */
class Checker extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\Checker();
        
        $this->assign('getTrCheckerList', $this->model->getTrCheckerList());

        $this->assign('getTerminologyList', $this->model->getTerminologyList());

        $this->assign('getLanguageQualityList', $this->model->getLanguageQualityList());

        $this->assign('getProperNounsList', $this->model->getProperNounsList());

        $this->assign('getUnitsMeasurementList', $this->model->getUnitsMeasurementList());

        $this->assign('getSymbolList', $this->model->getSymbolList());

        $this->assign('getChartList', $this->model->getChartList());

        $this->assign('getAbbreviationList', $this->model->getAbbreviationList());

        $this->assign('getLayoutFormatList', $this->model->getLayoutFormatList());

        $this->assign('getOtherList', $this->model->getOtherList());

        $this->assign('getExistingProblemList', $this->model->getExistingProblemList());

        $this->assign('getCorrectSituationList', $this->model->getCorrectSituationList());
        $basic = Customeraa::field(['customer_file_code', 'id'])->where('file_status', 'in', '3,4')->select();
        $ba = $this->xmdata($basic, 'sd', 'customer_file_code');
        $this->assign(['file_id' => $ba]);
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
                ->withJoin(['fileaa', 'write'
                ], 'LEFT')
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['fileaa', 'write'
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
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $post['checker_write_id']=$this->admininfo()['id'];
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