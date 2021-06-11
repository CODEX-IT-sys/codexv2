<?php

namespace app\admin\controller;


use app\admin\model\customer\Customeraa;
use app\admin\model\setting\DatabaseContent;
use app\admin\model\SystemAdmin;
use app\admin\model\SystemQuick;
use app\common\controller\AdminController;
use think\App;
use think\facade\Cookie;
use think\facade\Env;
use think\facade\Cache;
class Index extends AdminController
{

    /**
     * 后台主页
     * @return string
     * @throws \Exception
     */
    public function index()
    {
        return $this->fetch('', [
            'admin' => session('admin'),
        ]);
    }

    public function enlang() {

        $lang=input('lang');
        switch ($lang) {
            case 'en':
                cookie('cookie_lang', 'en-us');
                break;
            case 'zn':
                cookie('cookie_lang', 'zh-cn');
                break;
            default:
                break;
        }

        return   Cookie::get('think_lang');
    }

    /**
     * 后台欢迎页
     * @return string
     * @throws \Exception
     */
    public function welcome()
    {
        cookie('think_lang','en-us');
        $quicks = SystemQuick::field('id,title,icon,href')
            ->where(['status' => 1])
            ->order('sort', 'desc')
            ->limit(8)
            ->select();
        //单位
        $dw=DatabaseContent::where('list_id',1)->select();
        Cache::set('dw',$dw);
        //币种
        $bz=DatabaseContent::where('list_id',10)->select();
        Cache::set('bz',$bz);
        //服务
        $fw=DatabaseContent::where('list_id',2)->select();
        Cache::set('fw',$fw);
        //语种
        $yz=DatabaseContent::where('list_id',3)->select();
        Cache::set('yz',$yz);
        //文件类型
        $file_type=DatabaseContent::where('list_id',4)->select();
        Cache::set('file_type',$file_type);
        //税率
        $sl=DatabaseContent::where('list_id',9)->select();
        Cache::set('sl',$sl);
        //困难度
        $level=DatabaseContent::where('list_id',11)->select();
        Cache::set('level',$level);
        //结算状态
        $jsstatus=DatabaseContent::where('list_id',14)->select();
        Cache::set('jsstatus',$jsstatus);
        //文件分类
        $cate=DatabaseContent::where('list_id',6)->select();
        Cache::set('cate',$cate);
        //翻译人员
        $tr=SystemAdmin::where('auth_ids', 'find in set',8)->select();
        //预排.后排.校对
        $yp=SystemAdmin::where('auth_ids','find in set', 16)->select();
        $hp=SystemAdmin::where('auth_ids','find in set', 17)->select();
        $xd=SystemAdmin::where('auth_ids','find in set', 18)->select();

        Cache::set('tr',$tr);
        Cache::set('yp',$yp);
        Cache::set('hp',$hp);
        Cache::set('xd',$xd);
        $notfile=Customeraa::with(['contract'])->where('file_status',3)->count();
        $todaytfile=Customeraa::with(['contract'])->where('file_status',3)->whereTime('customer_submit_date', 'today')->count();
        $exceedfile=Customeraa::with(['contract'])->where('file_status',3)->where('customer_submit_date', '<',time())->count();
        $arrangefile=Customeraa::with(['contract'])->where('file_status',3)->where('assistant_id',null)->count();
        $page=Customeraa::with(['contract'])->where('file_status',3)->sum('page');
        $updatedatabase=Customeraa::with(['contract'])->where('file_status','in','3,4')->where('update_company_tm','No')->count();
        $this->assign(['page'=>$page]);
        $this->assign(['notfile'=>$notfile]);
        $this->assign(['updatedatabase'=>$updatedatabase]);
        $this->assign(['todaytfile'=>$todaytfile]);
        $this->assign(['exceedfile'=>$exceedfile]);
        $this->assign(['arrangefile'=>$arrangefile]);
        $this->assign('quicks', $quicks);
        return $this->fetch();
    }

    /**
     * 待提交文件
     * @return string
     * @throws \Exception
     */
    public function notfile()
    {
        $arr=Customeraa::with(['contract'])->where('file_status',3)->select();
        $data = [
            'code' => 0,
            'msg' => '',
            'count' => count($arr),
            'data' => $arr,
        ];

        return json($data);

    }

    /**
     * 今日提交文件
     * @return string
     * @throws \Exception
     */
    public function todaytfile()
    {
        $arr=Customeraa::with(['contract'])->where('file_status',3)->whereTime('customer_submit_date', 'today')->select();
        $data = [
            'code' => 0,
            'msg' => '',
            'count' => count($arr),
            'data' => $arr,
        ];
        return json($data);
    }

    /**
     * 逾期文件
     * @return string
     * @throws \Exception
     */
    public function exceedfile()
    {
        $arr=Customeraa::with(['contract'])->where('file_status',3)->where('customer_submit_date', '<',time())->select();
        $data = [
            'code' => 0,
            'msg' => '',
            'count' => count($arr),
            'data' => $arr,
        ];
        return json($data);

    }
    /**
     * 待安排文件
     * @return string
     * @throws \Exception
     */
    public function arrangefile()
    {
        $arr=Customeraa::with(['contract'])->where('file_status',3)->where('assistant_id',null)->select();
        $data = [
            'code' => 0,
            'msg' => '',
            'count' => count($arr),
            'data' => $arr,
        ];
        return json($data);
    }

    /**
     * 待更库
     * @return string
     * @throws \Exception
     */
    public function updatedatabase()
    {
        $arr=Customeraa::with(['contract'])->where('file_status','in','3,4')->where('update_company_tm','No')->select();
        $data = [
            'code' => 0,
            'msg' => '',
            'count' => count($arr),
            'data' => $arr,
        ];
        return json($data);
    }

    /**
     * 修改管理员信息
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editAdmin()
    {
        $id = session('admin.id');
        $row = (new SystemAdmin())
            ->withoutField('password')
            ->find($id);
        empty($row) && $this->error('用户信息不存在');
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $this->isDemo && $this->error('演示环境下不允许修改');
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = $row
//                    ->allowField(['head_img', 'phone', 'remark', 'update_time'])
                    ->save($post);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            $save ? $this->success('保存成功') : $this->error('保存失败');
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

    /**
     * 修改密码
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function editPassword()
    {
        $id = session('admin.id');
        $row = (new SystemAdmin())
            ->withoutField('password')
            ->find($id);
        if (!$row) {
            $this->error('用户信息不存在');
        }
        if ($this->request->isAjax()) {
            $post = $this->request->post();
            $this->isDemo && $this->error('演示环境下不允许修改');
            $rule = [
                'password|登录密码'       => 'require',
                'password_again|确认密码' => 'require',
            ];
            $this->validate($post, $rule);
            if ($post['password'] != $post['password_again']) {
                $this->error('两次密码输入不一致');
            }

            // 判断是否为演示站点
//            $example = Env::get('easyadmin.example', 0);
//            $example == 1 && $this->error('演示站点不允许修改密码');

            try {
                $save = $row->save([
                    'password' => password($post['password']),
                ]);
            } catch (\Exception $e) {
                $this->error('保存失败');
            }
            if ($save) {
                $this->success('保存成功');
            } else {
                $this->error('保存失败');
            }
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

}
