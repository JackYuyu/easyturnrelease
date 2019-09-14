//
//  ETRealTimeBuyListCell.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETRealTimeBuyListCell.h"
@interface ETRealTimeBuyListCell ()

@property (nonatomic,strong) UIImageView *imvPhoto;
@property (nonatomic,strong) UIImageView *imvTag;
@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UILabel *labelTime;
@property (nonatomic,strong) UILabel *labelPrice;
@property (nonatomic,strong) UILabel *labelDesc;
@property (nonatomic,strong) UIImageView *imvLine;
@property (nonatomic,strong) NSDictionary *dict;
@end

@implementation ETRealTimeBuyListCell

+ (CGFloat)cellHeight{
    return 125+5;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imvPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 145, 95)];
        self.imvPhoto.contentMode = UIViewContentModeScaleAspectFill;
        self.imvPhoto.clipsToBounds = YES;
        [self.contentView addSubview:self.imvPhoto];
        
        
        self.imvTag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        self.imvTag.contentMode = UIViewContentModeScaleAspectFill;
        self.imvTag.clipsToBounds = YES;
        [self.imvPhoto addSubview:self.imvTag];
        
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        self.labelTitle.frame = CGRectMake(CGRectGetMaxX(self.imvPhoto.frame)+10, 21, Screen_Width-10-CGRectGetMaxX(self.imvPhoto.frame)-10, self.labelTitle.font.lineHeight);
        self.labelTitle.textColor = RGBACOLOR(34, 34, 34, 1);
        [self.contentView addSubview:self.labelTitle];
        
        self.labelDesc = [[UILabel alloc] init];
        self.labelDesc.font = [UIFont systemFontOfSize:12];
        self.labelDesc.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame), CGRectGetMaxY(self.labelTitle.frame)+9, self.labelTitle.frame.size.width, self.labelDesc.font.lineHeight*2);
//        self.labelDesc.numberOfLines = 0;
        self.labelDesc.textColor = RGBACOLOR(153, 153, 153, 1);
        [self.contentView addSubview:self.labelDesc];
        
        self.labelPrice = [[UILabel alloc] init];
        self.labelPrice.font = [UIFont systemFontOfSize:12];
        self.labelPrice.frame = CGRectMake(CGRectGetMinX(self.labelTitle.frame),CGRectGetMaxY(self.labelDesc.frame)+9, (self.labelTitle.frame.size.width-10)/2, self.labelPrice.font.lineHeight);
        self.labelPrice.textColor = kACColorBlack;
        [self.contentView addSubview:self.labelPrice];
        
        
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.font = [UIFont systemFontOfSize:12];
        self.labelTime.textAlignment = NSTextAlignmentRight;
        self.labelTime.frame = CGRectMake(CGRectGetMaxX(self.labelPrice.frame)+10, 0, self.labelPrice.frame.size.width, self.labelTime.font.lineHeight);
        self.labelTime.center = CGPointMake(self.labelTime.center.x, self.labelPrice.center.y);
        self.labelTime.textColor = RGBACOLOR(153, 153, 153, 1);
        [self.contentView addSubview:self.labelTime];
        
        self.imvLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, [ETRealTimeBuyListCell cellHeight]-5, Screen_Width, 5)];
        self.imvLine.backgroundColor = RGBACOLOR(242, 242, 242, 1);
        [self.contentView addSubview:self.imvLine];
        
        
        
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
        NSString *temp = [self filterNull:dict[@"imageList"]];
//        [self.imvPhoto sd_setImageWithURL:[NSURL URLWithString:temp?temp:@""]];
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
        
        temp = [self filterNull:dict[@"serviceId"]];
        if ([temp isEqualToString:@"0"])
        {
            [self.imvPhoto sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"11566120515_.pic_hd"]];
        }
        else
        {
            [self.imvPhoto sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"21566120540_.pic_hd"]];
        }
        temp = [self filterNull:dict[@"releaseTypeId"]];
        if ([temp isEqualToString:@"1"]) {
            [self.imvTag setImage:[UIImage imageNamed:@"首页_出售"]];
        }
        else if ([temp isEqualToString:@"3"]) {
            [self.imvTag setImage:[UIImage imageNamed:@"首页_企服者"]];
        }
        else if ([temp isEqualToString:@"2"]) {
            [self.imvTag setImage:[UIImage imageNamed:@"首页_求购"]];
        }
        else{
            self.imvTag.image = nil;
        }

        self.labelTitle.text = [self filterNull:dict[@"title"]];
        temp = [self filterNull:dict[@"detail"]];
//        self.labelPrice.text = [NSString stringWithFormat:@"%@",temp];
        self.labelTime.text = [self filterNull:dict[@"releaseTime"]];

        self.labelDesc.text = [self filterNull:dict[@"detail"]];
    }
    
    
    
    
}

+ (instancetype)realTimeBuyListCell:(UITableView *)tableView dict:(NSDictionary *)dict{
    ETRealTimeBuyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ETRealTimeBuyListCell"];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ETRealTimeBuyListCell"];
    }
    [cell resetDict:dict];
    return cell;
}

@end

