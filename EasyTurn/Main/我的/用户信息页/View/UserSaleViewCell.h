

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface UserSaleViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *delBt;
@property (weak, nonatomic) IBOutlet UIButton *neBtn;
-(void)setSaleModel:(SaleModel *)model;
@end

NS_ASSUME_NONNULL_END
