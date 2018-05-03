//
//  ECMappingForSwift.m
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECMappingForSwift.h"
#import "SwiftMapping.h"
#import "ECSnippetEntry.h"

@implementation ECMappingForSwift

+ (NSArray*)defaultEntries {
    NSDictionary* mapping = @{
                              //UIViewController
                              KeySwift_UIViewController_VDL:KeySwift_UIViewController_VDL_Value,
                              KeySwift_UIViewController_VWA:KeySwift_UIViewController_VWA_Value,
                              KeySwift_UIViewController_VDA:KeySwift_UIViewController_VDA_Value,
                              KeySwift_UIViewController_VWD:KeySwift_UIViewController_VWD_Value,
                              KeySwift_UIViewController_VDD:KeySwift_UIViewController_VDD_Value,
                              KeySwift_UIViewController_DRM:KeySwift_UIViewController_DRM_Value,
                              KeySwift_UIViewController_SIO:KeySwift_UIViewController_SIO_Value,
                              KeySwift_UIViewController_PIO:KeySwift_UIViewController_PIO_Value,
                              
                              //UIView
                              KeySwift_UIView_HTW:KeySwift_UIView_HTW_Value,
                              KeySwift_UIView_PIE:KeySwift_UIView_PIE_Value,
                              KeySwift_UIView_CPT:KeySwift_UIView_CPT_Value,
                              KeySwift_UIView_CPF:KeySwift_UIView_CPF_Value,
                              KeySwift_UIView_CRP:KeySwift_UIView_CRP_Value,
                              KeySwift_UIView_CRF:KeySwift_UIView_CRF_Value,
                              KeySwift_UIView_DR:KeySwift_UIView_DR_Value,
                              
                              //UIApplication
                              KeySwift_UIApplication_DRU:KeySwift_UIApplication_DRU_Value,
                              KeySwift_UIApplication_DRF:KeySwift_UIApplication_DRF_Value,
                              KeySwift_UIApplication_DRT:KeySwift_UIApplication_DRT_Value,
                              KeySwift_UIApplication_DRR:KeySwift_UIApplication_DRR_Value,
                              KeySwift_UIApplication_DRL:KeySwift_UIApplication_DRL_Value,
                              
                              //GCD
                              KeySwift_GCD_DAFM:KeySwift_GCD_DAFM_Value,
                              KeySwift_GCD_DASM:KeySwift_GCD_DASM_Value,
                              KeySwift_GCD_DAFG:KeySwift_GCD_DAFG_Value,
                              KeySwift_GCD_DASG:KeySwift_GCD_DASG_Value,
                              
                              //MISC
                              KeySwift_MISC_DEL:KeySwift_MISC_DEL_Value,
                              KeySwift_MISC_V:KeySwift_MISC_V_Value,
                              KeySwift_MISC_C:KeySwift_MISC_C_Value,
                              KeySwift_MISC_P:KeySwift_MISC_P_Value,
                              KeySwift_MISC_W:KeySwift_MISC_W_Value,
                              KeySwift_MISC_N:KeySwift_MISC_N_Value,
                              KeySwift_MISC_U:KeySwift_MISC_U_Value,
                              KeySwift_MISC_F:KeySwift_MISC_F_Value,
                              KeySwift_MISC_M:KeySwift_MISC_M_Value,
                              KeySwift_MISC_IMG:KeySwift_MISC_IMG_Value,
                              KeySwift_MISC_BUN:KeySwift_MISC_BUN_Value,
                              
                              //Template
                              KeySwift_Template_Button:KeySwift_Template_Button_Value,
                              KeySwift_Template_Label:KeySwift_Template_Label_Value,
                              KeySwift_Template_ImageView:KeySwift_Template_ImageView_Value,
                              
                              };
    NSMutableArray* snippetList = [NSMutableArray arrayWithCapacity:mapping.count];
    [mapping enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, NSString*  _Nonnull code, BOOL * _Nonnull stop) {
        ECSnippetEntry* snippet = [ECSnippetEntry snippetWithKey:key code:code];
        [snippetList addObject:snippet];
    }];
    NSArray* snippets = [snippetList copy];
    return snippets;
}



@end
