// JavaScript Document
	//省市县区三级联动下拉选择器 配置插件目录
	layui.config({
			version: '1.0'
	});
/* 	//一般直接写在一个js文件中
	layui.use(['layer', 'form', 'layarea'], function () {
			var layer = layui.layer
					, form = layui.form
					, layarea = layui.layarea;

			layarea.render({
					elem: '#area-picker',
					change: function (res) {
							//选择结果
							console.log(res);
					}
			});
	});
 */

	layui.use(['form', 'layedit', 'laydate','upload','carousel','table','element','tree','util'], function(){
		var form = layui.form
			 ,layer = layui.layer
			 ,layedit = layui.layedit
			 ,laydate = layui.laydate
			 ,upload = layui.upload
			 ,carousel = layui.carousel
		 	 ,table = layui.table
			 ,element = layui.element
		 	 ,tree = layui.tree
			 ,util = layui.util;
			 
			 //指定允许上传的文件类型
			upload.render({
				elem: '#test3'
				,url: '/upload/'
				,accept: 'file' //普通文件
				,done: function(res){
					console.log(res)
				}
			});
			 
			 //文本编辑器
			 layedit.build('demo'); //建立编辑器
			 
			//日期范围
			lay('.beDate').each(function(){
			  laydate.render({
			    elem: this
			    ,trigger: 'click'
			    ,range: true
			    ,theme: '#1B3382'
					,position: 'fixed'
			  });
			}); 
				
			//同时绑定多个,单个日期选择，不显示在input里面
			lay('.comDate').each(function(){
			  laydate.render({
			    elem: this
			    ,trigger: 'click'
			    ,theme: '#1B3382'
					,position: 'fixed'
			  });
			}); 
				
			//同时绑定多个,单个日期选择，显示在input里面
			/*lay('.showDate').each(function(){
			  laydate.render({
				   elem: this 
			    ,trigger: 'click'
			    ,theme: '#1B3382'
					,position: 'fixed'
					,isInitValue: true
					,value: new Date()
					,format: 'yyyy-MM-dd'
			  });
			}); */
			//同时绑定多个,单个日期选择，不显示在input里面
			lay('.comDate_month').each(function(){
			  laydate.render({
			    elem: this
			    ,trigger: 'click'
			    ,theme: '#1B3382'
				,position: 'fixed'
				,format : 'yyyy-MM'
				,type : 'month'
			  });
			});

					
			
	});





$(document).ready(function(){
	
	/*菜单栏选中状态*/
/* 	$('.hn_menu .layui-nav li dl dd').each(function(){
		$(this).click(function(){
			$(this).parents('li').addClass('layui-this');	
		})
	})
	$('.hn_menu .layui-nav li').each(function(){
		$(this).click(function(){
			$(this).siblings('li').removeClass('layui-nav-itemed');
			$(this).addClass('layui-nav-itemed'); 
			
		})
	})
*/	
	
 	$('.hn_menu .layui-nav li dl dd').each(function(){
		$(this).click(function(){
			$(this).parents('li').addClass('layui-this');	
		})
	})
	$('.hn_menu .layui-nav li a:first-child').each(function(){
		$(this).click(function(){
			$(this).parent().siblings().removeClass('layui-nav-itemed');
		})
	})
	
	

	 /*iframe引入*/
	 $(".hn_menu .layui-nav li a").on("click",function(){
		 var old_address = $("iframe").attr("src"),
			address =$(this).attr("lay-href");
			$("iframe").attr("src",address);
   });
	 
	 /*折叠菜单栏*/
		$('.folded_btn').click(function(){
			$(this).toggleClass("foldedIn");
			$(".hnBox").toggleClass("hnBox_folded");
		});
	 
	
	$(".dtree").delegate(".t-click","click",function(){
		$('.dtree').find('.t-click').removeClass('current'); 
		$(this).addClass('current'); 
	})

 	$('.layui-tab-title li a').live('click', function(event) {
		$(this).stop();
		
	});
	
	
	
	
	
	
		

})







