个人博客：http://mrpeak.cn

新制了一款Xcode“合法”插件，之所以说合法，是因为Xcode 8开始禁用了之前所有的第三方插件，新开发的插件要通过安全性检验，必须使用官方的Xcode Editor Extension来做。这款EasyCode插件就是基于Extension来实现，现阶段Extension虽然只提供了「少得可怜」的API，但至少Xcode团队迈出了羞涩的第一步。

#### **插件效果**

新增图像编辑界面：

<img src="http://mrpeak.cn/images/ec05.png" width="818">

<img src="http://mrpeak.cn/images/ec01.gif" width="1024">

<img src="http://mrpeak.cn/images/ec03.gif" width="1024">

#### 正题

Extension现有的API只能获取到当前正在编辑的文件内容，没有再多的功能了(⊙﹏⊙)。幸运的是我们可以对当前文件内容做修改，正好之前写[FastStub](http://mrpeak.cn/blog/faststub/)的时候，有过一个idea：**能通过字母缩写的方式快速插入一段代码**。

起因是因为XCode当前的自动补全功能还是不够强大，比如平常写UIViewController的时候经常需要写如下代码:

```
- (void)viewDidLoad {
	[super viewDidLoad];
}
```

在Xcode 8当中必须先输入\-(void)才能出现补全提示，也就是说函数的返回值必须严格匹配，而且必要的[super viewDidLoad];也不会帮你输入。我个人感觉需要一种更快速的输入方式来增强体验。

当然我们可以通过Xcode自带的Code Snippet Library来生成一个快捷方式，但这个功能我每次很难操作成功，而且把每个常用的代码块都建一次快捷方式比较麻烦，写个插件一次搞定省事。

简单来说，EasyCode遵循如下规则，**取对应函数单词的首字母进行匹配（取前3个单词，不够取2个）**。

比如**viewDidLoad**拆解成**view Did Load**三个单词，就对应vdl这三个字母的缩写，那么在Xcode当中只要通过菜单或者快捷键触发插件功能，就能把vdl替换成上述的代码块。

同理输入vda就可以生成

```
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}
```

输入drm

```
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}
```

输入sio

```
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
	<#code#>
}
```

输入htw

```
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
{
	<#code#>
}
```

输入dr

```
- (void)drawRect:(CGRect)rect
{
	<#code#>
}
```

GCD当中的几个API经常会遇到，缩写后会有冲突，做了点调整

输入dafm(**d**ispatch **af**ter **m**ain queue)

```
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
<#code to be executed after a specified delay#>
});
```

输入dasm(**d**ispatch **as**ync **m**ain queue)

```
dispatch_async(dispatch_get_main_queue(), ^{
<#code#>
});
```

猜猜dafg，dafm代表啥？

还有一些零碎的快捷代码，需要一些记忆：

del对应

```
([UIApplication sharedApplication].delegate)
```

v对应

```
- (void)<#method#>
```

p对应

```
@property (nonatomic, strong) <#type#>         <#name#>
```

w对应

```
__weak __typeof(self) wself = self;
```

n对应

```
[NSNotificationCenter defaultCenter]
```

u对应

```
[NSUserDefaults standardUserDefaults]
```

img对应

```
[UIImage imageNamed:<#(nonnull NSString *)#>];
```

bun对应

```
[[NSBundle mainBundle] pathForResource:<#(nullable NSString *)#> ofType:<#(nullable NSString *)#>];
```

还有其他一些类似的缩写，现阶段添加了一些个人觉得比较常用的API或者缩写，如果不符合自己的记忆习惯的话，可以fork项目后自己配置快捷方式。

**还可以根据selector生成方法体**：

<img src="http://mrpeak.cn/images/ec03.gif" width="1024">

这款插件的目标是让大家少敲一些重复代码，初步使用下来感觉还比较愉悦，适合既勤快（记得住API）又爱偷懒（懒得敲完整API）的同学。

后期如果开放了GUI交互，应该能变得更实用。

#### 安装方式：

下载代码后通过Xcode8运行即可，运行前要用自己的开发者证书对Target签名。

如果看不到菜单栏，请在terminal执行如下命令：

```
sudo /usr/libexec/xpccachectl
```

再重启下Mac，工程里有两个Target，EasyCode和EC，确保两个都运行一次，貌似Xcode现在有bug，偶尔会看不到菜单项。

后面如果Xcode如果能开放更多的API，再考虑放到AppStore上。

#### 使用方式：

通过Xcode建立菜单项的快捷键（我个人配置的是cmd+.）：

<img src="http://mrpeak.cn/images/ec00.png" width="750">

在缩写字母的后面按快捷键：

<img src="http://mrpeak.cn/images/ec01.gif" width="1024">

任何问题或者有常用代码需要添加的，欢迎去github提issue。

同时期待后续Xcode团队能开放更多的API，现在真心不够用，想迁移[FastStub](http://mrpeak.cn/blog/faststub/)完全没办法，迫切需要：

1. 读取整个工程文件的权限
2. GUI交互

**☕️orz = International Coffee Begging Protocol = ICBP**

<img src="http://mrpeak.cn/images/mypay.png" width="320">

**欢迎关注公众号：**

<img src="http://mrpeak.cn/images/qr.jpg" width="150">
