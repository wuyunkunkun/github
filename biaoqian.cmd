本文介绍phpcms v9中模板标签使用说明。
{template "content","header"}
调用根目录下phpcms\template\content\header文件
{CHARSET}
字符集 （gbk或者utf-8）
{if isset($SEO['title']) && !empty($SEO['title'])}
{$SEO['title']}{/if}
{$SEO['site_title']}
{$SEO['keyword']}
{$SEO['description']}
标题和标题seo优化
{CSS_PATH}
地址替换为根目录下\statics\css
{JS_PATH}
地址替换为根目录下\statics\js
{pc:content  action="position" posid="9" order="id" num="10" cache="3600"}
pc标签{pc:content 参数名="参数值"参数名="参数值"参数名="参数值"}
{loop $data $k $v}
     
{$v[title]}

{/loop}
pc标签值
action="position"--------------对话框的类型=“内容推荐位列表”
posid="9"----------------------推荐位ID="9"
order="id"---------------------排序类型="id"
num="10" ----------------------数据调用数量="10"
cache="3600"-------------------缓存="3600"毫秒
{get_siteid()}
{IMG_PATH}
action="hits" 排行，热点等
action="lists" 主要用于列表等。
catid="$catid" 当前栏目ID   指定数字，即为指定的栏目
num=""  调用文章的数量
order="id DESC" 按ID降序排列
order="id ASC"  按ID升序排列
"views DESC" 
sort=""
"1" 缩略图
return=""
page="$page" 需要分页
每当列表几行的时候出现一次这个
{if $num%2==0}   {/if}
循环标签
{loop $data $r}  {/loop}
{loop $info $r}  {/loop}
日期-------------{date('Y-m-d H:i:s',$r[inputtime])}
文章链接------{$r[url]}
文章标题------{$r[title]}
标题截取------{str_cut($r[title],40,'...')}
缩略图---------loop是info的时候用  {thumb($r[thumb],110,0)}     loop是data的时候用{thumb($v[thumb],90,0)}
分页标签------{$pages}
文章页标签
标题-------{$title}
内容-------{$content}
日期-------{$inputtime}
来源-------{$copyfrom}
点击数------  

网站首页----------------{siteurl($siteid)}
当前位置----------------{catpos($catid)}
栏目名称----------------{$CAT[catname]} 
栏目拼音----------------{$CAT[letter]}
栏目链接----------------{$CAT[url]}
父栏目名称--------------{$CATEGORYS[$CAT[parentid]][catname]} 
父栏目链接--------------{$CATEGORYS[$CAT[parentid]][url]}
上上级栏目名称--------{$CATEGORYS[$CATEGORYS[$CAT[parentid]][parentid]][catname]}
上上级栏目链接--------{$CATEGORYS[$CATEGORYS[$CAT[parentid]][parentid]][url]}
 一级父栏目列表
{pc:content action="category" catid="0" num="34" siteid="$siteid" order="listorder ASC"}
      {loop $data $r}
           
{$r[catname]}

      {/loop}
{/pc}
同级栏目列表
{pc:content action="category" catid="$parentid" num="12" siteid="$siteid" order="listorder ASC"}
      {loop $data $r}
           
{$r[catname]}

       {/loop}
{/pc}
组图列表
{loop $photos $r}
{$r[alt]}

{/loop}
注释：其中$photos为自定义组图字段，{$r[url]}为图片地址，{thumb($r[url], 75, 45, 0)}为图片缩略图，{$r[alt]}为图片描述

首页调用
1、V9同时调用多个栏目最新文章标签
{pc:get sql="SELECT `n`.`inputtime`,`n`.`url`,`n`.`title`,`c`.`catname`,`c`.`url` as `c_url` FROM `v9_news` as `n` left
join `v9_category` as `c` on `n`.`catid` = `c`.`catid` where `c`.`catid` in (6,7,8,9,10) order by `n`.`id` desc" num="10"
cache="3600" page="" dbsource="" return="data"}
{loop $data $key $val}
{date('Y-m-d H:i:s',$val[inputtime])}[{$val

[catname]}] {$val[title]}
{/loop}
{/pc}
{pc:get sql=”select * from anzhi where catid=’cid’”}
{loop $data $r}
{/loop}
{/pc}
2、首页头条
{pc:content action="position" posid="2" order="listorder DESC" num="1"}
{loop $data $r}

{str_cut($r[title],20,'')}

{str_cut($r[description],102)}


{/loop}
{/pc}
调用4个
{pc:content action="position" posid="2" order="listorder DESC" num="4"}
{loop $data $r}
{str_cut($r[title],36,'')}
{if $n==1}phpcms <wbr>v9 <wbr>常用调用标签（全）{/if}{str_cut($r[description],112)}
{/loop}
{/pc}
3、调用某栏目最新文章
{pc:content action="lists" catid="6" order="id DESC" num="10"cache="3600"}
{loop $data $r}
{$r[title]}

{/loop}
{/pc}
4、调用图文
图片新闻
{pc:content action="position" posid="12" thumb="1" order="listorder DESC" num="10"}
{loop $data $r}
phpcms <wbr>v9 <wbr>常用调用标签（全）
{str_cut($r[title],20)}
{/loop}
{/pc}
5、外部数据源调用
{pc:get sql="SELECT * FROM pre_forum_thread" cache="3600" dbsource="discuz" return="data" num="10"}
6、指定变量循环增长（幻灯片调用）
            {pc:content  action="position" posid="1"  order="listorder DESC" thumb="1" num="5"}
             

                   
 
                    {loop $data $r}
                        {$r['title']}
                    {/loop}
                   

               

            {/pc}
{pc:content action="lists" catid="66" order="listorder DESC" thumb="1" num="5" }
{php $num = 0}
{loop $data $r}
linkarr[{$num}] = "{$r[url]}";
picarr[{$num}] = "{$r[thumb]}";
textarr[{$num}] = "{str_cut($r[title],36,'')}";
{php $num++}
{/loop}
{/pc}
7、调用文字友情链接
{pc:link action="type_list" siteid="$siteid" order="listorder DESC" num="10" return="dat"}
{loop $dat $v}
{$v[name]} |
{/loop}
{/pc}
8、调用图片友情链接
        {pc:link  action="type_list" siteid="$siteid" linktype="1" order="listorder DESC" num="8"
return="pic_link"}
        {loop $pic_link $v}
       
phpcms <wbr>v9 <wbr>常用调用标签（全）

/>
        {/loop}
        {/pc}

二、内容页调用
模块名：content
模块提供的可用操作
操作名 说明
lists 内容数据列表
relation 内容相关文章
hits 内容数据点击排行榜
category 内容栏目列表
position 内容推荐位列表
position操作说明如下：
--------------------------------------------------------------------------------
1、内容推荐位列表（position）：
可用参数：
参数名 是否必须 默认值 说明
posid 是 null 推荐位ID
catid 否 null 调用栏目ID
thumb 否 0 是否仅必须缩略图
order 否 null 排序类型
num 是 null 数据调用数量
代码例子：
{pc:content action="position" posid="2" order="listorder DESC" num="4"}
{loop $data $key $val}
{$val['title']}
{/loop}
{/pc}
返回参数如下表：
字段 类型 空 默认 注释
title char(80) 否 NULL 推荐位标题
url char 否 NULL 推荐位链接地址
inputtime int(10) 否 NULL 推荐位发布时间
thumb char 是 NULL 推荐位缩略图
其他 不定 是 根据模型所设置的加入到推荐位中字段名称
--------------------------------------------------------------------------------
2、内容列表（lists）：
可用参数：
参数名 是否必须 默认值 说明
catid 否 null 调用栏目ID
thumb 否 0 是否仅必须缩略图
order 否 null 排序类型
num 是 null 数据调用数量
代码例子：
{pc:content action="lists" catid="2" order="id DESC" num="4"}
{loop $data $key $val}
{$val['title']}
{/loop}
{/pc}
返回参数如下表：
字段 类型 空 默认 注释
title char(80) 否 NULL 推荐位标题
url char 否 NULL 推荐位链接地址
inputtime int(10) 否 NULL 推荐位发布时间
thumb char 是 NULL 推荐位缩略图
其他 不定 是 其他模型字段
--------------------------------------------------------------------------------
3、点击排行榜（hits）：
可用参数：
参数名 是否必须 默认值 说明
catid 否 null 调用栏目ID
day 否 0 调用多少天内的排行
order 否 null 排序类型（本月排行- monthviews DESC 、本周排行 - weekviews DESC、今日排行 - dayviews DESC）
num 是 null 数据调用数量
代码例子：
{pc:content action="hits" catid="2" order="weekviews DESC" num="10"}
{loop $data $key $val}
{$val['title']}
{/loop}
{/pc}
返回参数如下表：
字段 类型 空 默认 注释
title char(80) 否 NULL 推荐位标题
url char 否 NULL 推荐位链接地址
inputtime int(10) 否 NULL 推荐位发布时间
thumb char 是 NULL 推荐位缩略图
其他 不定 是 其他模型字段
-------------------------------------------------------------------------------
4、相关文章（relation）：
可用参数：
参数名 是否必须 默认值 说明
catid 否 null 调用栏目ID
relation 否 $relation 无需更改
keywords 否 null 内容页面取值：$rs[keywords]
num 是 null 数据调用数量
代码例子：
{pc:content action="relation" relation="$relation" catid="$catid" num="5" keywords="$rs[keywords]"}
{loop $data $r}
·{$r[title]}({date('Y-m-d',$r[inputtime])})

{/loop}
{/pc}
返回参数如下表：
字段 类型 空 默认 注释
title char(80) 否 NULL 推荐位标题
url char 否 NULL 推荐位链接地址
inputtime int(10) 否 NULL 推荐位发布时间
thumb char 是 NULL 推荐位缩略图
其他 不定 是 其他模型字段
--------------------------------------------------------------------------------
5、栏目列表（category）：
可用参数：
参数名 是否必须 默认值 说明
catid 否 0 调用该栏目下的所有栏目 ，默认0，调用一级栏目
$siteid 否 1 默认调用系统站点
order 否 null 排序方式、一般按照listorder ASC排序，即栏目的添加顺序
num 是 null 数据调用数量
代码例子：
{pc:content action="category" catid="0" num="25" siteid="$siteid" order="listorder ASC"}
{loop $data $r}
{$r[catname]}
{/loop}
{/pc}
返回参数如下表：
字段 类型 默认值 说明
catid smallint 无 栏目ID
siteid tinyint(3) 0 站点ID
module varchar(15) 无 模块ID
type tinyint(1) 1 栏目类型ID
modelid tinyint(5) 5 模型ID
parentid smallint(5) 5 上级父栏目
arrparentid varchar(255) 无 所有父栏目
child tinyint(1) 0 子栏目
arrchildid mediumtext 无 所有子栏目
catname varchar(30) 无 栏目名称
image varchar(100) 无 栏目图片
description mediumtext 无 栏目描述
parentdir varchar(100) 无 父栏目目录
catdir varchar(30) 无 栏目目录
url varchar(100) 无 栏目链接
items mediumint(8) 0 栏目内容数
hits int(10) 0 点击数
setting mediumtext 无 栏目设置
listorder smallint(5) 0 排序
ismenu tinyint(1) 0 是否显示
sethtml tinyint(1) 0 是否生成到根目录
letter varchar(30) 无 栏目拼音
