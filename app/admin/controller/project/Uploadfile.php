<?php

namespace app\admin\controller\project;

use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use app\admin\model\setting\DatabaseContent;

/**
 * @ControllerAnnotation(title="project_uploadfile")
 */
class Uploadfile extends AdminController
{

    use \app\admin\traits\Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);

        $this->model = new \app\admin\model\project\uploadfile();

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
                ->withJoin(['label'
                ], 'LEFT')
                ->where($where)
                ->count();
            $list = $this->model
                ->where($where)
                ->withJoin(['label'
                ], 'LEFT')
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
     * @NodeAnotation(title="文件上传")
     */
    public function uploadfile()
    {
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $this->model;
                $save->label_id = $post['label'];
                $save->download = $post['download'];
                $save->original_name = $post['fileName'];
                $save->url = $post['path'];
                $save->mime_type = $post['mime_type'];
                $save->remark = $post['remark'];
                $save->upload_time = date('Ymd', time());
                $save->save();
            } catch (\Exception $e) {
                $this->error('保存失败:' . $e->getMessage());
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        //文件标签
        $labe = DatabaseContent::where('list_id', 12)->select()->toArray();
        $label = array();
        foreach ($labe as $k => $v) {
            $label[$k]['name'] = $v['content'];
            $label[$k]['value'] = $v['id'];
        }

        $this->assign('label', $label);

        return $this->fetch('uploadfile');
    }

    /**
     * @NodeAnotation(title="文件异步上传")
     */

    function file()
    {
        $label = request()->param('label');

        $file = request()->file('file');

        //文文件类型
        $mime_type = $file->getOriginalExtension();
//        文件名
        $fileName2 = str_replace('.' . $file->getOriginalExtension(), '', $file->getOriginalName());
        if (null === $file) {
            // 异常代码使用UPLOAD_ERR_NO_FILE常量，方便需要进一步处理异常时使用
            throw new \Exception('请上传文件', UPLOAD_ERR_NO_FILE);
        }
        //文件名
        $fileName = $file->getOriginalName();
        $data = DatabaseContent::wherein('id', explode(",", $label))->select();
        foreach ($data as $k => $v) {
            if (!is_dir('upload/' . $v['content'])) {
                // 创建 用户根文件目录//多层第三个参数为true
                mkdir('upload/' . $v['content'], 0777, true);
            }
            $res = file_exists('upload/' . $v['content'] . '/' . $fileName);
            if ($res) {
                return json(['code' => 2, 'msg' => '上传失败,该文件夹下有同名文件!']);
            }
            // 上传到本地服务器
            $info = \think\facade\Filesystem::disk('public')->putFileAs('/upload/' . $v['content'], $file, $fileName);
        }

        return json(['code' => 1, 'msg' => '上传成功', 'path' => $info, 'mime_type' => $mime_type, 'fileName' => $fileName2]);
    }
    /**
     * @NodeAnotation(title="文件管理")
     */
    public function showfile()
    {
        $url = $_SERVER['HTTP_HOST'].'/upload';

    echo '<script>
    window.location.href=\'http://easyadmin.test/upload\';
</script>';


    }

    public function down($id)
    {
        $row = $this->model->find($id);
        $a = $_SERVER['HTTP_HOST'] . '/' . $row['url'];
        $b = $_SERVER['DOCUMENT_ROOT'] . '/' . $row['url'];
        if (file_exists($b)) {
            $this->download_by_path($b, $row['original_name'] . '.' . $row['mime_type']);
        } else {
            return '文件不存在';
        }

    }

    function download_by_path($path_name, $save_name)
    {
        ob_end_clean();
        $hfile = fopen($path_name, "rb") or die("Can not find file: $path_name\n");
        Header("Content-type: application/octet-stream");
        Header("Content-Transfer-Encoding: binary");
        Header("Accept-Ranges: bytes");
        Header("Content-Length: " . filesize($path_name));
        Header("Content-Disposition: attachment; filename=\"$save_name\"");
        while (!feof($hfile)) {
            echo fread($hfile, 32768);
        }
        fclose($hfile);
    }
}