//
//  ETEnterpriseServicesViewRequestModel.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesViewRequestModel.h"
#import "ETEnterpriseServicesViewDataModel.h"

@implementation ETEnterpriseServicesViewRequestModel

+ (NSNumber *)serviceIdFromServiesKey:(NSString *)serviesKey {
    if ([serviesKey isEqualToString:BusinessServicesKey]) {
        return @(1);
    } else if ([serviesKey isEqualToString:FinanceTaxKey]) {
        return @(2);
    } else if ([serviesKey isEqualToString:AdministrativeLicensingServicesKey]) {
        return @(3);
    } else if ([serviesKey isEqualToString:FinanceServicesKey]) {
        return @(4);
    } else if ([serviesKey isEqualToString:QualificationServicesKey]) {
        return @(5);
    } else if ([serviesKey isEqualToString:IntellectualPropertyServicesKey]) {
        return @(6);
    } else if ([serviesKey isEqualToString:LawServicesKey]) {
        return @(7);
    } else if ([serviesKey isEqualToString:IntegratedServicesKey]) {
        return @(8);
    }
    return @(0);
}

+ (NSNumber *)taxIdFromTaxKey:(NSString *)taxKey {
    if ([taxKey isEqualToString:@"小规模"]) {
        return @(1);
    } else if ([taxKey isEqualToString:@"一般纳税人"]) {
        return @(2);
    }
    return @(0);
}

+ (NSNumber *)bankFromBankKey:(NSString *)bankKey {
    if ([bankKey isEqualToString:@"自开"]) {
        return @(1);
    } else if ([bankKey isEqualToString:@"代开"]) {
        return @(2);
    }
    return @(0);
}

+ (NSNumber *)remarksFromRemarkKey:(NSString *)remarkKey {
    if ([remarkKey isEqualToString:@"自供"]) {
        return @(1);
    } else if ([remarkKey isEqualToString:@"企服者提供"]) {
        return @(2);
    }
    return @(0);
}

@end
