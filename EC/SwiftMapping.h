//
//  SwiftMapping.h
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#ifndef SwiftMapping_h
#define SwiftMapping_h

#pragma mark- UIViewController

#define KeySwift_UIViewController_VDL @"vdl"
#define KeySwift_UIViewController_VDL_Value @"\
override func viewDidLoad() {\n\
super.viewDidLoad()\n\
\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_VWA @"vwa"
#define KeySwift_UIViewController_VWA_Value @"\
override func viewWillAppear(_ animated: Bool) {\n\
super.viewWillAppear(animated)\n\
\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_VDA @"vda"
#define KeySwift_UIViewController_VDA_Value @"\
override func viewDidAppear(_ animated: Bool) {\n\
super.viewDidAppear(animated)\n\
\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_VWD @"vwd"
#define KeySwift_UIViewController_VWD_Value @"\
override func viewWillDisappear(_ animated: Bool) {\n\
super.viewWillDisappear(animated)\n\
\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_VDD @"vdd"
#define KeySwift_UIViewController_VDD_Value @"\
override func viewDidDisappear(_ animated: Bool) {\n\
super.viewDidDisappear(animated)\n\
\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_DRM @"drm"
#define KeySwift_UIViewController_DRM_Value @"\
override func didReceiveMemoryWarning() {\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_SIO @"sio"
#define KeySwift_UIViewController_SIO_Value @"\
override var supportedInterfaceOrientations: UIInterfaceOrientationMask{\n\
<#code#>\n\
}"

#define KeySwift_UIViewController_PIO @"pio"
#define KeySwift_UIViewController_PIO_Value @"\
override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{\n\
<#code#>\n\
}"

#pragma mark- UIView

#define KeySwift_UIView_HTW @"htw"
#define KeySwift_UIView_HTW_Value @"\
- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIView_PIE @"pie"
#define KeySwift_UIView_PIE_Value @"\
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIView_CPT @"cpt"
#define KeySwift_UIView_CPT_Value @"\
- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIView_CPF @"cpf"
#define KeySwift_UIView_CPF_Value @"\
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIView_CRP @"crp"
#define KeySwift_UIView_CRP_Value @"\
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIView_CRF @"crf"
#define KeySwift_UIView_CRF_Value @"\
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIView_DR @"dr"
#define KeySwift_UIView_DR_Value @"\
- (void)drawRect:(CGRect)rect\n\
{\n\
<#code#>\n\
}"

#pragma mark- UIAppication
#define KeySwift_UIApplication_DRU @"dru"
#define KeySwift_UIApplication_DRU_Value @"\
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIApplication_DRF @"drf"
#define KeySwift_UIApplication_DRF_Value @"\
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIApplication_DRT @"drt"
#define KeySwift_UIApplication_DRT_Value @"\
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIApplication_DRR @"drr"
#define KeySwift_UIApplication_DRR_Value @"\
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo\n\
{\n\
<#code#>\n\
}"

#define KeySwift_UIApplication_DRL @"drl"
#define KeySwift_UIApplication_DRL_Value @"\
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification\n\
{\n\
<#code#>\n\
}"

#pragma mark- GCD
#define KeySwift_GCD_DAFM @"dafm"
#define KeySwift_GCD_DAFM_Value @"\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\n\
<#code to be executed after a specified delay#>\n\
});"

#define KeySwift_GCD_DASM @"dasm"
#define KeySwift_GCD_DASM_Value @"\
dispatch_async(dispatch_get_main_queue(), ^{\n\
<#code#>\n\
});"

#define KeySwift_GCD_DAFG @"dafg"
#define KeySwift_GCD_DAFG_Value @"\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{\n\
<#code to be executed after a specified delay#>\n\
});"

#define KeySwift_GCD_DASG @"dasg"
#define KeySwift_GCD_DASG_Value @"\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{\n\
<#code#>\n\
});"


#pragma mark- MISC
#define KeySwift_MISC_DEL @"del"
#define KeySwift_MISC_DEL_Value @"\
([UIApplication sharedApplication].delegate)"

#define KeySwift_MISC_V @"v"
#define KeySwift_MISC_V_Value @"\
- (void)<#method#>"

#define KeySwift_MISC_C @"c"
#define KeySwift_MISC_C_Value @"\
[UIColor colorWith<#color#>]"

#define KeySwift_MISC_P @"p"
#define KeySwift_MISC_P_Value @"\
@property (nonatomic, strong) <#type#>         <#name#>"

#define KeySwift_MISC_W @"w"
#define KeySwift_MISC_W_Value @"\
__weak __typeof(self) wself = self;"

#define KeySwift_MISC_N @"n"
#define KeySwift_MISC_N_Value @"\
[[NSNotificationCenter defaultCenter] <#method#>];"

#define KeySwift_MISC_U @"u"
#define KeySwift_MISC_U_Value @"\
[[NSUserDefaults standardUserDefaults] <#method#>];"

#define KeySwift_MISC_F @"f"
#define KeySwift_MISC_F_Value @"\
[[NSFileManager defaultManager] <#method#>];"

#define KeySwift_MISC_M @"m"
#define KeySwift_MISC_M_Value @"\
#pragma mark - <#text#>"

#define KeySwift_MISC_URL @"url"
#define KeySwift_MISC_URL_Value @"\
[NSURL URLWithString:<#(nonnull NSString *)#>]"

#define KeySwift_MISC_IMG @"img"
#define KeySwift_MISC_IMG_Value @"\
[UIImage imageNamed:<#(nonnull NSString *)#>];"

#define KeySwift_MISC_BUN @"bun"
#define KeySwift_MISC_BUN_Value @"\
[[NSBundle mainBundle] pathForResource:<#(nullable NSString *)#> ofType:<#(nullable NSString *)#>];"



#pragma mark- Template
#define KeySwift_Template_Button @"btn"
#define KeySwift_Template_Button_Value @"\
UIButton *btn = [UIButton new];\n\
[btn setBackgroundColor:<#(UIColor * _Nullable)#>];\n\
[btn setTitle:<#(nullable NSString *)#> forState:UIControlStateNormal];\n\
[btn addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:UIControlEventTouchUpInside];\n\
[<#self#> addSubview:btn];\n\
<#self.btn#> = btn;"

#define KeySwift_Template_Label @"lb"
#define KeySwift_Template_Label_Value @"\
UILabel *lb = [UILabel new];\n\
lb.text = <#text#>;\n\
lb.textColor = <#(UIColor * _Nullable)#>;\n\
lb.font = [UIFont systemFontOfSize:<#(CGFloat)#>];\n\
lb.backgroundColor = [UIColor clearColor];\n\
[<#self#> addSubview:lb];\n\
<#self.lb#> = lb;"

#define KeySwift_Template_ImageView @"iv"
#define KeySwift_Template_ImageView_Value @"\
UIImageView* imgV = [UIImageView new];\n\
imgV.backgroundColor = [UIColor clearColor];\n\
imgV.image = [UIImage imageNamed:<#(nonnull NSString *)#>];\n\
[<#self#> addSubview:imgV];\n\
<#self.imgV#> = imgV;"

#endif /* SwiftMapping_h */
