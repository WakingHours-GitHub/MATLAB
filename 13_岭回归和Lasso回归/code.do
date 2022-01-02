﻿// 清空工作区数据
clear
// 安装lassopack命令,见课件
// findit lassopack   
// 导入数据，注意修改Excel文件的地址
// import excel "C:\Users\hc_lzp\Desktop\数学建模视频录制\A01更新\岭回归和lasso回归\数据和拓展资料\棉花产量论文作业的数据.xlsx", sheet("data") firstrow

// 注意：这里自变量的量纲相同所以不用标准化，如果需要标准化
// 那么可以借助Matlab的zscore函数(标准化函数)
// 或者直接使用SPSS（分析-描述统计-描述：在描述列表的方框左下角，看到“将标准化得分另存为变量（Z）之后点击打勾，然后确定。）
// Stata中也有相应的标准化变量的命令，不过一次只能标准化一个变量，例如： egen Y = std(单产)   这个代码就表示将单产标准化，得到的变量记为Y
// 或者用Excel也可以, 提前预处理

// 使用K折交叉验证的方法来选择最佳的调整参数.进行lasson回归
// cvlasso Y x1 x2 x3 x4 x5 x6..., lopt seed()
// 其中, 选择项"lopt"表示选择使MSPE最小的ʎ， seed()表示将随机数种子设成500（自行设定）使结果有可重复性
cvlasso 单产 种子费 化肥费 农药费 机械费 灌溉费, lopt seed(520)



// 注意：代码文件仅供参考，一定不要直接用于自己的数模论文中
// 国赛对于论文的查重要求非常严格，代码雷同也算作抄袭
// 视频中提到的附件可在售后群（购买后收到的那个无忧自动发货的短信中有加入方式）的群文件中下载。包括讲义、代码、我视频中推荐的资料等。
// 关注我的微信公众号《数学建模学习交流》，后台发送“软件”两个字，可获得常见的建模软件下载方法；发送“数据”两个字，可获得建模数据的获取方法；发送“画图”两个字，可获得数学建模中常见的画图方法。另外，也可以看看公众号的历史文章，里面发布的都是对大家有帮助的技巧。
// 购买更多优质精选的数学建模资料，可关注我的微信公众号《数学建模学习交流》，在后台发送“买”这个字即可进入店铺(我的微店地址：https://weidian.com/?userid=1372657210)进行购买。
// 视频价格不贵，但价值很高。单人购买观看只需要58元，三人购买人均仅需46元，视频本身也是下载到本地观看的，所以请大家不要侵犯知识产权，对视频或者资料进行二次销售。
// 如何修改代码避免查重的方法：https://www.bilibili.com/video/av59423231（必看）
