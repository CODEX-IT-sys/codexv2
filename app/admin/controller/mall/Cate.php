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
        $data=request()->get();
//        dump($data);die;
        //查询自己的信息
        $mine = Db::name('system_admin')->where('id', $data['id'])->find();
        $other = Db::name('system_admin')->select();

        //查询当前用户的所处的群组
/*        $groupArr = [];
        $groups = db('groupdetail')->field('groupid')->where('userid', cookie('uid'))->group('groupid')->select();
        if( !empty( $groups ) ){
            foreach( $groups as $key=>$vo ){
                $ret = db('chatgroup')->where('id', $vo['groupid'])->find();
                if( !empty( $ret ) ){
                    $groupArr[] = $ret;
                }
            }
        }
        unset( $ret, $groups );*/

        $online = 0;
        $group = [];  //记录分组信息
        $userGroup = ['一组','二组','三组'];

        $list = [];  //群组成员信息
        $i = 0;
        $j = 0;

        foreach( $userGroup as $key=>$vo ){
            $group[$i] = [
                'groupname' => $vo,
                'id' => $key,
                'online' => 0,
                'list' => []
            ];
            $i++;
        }


        unset( $userGroup );

        foreach( $group as $key=>$vo ){

            foreach( $other as $k=>$v ) {
                if ($vo['id'] == $v['groupid']) {
                    $list[$j]['username'] = $v['username'];
                    $list[$j]['id'] = $v['id'];
                    $list[$j]['avatar'] = $v['head_img'];
                    $list[$j]['sign'] ='123456';

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

        unset( $other );
        $groupArr=[];
        $return = [
            'code' => 0,
            'msg'=> '',
            'data' => [
                'mine' => [
                    'username' => $mine['username'],
                    'id' => $mine['id'],
                    'status' => 'online',
                    'sign' => 123456,
                    'avatar' => $mine['head_img']
                ],
                'friend' => $group,
                'group' => $groupArr
            ],
        ];

        return json( $return );

    }
}