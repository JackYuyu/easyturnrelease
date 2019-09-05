

#import "UserSaleViewCell.h"
#import "SaleModel.h"
@interface UserSaleViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *fuL;
@property (weak, nonatomic) IBOutlet UILabel *loacL;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;


@end
@implementation UserSaleViewCell
-(void)setSaleModel:(SaleModel *)model{
    self.imgV.image = [UIImage imageNamed:model.imgVStr];
    self.titleL.text = model.titleLStr;
    self.fuL.text = model.fuLStr;
    self.loacL.text = model.loacLStr;
    self.moneyL.text = model.moneyLStr;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
