//
//  ETDynamicListCell.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETFavListCell.h"
#import "ETProductModel.h"
@interface ETFavListCell ()

@property (nonatomic,strong) UIImageView *imvPhoto;
@property (nonatomic,strong) UIImageView *imvTag;
@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelBrowse;
@property (nonatomic,strong) UILabel *labelTag;
@property (nonatomic,strong) UILabel *labelPrice;
@property (nonatomic,strong) UIImageView *imvAddr;
@property (nonatomic,strong) UILabel *labelAddress;
//@property (nonatomic,strong) UILabel *labelDesc;
//@property (nonatomic,strong) UIImageView *imvLine;
@property (nonatomic,strong) NSDictionary *dict;
@end

@implementation ETFavListCell

+ (CGFloat)cellHeight{
    return 125;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imvPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15, 145, 95)];
        self.imvPhoto.contentMode = UIViewContentModeScaleToFill;
        self.imvPhoto.layer.cornerRadius = 12;
        self.imvPhoto.clipsToBounds = YES;
        [self.contentView addSubview:self.imvPhoto];
        
        
        self.imvTag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        self.imvTag.contentMode = UIViewContentModeScaleAspectFill;
        self.imvTag.clipsToBounds = YES;
        [self.imvPhoto addSubview:self.imvTag];
        
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imvPhoto.frame)+10, 19, Screen_Width-10-CGRectGetMaxX(self.imvPhoto.frame)-10, self.labelTitle.font.lineHeight);
        self.labelTitle.textColor = RGBACOLOR(34, 34, 34, 1);
        [self.contentView addSubview:self.labelTitle];
        
        self.labelBrowse = [[UILabel alloc] init];
        self.labelBrowse.font = [UIFont systemFontOfSize:12];
        self.labelBrowse.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame), CGRectGetMaxY(self.labelTitle.frame)+10, self.labelTitle.frame.size.width, self.labelBrowse.font.lineHeight);
        self.labelBrowse.textColor = RGBACOLOR(102, 102, 102, 1);
        [self.contentView addSubview:self.labelBrowse];
        
        self.imvAddr = [[UIImageView alloc] initWithFrame:CGRectMake(self.labelTitle.frame.origin.x, CGRectGetMaxY(self.labelBrowse.frame)+13, 8, 9)];
        self.imvAddr.contentMode = UIViewContentModeScaleAspectFit;
        self.imvAddr.image = [UIImage imageNamed:@"动态列表_定位"];
        self.imvAddr.clipsToBounds = YES;
        [self.contentView addSubview:self.imvAddr];
        
        self.labelAddress = [[UILabel alloc] init];
        self.labelAddress.font = [UIFont systemFontOfSize:12];
        self.labelAddress.frame = CGRectMake(CGRectGetMaxX(self.imvAddr.frame)+4, 0, Screen_Width-15-(CGRectGetMaxX(self.imvAddr.frame)+4), self.labelAddress.font.lineHeight);
        self.labelAddress.center = CGPointMake(self.labelAddress.center.x, self.imvAddr.center.y);
        self.labelAddress.textColor = RGBACOLOR(153, 153, 153, 1);
        [self.contentView addSubview:self.labelAddress];
        
        //
        self.labelTag = [[UILabel alloc] init];
        self.labelTag.font = [UIFont systemFontOfSize:16];
        self.labelTag.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame), CGRectGetMaxY(self.labelAddress.frame)+8, (self.labelTitle.frame.size.width-10)/2, self.labelTag.font.lineHeight);
//        self.labelTag.textColor = RGBACOLOR(102, 102, 102, 1);
        self.labelTag.textColor = RGBACOLOR(248, 124, 43, 1);

        [self.contentView addSubview:self.labelTag];
        
        self.labelPrice = [[UILabel alloc] init];
        self.labelPrice.font = [UIFont systemFontOfSize:13];
        self.labelPrice.frame = CGRectMake(CGRectGetMaxX(self.labelTag.frame), 0, self.labelTag.frame.size.width, self.labelPrice.font.lineHeight);
        self.labelPrice.center = CGPointMake(self.labelPrice.center.x, self.labelTag.center.y);
        self.labelPrice.textAlignment = NSTextAlignmentRight;
//        self.labelPrice.textColor = RGBACOLOR(248, 124, 43, 1);
        self.labelPrice.textColor = RGBACOLOR(102, 102, 102, 1);

        [self.contentView addSubview:self.labelPrice];
        
        
        
        self.imvLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ETFavListCell cellHeight]-1, Screen_Width, 1)];
        self.imvLine.backgroundColor = RGBACOLOR(242, 242, 242, 1);
        [self.contentView addSubview:self.imvLine];
        
        self.labelDesc = [[UILabel alloc] init];
        self.labelDesc.font = [UIFont systemFontOfSize:12];
        self.labelDesc.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame), CGRectGetMaxY(self.imvAddr.frame)+8, self.labelTitle.frame.size.width, self.labelDesc.font.lineHeight);
        self.labelDesc.textColor = RGBACOLOR(153, 153, 153, 1);
        [self.contentView addSubview:self.labelDesc];
        
    }
    return self;
}

- (id) filterNull:(id)obj
{
    if (!obj) {
        return nil;
    }
    return [obj isKindOfClass:[NSNull class]] ? nil : obj;
}

- (void)resetDict:(NSDictionary *)dict{
    if (_dict != dict) {
        _dict = dict;
        dict= dict;
       NSString *temp = [self filterNull:dict[@"imageList"]];
        [self.imvPhoto sd_setImageWithURL:[NSURL URLWithString:temp?temp:@""] placeholderImage:[UIImage imageNamed:@"11566120515_.pic_hd"]];
        
//        temp = [self filterNull:dict[@"releaseTypeId"]];
//        if ([temp isEqualToString:@"1"]) {
//            [self.imvTag setImage:[UIImage imageNamed:@"首页_出售"]];
//            self.imvPhoto.image=[UIImage imageNamed:@"121565920544_.pic"];
//        }
//        else if ([temp isEqualToString:@"3"]) {
//            [self.imvTag setImage:[UIImage imageNamed:@"首页_企服者"]];
//                self.imvPhoto.image=[UIImage imageNamed:@"21566120540_.pic_hd"];
//        }
//        else if ([temp isEqualToString:@"2"]) {
//             [self.imvTag setImage:[UIImage imageNamed:@"首页_求购"]];
//              self.imvPhoto.image=[UIImage imageNamed:@"11566120515_.pic_hd"];
//
//        }
    
        temp = [self filterNull:dict[@"releaseTypeId"]];
        ETProductModel* model=[ETProductModel mj_objectWithKeyValues:dict];
        if ([model.releaseTypeId isEqualToString:@"1"]) {
            [self.imvTag setImage:[UIImage imageNamed:@"首页_出售"]];
        }
        else if ([model.releaseTypeId isEqualToString:@"3"]) {
            [self.imvTag setImage:[UIImage imageNamed:@"首页_企服者"]];
//            [self.imvPhoto sd_setImageWithURL:[NSURL URLWithString:temp?temp:@""] placeholderImage:[UIImage imageNamed:@"11566120515_.pic_hd"]];
        }
        else if ([model.releaseTypeId isEqualToString:@"2"]) {
            [self.imvTag setImage:[UIImage imageNamed:@"首页_求购"]];
//             [self.imvPhoto sd_setImageWithURL:[NSURL URLWithString:temp?temp:@""] placeholderImage:[UIImage imageNamed:@"21566120540_.pic_hd"]];
        }
        else{
            self.imvTag.image = nil;
        }
        
        self.labelTitle.text = [self filterNull:dict[@"title"]];
        temp = [self filterNull:dict[@"releaseTypeId"]];
        if ([temp isEqualToString:@"1"]) {
            self.labelTag.text=@"出售";
        }else if ([temp isEqualToString:@"3"]) {
            self.labelTag.text=@"企服";
        }else {
            self.labelTag.text=@"求购";
        }
        //
        temp = [self filterNull:dict[@"tradStatus"]];
        if ([temp isEqualToString:@"1"]) {
            self.labelTag.text=@"等待卖家确认";
        }else if ([temp isEqualToString:@"2"]){
                self.labelTag.text=@"卖家已确认";
        }
        else if ([temp isEqualToString:@"3"]){
            self.labelTag.text=@"支付已完成";
        }
        else if ([temp isEqualToString:@"4"]){
            self.labelTag.text=@"卖家已发起交易完成";
        }
        else if ([temp isEqualToString:@"5"]){
            self.labelTag.text=@"交易完成";
        }
        
        temp = [NSString stringWithFormat:@"浏览 %ld次",[[self filterNull:dict[@"browse"]] integerValue]];
//        self.labelBrowse.text = temp;
        self.labelPrice.text=temp;
        
        temp = [self filterNull:dict[@"price"]];
                double a=[temp doubleValue];
        if (a>=10000.0) {
            self.labelTag.text = [NSString stringWithFormat:@"¥%.3f万",a/10000.0];
            if ([self.labelTag.text containsString:@"."]) {
                self.labelTag.text=[self.labelTag.text stringByReplacingOccurrencesOfString:@"00万" withString:@"万"];
                
                self.labelTag.text=[self.labelTag.text stringByReplacingOccurrencesOfString:@"0万" withString:@"万"];
                
            }
        }
        else
        {
            float pp =[temp floatValue];
            self.labelTag.text = [NSString stringWithFormat:@"¥%.2f",pp];
            self.labelTag.text=[self.labelTag.text stringByReplacingOccurrencesOfString:@".00" withString:@""];
            NSString* typeid = [self filterNull:dict[@"releaseTypeId"]];
            if ([typeid isEqualToString:@"2"]) {
                self.labelTag.text = @"未填";
            }
        }
        
        self.labelAddress.text = [NSString stringWithFormat:@"%@  %@",[self filterNull:dict[@"cityName"]],[self filterNull:dict[@"releaseTime"]]];
        if ([dict[@"cityName"] isKindOfClass:[NSNull class]]) {
            self.labelAddress.text = @"";
        }
        
        self.labelBrowse.text = [NSString stringWithFormat:@"经营范围:%@",[self filterNull:dict[@"business"]] ];
        NSString* typeid = [self filterNull:dict[@"releaseTypeId"]];
        if ([typeid isEqualToString:@"3"]) {
            self.labelBrowse.text = [NSString stringWithFormat:@"详细内容:%@",[self filterNull:dict[@"detail"]] ];

        }
        
//        if ([dict[@"business"] isKindOfClass:[NSNull class]]) {
//            self.labelBrowse.text = @"";
//
//        }
        
        
//        else{
//            if ([dict[@"business"] isEqualToString:@""]) {
//                self.labelDesc.hidden=YES;
//            }
//        }
//        if ([self.labelDesc.text containsString:@"null"]) {
//            self.labelDesc.hidden=YES;
//
//        }
    }
    
    
//    self.labelDesc.text=p.desc;

//    NSString*str=p.price;
//    double a=[str doubleValue];
//    cell.moneyLab.text=[NSString stringWithFormat:@"¥%.2f万",a/10000.0];
//
//    cell.addressLab.text=p.cityName;
//    cell.detailsLab.text=p.business;
    
    
}

+ (instancetype)dynamicListCell:(UITableView *)tableView dict:(NSDictionary *)dict{
//    ETDynamicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETDynamicListCell"];
//    if (!cell) {
//        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ETDynamicListCell"];
//    }
    ETFavListCell* cell=[ETFavListCell new];
    [cell resetDict:dict];
    return cell;
}

@end

