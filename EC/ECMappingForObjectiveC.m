//
//  ECMappingForObjectiveC.m
//  EasyCode
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECMappingForObjectiveC.h"
#import "OCMapping.h"

@implementation ECMappingForObjectiveC

+ (NSDictionary*)ocMapping {
    NSDictionary* mapping = @{
             //UIViewController
             KeyOC_UIViewController_VDL:KeyOC_UIViewController_VDL_Value,
             KeyOC_UIViewController_VWA:KeyOC_UIViewController_VWA_Value,
             KeyOC_UIViewController_VDA:KeyOC_UIViewController_VDA_Value,
             KeyOC_UIViewController_VWD:KeyOC_UIViewController_VWD_Value,
             KeyOC_UIViewController_VDD:KeyOC_UIViewController_VDD_Value,
             KeyOC_UIViewController_DRM:KeyOC_UIViewController_DRM_Value,
             KeyOC_UIViewController_SIO:KeyOC_UIViewController_SIO_Value,
             KeyOC_UIViewController_PIO:KeyOC_UIViewController_PIO_Value,
             
             //UIView
             KeyOC_UIView_HTW:KeyOC_UIView_HTW_Value,
             KeyOC_UIView_PIE:KeyOC_UIView_PIE_Value,
             KeyOC_UIView_CPT:KeyOC_UIView_CPT_Value,
             KeyOC_UIView_CPF:KeyOC_UIView_CPF_Value,
             KeyOC_UIView_CRP:KeyOC_UIView_CRP_Value,
             KeyOC_UIView_CRF:KeyOC_UIView_CRF_Value,
             KeyOC_UIView_DR:KeyOC_UIView_DR_Value,
             
             //UIApplication
             KeyOC_UIApplication_DRU:KeyOC_UIApplication_DRU_Value,
             KeyOC_UIApplication_DRF:KeyOC_UIApplication_DRF_Value,
             KeyOC_UIApplication_DRT:KeyOC_UIApplication_DRT_Value,
             KeyOC_UIApplication_DRR:KeyOC_UIApplication_DRR_Value,
             KeyOC_UIApplication_DRL:KeyOC_UIApplication_DRL_Value,
             
             //GCD
             KeyOC_GCD_DAFM:KeyOC_GCD_DAFM_Value,
             KeyOC_GCD_DASM:KeyOC_GCD_DASM_Value,
             KeyOC_GCD_DAFG:KeyOC_GCD_DAFG_Value,
             KeyOC_GCD_DASG:KeyOC_GCD_DASG_Value,
             
             //MISC
             
             
             
             }.mutableCopy;
    
    //check duplicated keys
    NSArray* keys = mapping.allKeys;
    NSMutableDictionary* dic = @{}.mutableCopy;
    for (NSString* key in keys) {
        if ([dic objectForKey:keys]) {
            NSLog(@"detect duplicated keys!");
        }
        else
        {
            dic[key] = key;
        }
    }
    
    return mapping;
}



@end
