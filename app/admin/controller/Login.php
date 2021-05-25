<?php

// +----------------------------------------------------------------------
// | EasyAdmin
// +----------------------------------------------------------------------
// | PHP交流群: 763822524
// +----------------------------------------------------------------------
// | 开源协议  https://mit-license.org 
// +----------------------------------------------------------------------
// | github开源项目：https://github.com/zhongshaofa/EasyAdmin
// +----------------------------------------------------------------------

namespace app\admin\controller;


use app\admin\model\SystemAdmin;
use app\common\controller\AdminController;
use think\captcha\facade\Captcha;
use think\facade\Db;
use think\facade\Env;

/**
 * Class Login
 * @package app\admin\controller
 */
class Login extends AdminController
{

    /**
     * 初始化方法
     */
    public function initialize()
    {
        parent::initialize();
        $action = $this->request->action();
        if (!empty(session('admin')) && !in_array($action, ['out'])) {
            $adminModuleName = config('app.admin_alias_name');
            $this->success('已登录，无需再次登录', [], __url("@{$adminModuleName}"));
        }
    }

    /**
     * 用户登录
     * @return string
     * @throws \Exception
     */
    public function index()
    {
        $captcha = Env::get('easyadmin.captcha', 1);
        if ($this->request->isPost()) {
            $post = $this->request->post();
            $rule = [
                'username|用户名' => 'require',
                'password|密码' => 'require',
                'keep_login|是否保持登录' => 'require',
            ];
            $captcha == 1 && $rule['captcha|验证码'] = 'require|captcha';
            $this->validate($post, $rule);
            $admin = SystemAdmin::where(['username' => $post['username']])->find();
            if (empty($admin)) {
                $this->error('用户不存在');
            }
            if (password($post['password']) != $admin->password) {
                $this->error('密码输入有误');
            }
            if ($admin->status == 0) {
                $this->error('账号已被禁用');
            }
            $admin->login_num += 1;
            $admin->test = time();
            $admin->save();
            $admin = $admin->toArray();
            unset($admin['password']);
            $admin['expire_time'] = $post['keep_login'] == 1 ? true : time() + 997200;
            session('admin', $admin);
            $this->success('登录成功');
        }
        $this->assign('captcha', $captcha);
        $this->assign('demo', $this->isDemo);
        return $this->fetch();
    }

    /**
     * 用户退出
     * @return mixed
     */
    public function out()
    {
        session('admin', null);
        $this->success('退出登录成功');
    }

    /**
     * 验证码
     * @return \think\Response
     */
    public function captcha()
    {
        return Captcha::create();
    }


    public function test()
    {
        try {
        header('Access-Control-Allow-Origin: *');
        $post = $this->request->post();
        //.转义
        $post['content']= htmlspecialchars_decode($post['content']);
        //获取字符串中的图片链接
        $pattern="/<[img|IMG].*?src=[\'|\"](.*?(?:[\.gif|\.jpg]))[\'|\"].*?[\/]?>/";
        preg_match_all($pattern,$post['content'],$match);
        foreach ($match['1'] as $k=>$v)
        {
//            dump(substr($v,0,4));
//            die;
            if((substr($v,0,4))=='file'){

                //转为base64
                $post['content']=str_replace($v,$this->base64EncodeImage($v), $post['content']);
            }

        }
        //去除换行空格
        $post['content'] = str_replace(PHP_EOL, '',$post['content']);
//        dump($post['content']);die;
//        $post['content']=htmlspecialchars( $post['content']);
            if(!isset($post['project'])){
                $post['project']='';
            }

        $a = \think\facade\Db::connect('demo')->table('collect')->save(['time' => time(), 'content' => $post['content'],'project'=>$post['project']]);
        } catch (\Exception $e) {
            $this->error($e->getMessage());
        }
        if ($a) {
            return json(['code' => 200, 'msg' => '提交成功']);
        } else {
            return json(['code' => 500, 'msg' => '提交失败']);
        }
    }

    public function read()
    {
        $data=request()->param();
        if(isset($data['action'])||isset($data['id'])){
            if($data['action']=='shang'){
                $a = \think\facade\Db::connect('demo')->table('collect')->where('status', 0)->where("id", "<", $data['id'])->order("id", "desc")->find();
            }
            if($data['action']=='xia'){
                $a = \think\facade\Db::connect('demo')->table('collect')->where('status', 0)->where("id", ">", $data['id'])->order("id", "asc")->find();
            }
            if($a==''){
                $a = \think\facade\Db::connect('demo')->table('collect')->where('status', 0)->find();
            }
        }else{
            $a = \think\facade\Db::connect('demo')->table('collect')->where('status', 0)->find();
        }

        $this->assign(['a'=>$a]);
        return $this->fetch();
    }

    public function base64EncodeImage ($image_file) {
        $base64_image = '';
        $image_info = getimagesize($image_file);
        $image_data = fread(fopen($image_file, 'r'), filesize($image_file));
        $base64_image = 'data:' . $image_info['mime'] . ';base64,' . chunk_split(base64_encode($image_data));
        return $base64_image;
    }

    public function pass()
    {
        header('Access-Control-Allow-Origin: *');
        $data=request()->param();
        if(isset($data['id'])){
            $res = \think\facade\Db::connect('demo')->table('collect')->where('id', $data['id'])->update(['status'=>1]);
        }
        if ($res) {
            return json(['code' => 200, 'msg' => '成功']);
        } else {
            return json(['code' => 500, 'msg' => '失败']);
        }
    }

        public function write()
        {
            $data=request()->param();

            $this->assign(['project'=>$data]);
            return $this->fetch();
        }


}
