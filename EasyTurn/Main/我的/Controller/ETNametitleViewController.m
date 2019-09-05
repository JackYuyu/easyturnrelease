//
//  ETNametitleViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETNametitleViewController.h"

@interface ETNametitleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSString *nameStr;
@property (nonatomic,strong)UITextField*nameText;

@end

@implementation ETNametitleViewController
-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.tableFooterView=[[UIView alloc]init];
        _tab.sectionFooterHeight =0;
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(baocun)];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self PostUI];

}

- (void)baocun {
    if (_nameText.text.length>8) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"名字不能大于8个字！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alter.delegate=self;
        [alter show];
        return;
    }
    [self PostUI:_nameText.text];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.block) {
        self.block(_nameText.text);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _nameText=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, cell.size.height)];
        _nameText.text=_nameStr;
        _nameText.textColor=[UIColor blackColor];
        [cell addSubview:_nameText];
        _nameText.clearButtonMode=UITextFieldViewModeWhileEditing;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - 用户信息
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [user objectForKey:@"uid"]
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        //        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString: "attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1.0]}];
        //        _companyLab.attributedText = string;
            //            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            //            [_products addObject:p];
        _nameStr=info.name;
        NSLog(@"");
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)PostUI:(NSString*)head {
    NSDictionary *params = @{
                             @"userName" :_nameText.text
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"user/updateUserName"] params:params success:^(NSDictionary *response) {
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",jsonDict);
    } failure:^(NSError *error) {
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
