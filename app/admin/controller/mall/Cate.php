<?php


namespace app\admin\controller\mall;


use app\admin\model\MallCate;
use app\admin\traits\Curd;
use app\common\controller\AdminController;
use EasyAdmin\annotation\ControllerAnnotation;
use EasyAdmin\annotation\NodeAnotation;
use think\App;
use think\facade\Db;

/**
 * Class Admin
 * @package app\admin\controller\system
 * @ControllerAnnotation(title="im")
 */
class Cate extends AdminController
{

    use Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new MallCate();
    }


    /**
     * @NodeAnotation(title="人员列表")
     */
    public function getList()
    {
        $data = request()->get();
//        dump($data);die;
        //查询自己的信息
        $mine = Db::name('system_admin')->where('id', $data['id'])->find();
        $other = Db::name('system_admin')->select();

        //查询当前用户的所处的群组
        $groupArr = [];
        $groups =   Db::name('groupdetail')->field('groupid')->where('userid',  $data['id'])->group('groupid')->select();
        if( !empty( $groups ) ){
            foreach( $groups as $key=>$vo ){
                $ret =  Db::name('chatgroup')->where('id', $vo['groupid'])->find();
                if( !empty( $ret ) ){
                    $groupArr[] = $ret;
                }
            }
        }
        unset( $ret, $groups );

        $online = 0;
        $group = [];  //记录分组信息
        $userGroup = ['未分组', '市场', '项目'];
        $list = [];  //群组成员信息
        $i = 0;
        $j = 0;
        foreach ($userGroup as $key => $vo) {
            $group[$i] = [
                'groupname' => $vo,
                'id' => $key,
                'online' => 1,
                'list' => []
            ];
            $i++;
        }


        unset($userGroup);

        foreach ($group as $key => $vo) {

            foreach ($other as $k => $v) {
                if ($vo['id'] == $v['groupid']) {
                    $list[$j]['username'] = $v['username'];
                    $list[$j]['id'] = $v['id'];
                    $list[$j]['avatar'] = $v['head_img'];
                    $list[$j]['sign'] = '这里展示备注我是:' . $v['username'];

//                    dump($list);die;
//                    if ('online' == $v['status']) {
//                        $online++;
//                    }

                    $group[$key]['online'] = 1;
                    $group[$key]['list'] = $list;

                    $j++;
                }
            }
            $j = 0;
            $online = 0;
            unset($list);
        }

        unset($other);
        $return = [
            'code' => 0,
            'msg' => '',
            'data' => [
                'mine' => [
                    'username' => $mine['username'],
                    'id' => $mine['id'],
                    'status' => 'hide',

//                    'sign' => 123456,
                    'avatar' => $mine['head_img']
                ],
                'friend' => $group,
                'group' => $groupArr
            ],
        ];

        return json($return);

    }

    /**
     * @NodeAnotation(title="聊天记录")
     */
    public function chatlog()
    {
        $id = input('id');
        $type = input('type');

        $this->assign([
            'id' => $id,
            'type' => $type,
            'admin' => session('admin'),
        ]);

        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="聊天记录详情")
     */
    public function chatdetail()
    {
        $id = input('id');
        $type = input('type');
        $uid = input('uid');

//        die;
        if ('friend' == $type) {
            $result = Db::name('chatlog')->where("((fromid={$uid} and toid={$id}) or (fromid={$id} and toid={$uid})) and type='friend'")
                ->order('timeline desc')
                ->select();

            if (empty($result)) {
                return json(['code' => -1, 'data' => '', 'msg' => '没有记录']);
            }

            return json(['code' => 1, 'data' => $result, 'msg' => 'success']);
        } else if ('group' == $type) {

            $result = Db::name('chatlog')->where("toid={$id} and type='group'")
                ->order('timeline desc')
                ->select();

            if (empty($result)) {
                return json(['code' => -1, 'data' => '', 'msg' => '没有记录']);
            }

            return json(['code' => 1, 'data' => $result, 'msg' => 'success']);
        }
    }

    /**
     * @NodeAnotation(title="显示查询 / 添加 分组的页面")
     */
    public function groupindex()
    {
        $groupArr = Db::name('chatgroup')->order('id desc')->limit(4)->select();
        $this->assign([
            'group' => $groupArr
        ]);
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="搜索查询群组")
     */

    public function search()
    {
        $groupname = input('param.search_txt');
        $find = Db::name('chatgroup')->where("groupname like '%" . $groupname . "%'")->select();

        if (empty($find)) {
            return json(['code' => -1, 'data' => '', 'msg' => '您搜的群不存在']);
        }

        return json(['code' => 1, 'data' => $find, 'msg' => 'success']);
    }

    /**
     * @NodeAnotation(title="添加群组")
     */
    public function addgroup()
    {
        if (empty($this->admininfo()['id'])) {
//            $this->redirect( url('') );
            return json(['code' => -1, 'data' => '', 'msg' => '请先登录']);
        }

        if (request()->isPost()) {

            $param = input('post.');
            $ids = $param['ids'];

            unset($param['ids']);

            if (empty($param['groupname'])) {
                return json(['code' => -1, 'data' => '', 'msg' => '群组名不能为空']);
            }

            if (empty($ids)) {
                return json(['code' => -2, 'data' => '', 'msg' => '请添加成员']);
            }

            $this->_getUpFile($param);

            $param['owner_name'] = $this->admininfo()['username'];
            $param['owner_id'] = $this->admininfo()['id'];
            $param['owner_avatar'] = $this->admininfo()['head_img'];
            $param['owner_sign'] = '';

            $flag = Db::name('chatgroup')->insert($param);
            if (empty($flag)) {
                return json(['code' => -3, 'data' => '', 'msg' => '添加群组失败']);
            }

            //unset( $param );
            //拼装上自己
            $ids .= "," . $this->admininfo()['id'];
            $groupid = Db::name('chatgroup')->getLastInsID();

            $users = Db::name('system_admin')->where("id in($ids)")->select();
            if (!empty($users)) {
                foreach ($users as $key => $vo) {
                    $params = [
                        'userid' => $vo['id'],
                        'username' => $vo['username'],
                        'useravatar' => $vo['head_img'],
                        'usersign' => '',
                        'groupid' => $groupid
                    ];

                    Db::name('groupdetail')->insert($params);
                    unset($params);
                }
            }

            //socket data
            $add_data = '{"type":"addGroup", "data" : {"avatar":"' . $param['owner_avatar'] . '","groupname":"' . $param['groupname'] . '",';
            $add_data .= '"id":"' . $groupid . '", "uids":"' . $ids . '"}}';

            return json(['code' => 1, 'data' => $add_data, 'msg' => '创建群组 成功']);
        }

        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="获取所有的用户")
     */
    public function getUsers()
    {
        $result = Db::name('system_admin')->field('id,username,groupid')
//            ->where('id != ' . cookie('uid'))
            ->select();

        if (empty($result)) {
            return json(['code' => -1, 'data' => '', 'msg' => '暂无其他成员']);
        }

        $str = "";
        $flag = input('param.flag');
        $flag = empty($flag) ? false : true;
        if ($flag) {
            //查询该分组中的成员id
            $groupid = input('param.gid');
            $ids = Db::name('groupdetail')->field('userid')->where('groupid', $groupid)->select();

            if (!empty($ids)) {
                foreach ($ids as $key => $vo) {
                    $idsArr[] = $vo['userid'];
                }
                unset($ids);
            }

            foreach ($result as $key => $vo) {
                if (in_array($vo['id'], $idsArr)) {
                    unset($result[$key]);
                }
            }
        }

        if (empty($result)) {
            return json(['code' => -2, 'data' => '', 'msg' => '该群组已经包含了全部成员']);
        }

        $group = ['未分组', '市场', '项目'];
        //先将默认分组拼装好
        foreach ($group as $key => $vo) {
            $str .= '{ "id": "-' . $key . '", "pId":0, "name":"' . $vo . '"},';
        }

        foreach ($result as $key => $vo) {
            $str .= '{ "id": "' . $vo['id'] . '", "pId":"-' . $vo['groupid'] . '", "name":"' . $vo['username'] . '"},';
        }

        $str = "[" . substr($str, 0, -1) . "]";

        return json(['code' => 1, 'data' => $str, 'msg' => 'success']);
    }

    /**
     * @NodeAnotation(title="管理我的群组")
     */

    public function mygroup()
    {

        if (request()->isAjax()) {
            $groupid = input('param.id');
            $users = Db::name('groupdetail')->field('username,userid,useravatar,groupid')->where('groupid', $groupid)->select();

            return json(['code' => 1, 'data' => $users, 'msg' => 'success']);
        }

        $users = [];
        $group = Db::name('chatgroup')->field('id,groupname')->where('owner_id', $this->admininfo()['id'])->select()->toArray();

        if (!empty($group)) {

            $users = Db::name('groupdetail')->field('username,userid,useravatar,groupid')->where('groupid', $group['0']['id'])->select();
        }

        $this->assign([
            'group' => $group,
            'users' => $users

        ]);
        return $this->fetch();
    }

    /**
     * @NodeAnotation(title="追加群组人员")
     */

    public function addMembers()
    {
        $groupid = input('param.gid');
        $ids = input('param.ids');
        $users = Db::name('system_admin')->where("id in($ids)")->select();
        if (!empty($users)) {
            foreach ($users as $key => $vo) {

                $param = [
                    'userid' => $vo['id'],
                    'username' => $vo['username'],
                    'useravatar' => $vo['head_img'],
                    'usersign' => '',
                    'groupid' => $groupid

                ];
                Db::name('groupdetail')->insert($param);
                unset($param);
            }
        }

        $group = Db::name('chatgroup')->field('avatar,groupname')->where('id', $groupid)->find();
        //socket data
        $add_data = '{"type":"addMember", "data" : {"avatar":"' . $group['avatar'] . '","groupname":"' . $group['groupname'] . '",';
        $add_data .= '"id":"' . $groupid . '", "uid":"' . $ids . '"}}';

        return json(['code' => 1, 'data' => $add_data, 'msg' => '加入群组 成功']);
    }

    /**
     * @NodeAnotation(title="移出成员出组")
     */
    public function removeMembers()
    {
        $uid = input('param.uid');
        $groupid = input('param.gid');

        $cannot = Db::name('chatgroup')->field('id')->where('owner_id = ' . $uid . ' and id = ' . $groupid)->find();
        if (!empty($cannot)) {
            return json(['code' => -1, 'data' => '', 'msg' => '不可移除群主']);
        }

        Db::name('groupdetail')->where('userid = ' . $uid . ' and groupid = ' . $groupid)->delete();

        return json(['code' => 1, 'data' => '', 'msg' => '移除成功']);
    }


    /**
     * @NodeAnotation(title="加入群组")
     */
    public function joinGroup()
    {
        $groupid = input('param.gid');
        $has = Db::name('chatgroup')->where('id = ' . $groupid)->find();

        if (empty($has)) {
            return json(['code' => -1, 'data' => '', 'msg' => '该群组不存在']);
        }

        $uid = $this->admininfo()['id'];
        //已经加入了
        $allready = Db::name('groupdetail')->field('userid')
            ->where('groupid = ' . $groupid . ' and userid = ' . $uid)
            ->find();

        if (!empty($allready)) {
            return json(['code' => -2, 'data' => '', 'msg' => '你已经加入该群了']);
        }

        $param = [
            'userid' => $uid,
            'username' => $this->admininfo()['username'],
            'useravatar' => $this->admininfo()['head_img'],
            'usersign' => '',
            'groupid' => $groupid
        ];

        Db::name('groupdetail')->insert($param);

        //socket data
        $join_data = '{"type":"joinGroup", "data" : {"avatar":"' . $has['avatar'] . '","groupname":"' . $has['groupname'] . '",';
        $join_data .= '"id":"' . $groupid . '", "uid":"' . $uid . '"}}';

        return json(['code' => 1, 'data' => $join_data, 'msg' => '成功加入']);
    }


    /**
     * @NodeAnotation(title=" 获取组员信息")
     */

    public function getMembers()
    {
        $id = input('param.id');
        //群主信息
        $owner = Db::name('chatgroup')->field('owner_name,owner_id,owner_avatar,owner_sign')->where('id = ' . $id)->find();
        //群成员信息
        $list = Db::name('groupdetail')->field('userid id,username,useravatar avatar,usersign sign')
            ->where('groupid = ' . $id)->select();

        $return = [
            'code' => 0,
            'msg' => '',
            'data' => [
                'owner' => [
                    'username' => $owner['owner_name'],
                    'id' => $owner['owner_id'],
                    'owner_id' => $owner['owner_avatar'],
                    'sign' => $owner['owner_sign']
                ],
                'list' => $list
            ]
        ];

        return json($return);
    }
    /**
     * @NodeAnotation(title="解散群组")
     */

    public function removeGroup()
    {
        $groupid = input('param.gid');
//        dump($groupid);die;
        //删除群组
        Db::name('chatgroup')->where('id', $groupid)->delete();
        //删除群成员
         Db::name('groupdetail')->where('groupid', $groupid)->delete();

        return json( ['code' => 1, 'data' => '', 'msg' => '成功解散该群'] );
    }


    /**
     * @NodeAnotation(title="分组图片上传")
     */
    private function _getUpFile(&$param)
    {
        // 获取表单上传文件
        $file = request()->file('avatar');

        // 移动到框架应用根目录/public/uploads/ 目录下
        if (!is_null($file)) {
            //文件名
            $fileName = $file->getOriginalName();
            // 上传到本地服务器
            $info = \think\facade\Filesystem::disk('public')->putFileAs('/upload/im/avatar', $file, $fileName);
            $param['avatar'] = '/' . $info;
//            dump($info);die;
//            $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
//            if($info){
//                // 成功上传后 获取上传信息
//                $param['avatar'] = $info;
//            }else{
//                // 上传失败获取错误信息
//                echo $file->getError();
//            }
        } else {
            unset($param['avatar']);
        }
    }

    //上传图片
    public function uploadImg()
    {
        $file = request()->file('file');
        //文件名
        $fileName = $file->getOriginalName();
        // 上传到本地服务器
        $info = \think\facade\Filesystem::disk('public')->putFileAs('/upload/im/log', $file, $fileName);
        if($info){
            $src = '/'.$info;
            return json( ['code' => 0, 'msg' => '', 'data' => ['src' => $src ] ] );
        }else{
            // 上传失败获取错误信息
            return json( ['code' => -1, 'msg' => '上传失败', 'data' => ''] );
        }
    }

    //上传文件
    public function uploadFile()
    {
        $file = request()->file('file');

        //文件名
        $fileName = $file->getOriginalName();
        // 上传到本地服务器
        $info = \think\facade\Filesystem::disk('public')->putFileAs('/upload/im/log', $file, $fileName);
        if($info){
            $src = '/'.$info;
            return json( ['code' => 0, 'msg' => '', 'data' => ['src' => $src ] ] );
        }else{
            // 上传失败获取错误信息
            return json( ['code' => -1, 'msg' => '上传失败', 'data' => ''] );
        }
    }

}