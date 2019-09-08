//
//  LegalPersonVC.m
//  product
//
//  Created by 安离夕 on 2019/7/20.
//  Copyright © 2019年 liuzhuang. All rights reserved.
//

#import "LegalPersonVC.h"
#import "ActionView.h"
#import <Photos/Photos.h>
#import "ZZCustomCameraViewController.h"
@interface LegalPersonVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    ActionView *_actionView;
    UIImage *_idImage;
}
@property(nonatomic,strong)UITableView * table;
@property(nonatomic,strong)UILabel * NameLabel;
@property(nonatomic,strong)UILabel * IDCardLabel;
@property(nonatomic,strong)UIButton * btn;
@property(nonatomic,strong)UIImageView * idCardImv;
@property(nonatomic,strong)UIImageView * cerImv;
@property(nonatomic,strong)UIImageView * bankImv;
@property(nonatomic,assign)int frontback;
@property(nonatomic,strong)NSString* a;//姓名
@property(nonatomic,strong)NSString* b;//卡号
@property (nonatomic,strong) NSString* input;
@property (nonatomic,strong) NSString* input1;
@property (nonatomic,strong) NSString* input2;

@property (nonatomic,strong) NSString* images;
@property (nonatomic,strong) NSString* img1;
@property (nonatomic,strong) NSString* img2;


@end

@implementation LegalPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];;
    
    [self.view addSubview:self.table];
}

-(UITableView *)table{
    if (_table == nil) {
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, Screen_Height-NavBarHeight-StatusBarHeight-50) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        //        _table.bounces = NO;
        _table.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _table.sectionFooterHeight =0;
        _table.sectionHeaderHeight =0;
#if __IPHONE_OS_VERSION_MAX_ALLOWED>=__IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            [_table setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
#endif
    }
    return _table;
}

- (UIImageView *)imvLine{
    UIImageView *imvLine = [[UIImageView alloc] init];
    imvLine.clipsToBounds = YES;
    imvLine.backgroundColor = RGBCOLOR(242, 242, 242);
    return imvLine;
}

//-(UIButton *)btn{
//    if (_btn == nil) {
//
//        _btn = [[UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
//
//    }
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 3;
    }else if (section==1) {
        return 3;
    }
    else if (section==2) {
        return 1;
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIden = [NSString stringWithFormat:@"cell_%ld_%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
                _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 50, 20)];
                _NameLabel.font = [UIFont systemFontOfSize:15];
                _NameLabel.text = @"姓名";
                [cell addSubview:self.NameLabel];
                
                UITextField * ed = [[UITextField alloc]initWithFrame:CGRectMake(60, 20, cell.frame.size.width-60, 20)];
                
                ed.placeholder = @"请输入您的真实姓名";
                
                ed.textAlignment = NSTextAlignmentCenter;
                ed.tag=0;
                ed.delegate=self;
                [cell addSubview:ed];
                UIImageView *imvLine = [self imvLine];
                imvLine.frame = CGRectMake(0, 59, Screen_Width, 1);
                imvLine.tag = 1001;
                [cell addSubview:imvLine];
            }
            
        }else if(indexPath.row == 1){
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
                _IDCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
                _IDCardLabel.font = [UIFont systemFontOfSize:15];
                _IDCardLabel.text = @"身份证号";
                [cell addSubview:self.IDCardLabel];
                
                UITextField * ed = [[UITextField alloc]initWithFrame:CGRectMake(90, 20, cell.frame.size.width-90, 20)];
                
                ed.placeholder = @"请输入您本人的身份证号";
                
                
                ed.textAlignment = NSTextAlignmentCenter;
                ed.tag=1;
                ed.delegate=self;
                [cell addSubview:ed];
                UIImageView *imvLine = [self imvLine];
                imvLine.frame = CGRectMake(0, 59, Screen_Width, 1);
                imvLine.tag = 1001;
                [cell addSubview:imvLine];
            }
        }else {
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
                _IDCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
                _IDCardLabel.font = [UIFont systemFontOfSize:15];
                _IDCardLabel.text = @"企业名称";
                [cell addSubview:self.IDCardLabel];
                
                UITextField * ed = [[UITextField alloc]initWithFrame:CGRectMake(90, 20, cell.frame.size.width-10, 20)];
                
                ed.placeholder = @"请输入您所在企业名称";
                
                
                ed.textAlignment = NSTextAlignmentLeft;
                ed.tag=2;
                ed.delegate=self;
                [cell addSubview:ed];
            }
        }
    }else if(indexPath.section==1){
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
            UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-10*2, 210)];
            
            //        img.image = [UIImage imageNamed:@"分组 2"];
            if (indexPath.row==0) {
                img.image = [UIImage imageNamed:@"身份认证-分组 2"];
            }else if (indexPath.row==1) {
                img.image = [UIImage imageNamed:@"身份认证-营业执照 copy"];
            }else if (indexPath.row==2) {
                img.image = [UIImage imageNamed:@"身份认证-分组 3 copy 2"];
            }
            img.backgroundColor = [UIColor lightGrayColor];
            
            [cell addSubview:img];
            
            if (indexPath.row <= 1) {
                if (indexPath.row == 0) {
                    _idCardImv = img;
                }
                else{
                    _cerImv = img;
                }
                UIImageView *imvLine = [self imvLine];
                imvLine.frame = CGRectMake(0, 229, Screen_Width, 1);
                imvLine.tag = 1001;
                [cell addSubview:imvLine];
            }
            else{
                _bankImv=img;
                UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(10, 230, 400, 60)];
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = [UIColor lightGrayColor];
                label.numberOfLines = 0;
                label.text = @"注：上传图片仅支持JPG、JPEG、PNG格式，图片大小不超过5M";
                [cell addSubview:label];
            }
        }
    }
    else if (indexPath.section==2) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
            cell.contentView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
            UIButton *tijiaoBtn=[[UIButton alloc]init];
            [tijiaoBtn setTitle:@"提交认证" forState:UIControlStateNormal];
            tijiaoBtn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
            tijiaoBtn.layer.cornerRadius=8;
            [tijiaoBtn addTarget:self action:@selector(PostUI) forControlEvents:UIControlEventTouchUpInside];

            [cell addSubview:tijiaoBtn];
            [tijiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(15);
                make.left.mas_equalTo(51);
                make.right.mas_equalTo(-51);
                make.height.mas_equalTo(39);
            }];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 60;
        
    }else if(indexPath.section==1){
        if (indexPath.row <= 1) {
            return 230;
        }else
        {
            return 290;
        }
        
    }
    else if (indexPath.section==2){
        return (15+39+BottomSafeHeightGap+15);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 0;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 0;
    }
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_table deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    if (indexPath.section==1) {
        if (!_input||!_input1) {
            [MBProgressHUD showMBProgressHud:self.view withText:@"请先输入姓名和身份证号" withTime:1.0];
            return;
        }
        _frontback=indexPath.row;
        [self cameraClick];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.width, window.height)];
//        coverView.backgroundColor = [UIColor blackColor];
//        coverView.alpha = 0;
//        [window addSubview:coverView];
//
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
//        [coverView addGestureRecognizer:tap];
//
//        ActionView *actionView = [[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:nil options:nil].lastObject;
//        _actionView = actionView;
//        actionView.block = ^(UIButton *sender) {
//            [self coverClick:tap];
//            if (sender.tag == 1) {
//                [self cameraClick];
//            }else if (sender.tag == 2) {
//                [self albumClick];
//            }
//        };
//        actionView.frame = CGRectMake(0, window.height, window.width, 153);
//        [window addSubview:actionView];
//
//        [UIView animateWithDuration:0.2 animations:^{
//            actionView.y = window.height - 153;
//            coverView.alpha = 0.2;
//        }];
    }
    
}
- (void)coverClick:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.2 animations:^{
        _actionView.y = [UIApplication sharedApplication].keyWindow.height;
        tap.view.alpha = 0;
    }completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
        [_actionView removeFromSuperview];
    }];
}
- (void)cameraClick {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;  //是否可编辑
//        //摄像头
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated:YES completion:nil];
        [self haveCameraAuthorityBlock:^(BOOL isHave) {
            if (isHave) {
                ZZCustomCameraViewController *vc = [ZZCustomCameraViewController new];
                vc.block = ^{
                    [self imagePickerController:vc.takedImage];
                };
                [self presentViewController:vc animated:true completion:nil];
            }
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)albumClick {
    [self cameraClick];
    return;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//是否可以编辑
    //打开相册选择照片
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImage *)image
{
    ///
    //UIImage图片转Base64字符串：
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    ///    //base64 urlencode
    
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [encodedImageStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    //Base64字符串转UIImage图片：
    
    //    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    
    //    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //    _headImage = [UIImage imageWithData:imageData];
    if (_frontback==0) {
        [_idCardImv setImage:image];
    }
    else if (_frontback == 1){
        [_cerImv setImage:image];
    }
    else
    {
        [_bankImv setImage:image];
    }
    _idImage = image;
    //
    //    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"xh/idcard" forKey:@"tmpPath"];
    [ud synchronize];
    __weak typeof(self) weakself = self;
    [OSSImageUploader asyncUploadImage:_idImage complete:^(NSArray<NSString *> *names, UploadImageState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSString stringWithFormat:@"/%@", names.lastObject]);
            NSLog(@"");
            //            [self PostUI:[NSString stringWithFormat:@"/%@", names.lastObject]];
            //            [weakself postEdit:@{@"headurl" : [NSString stringWithFormat:@"/%@", names.lastObject]}];
            if (_frontback==0) {
                _images=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            }
            if (_frontback==1) {
                _img1=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            }
            if (_frontback==2) {
                _img2=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            }
            [self PostBaiduAI:upSign];
        });
    }];
    
    [_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 拍摄、相册完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];

    ///
    //UIImage图片转Base64字符串：
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    ///    //base64 urlencode
    
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *upSign = [encodedImageStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    //Base64字符串转UIImage图片：
    
    //    NSData *decodedImageData = [[NSData alloc]initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    
    //    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //    _headImage = [UIImage imageWithData:imageData];
    if (_frontback==0) {
        [_idCardImv setImage:image];
    }
    else if (_frontback == 1){
        [_cerImv setImage:image];
    }
    else
    {
        [_bankImv setImage:image];
    }
    _idImage = image;
    //
    //    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"xh/idcard" forKey:@"tmpPath"];
    [ud synchronize];
    __weak typeof(self) weakself = self;
    [OSSImageUploader asyncUploadImage:_idImage complete:^(NSArray<NSString *> *names, UploadImageState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSString stringWithFormat:@"/%@", names.lastObject]);
            NSLog(@"");
            //            [self PostUI:[NSString stringWithFormat:@"/%@", names.lastObject]];
            //            [weakself postEdit:@{@"headurl" : [NSString stringWithFormat:@"/%@", names.lastObject]}];
            if (_frontback==0) {
                _images=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            }
            if (_frontback==1) {
                _img1=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            }
            if (_frontback==2) {
                _img2=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            }
            [self PostBaiduAI:upSign];
        });
    }];
    
    [_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 身份证识别
- (void)PostBaiduAI:(NSString*)imgUrl {
    
    NSString* image=[NSString stringWithFormat:@"id_card_side=front&image=%@",imgUrl];
    if (_frontback==1) {
        image=[NSString stringWithFormat:@"id_card_side=back&image=%@",imgUrl];
    }
    NSData *data1=[image dataUsingEncoding:NSUTF8StringEncoding];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"access_token"];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [HttpTool postWithUrl:[NSString stringWithFormat:@"%@%@", @"https://aip.baidubce.com/rest/2.0/ocr/v1/idcard?access_token=", token] body:data1 showLoading:NO success:^(NSDictionary *response) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        if (_frontback==0) {
            _b=jsonDict[@"words_result"][@"公民身份号码"][@"words"];
            _a=jsonDict[@"words_result"][@"姓名"][@"words"];
        }
        
        if (_frontback==2) {
            [self verifyId:_a card:_b];
        }
        NSLog(@"");
    } failure:^(NSError *error) {
        
    }];
}
-(void)verifyId:(NSString*)name card:(NSString*)cardno
{
    if ([_a isEqualToString:name]&&[_input1 isEqualToString:cardno]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"验证成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];

        });
    }
    
}
#pragma mark - 提交后台验证卡号接口ß
- (void)PostUI {
    if (_input.length<1) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请先输入姓名" withTime:1.0];
        return;
    }
    if (_input1.length<1) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请先输入身份证号" withTime:1.0];
        return;
    }
    
    if (_images.length<1) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请上传身份证正面照" withTime:1.0];
        return;
    }
    
    if (_img1.length<1) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请上传身份证反面照" withTime:1.0];
        return;
    }
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"name" : _input,
                             @"idCard": _input1,
                             @"msg": _input2,
                             @"images": _images,
                             @"img1": _img1,
                             @"img2": _img2,
                             @"type": @(3)
                             
                             
                             };
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];

    [HttpTool get:[NSString stringWithFormat:@"user/checkedUserID"] params:params success:^(id responseObj) {
        [[NSNotificationCenter defaultCenter]postNotificationName:Refresh_Mine object:nil];
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
        NSLog(@"");
        if ([[MySingleton filterNull:responseObj[@"code"]] integerValue] != 0) {
            [MBProgressHUD showMBProgressHud:self.view withText:[MySingleton filterNull:responseObj[@"msg"]] withTime:1.0];
            return ;
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark 点击Cancel按钮后执行方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    int b=textField.tag;
//    if (b==0) {
//        _input=[textField.text stringByAppendingString:string];
//    }
//    else if (b==1)
//    {
//        _input1=[textField.text stringByAppendingString:string];
//    }
//    else if (b==2)
//    {
//        _input2=[textField.text stringByAppendingString:string];
//    }
    NSLog(@"结束编辑");
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int b=textField.tag;
    if (b==0) {
        _input=textField.text;
    }
    else if (b==1)
    {
        _input1=textField.text;
    }
    else if (b==2)
    {
        _input2=textField.text;
    }
    NSLog(@"3");//文本彻底结束编辑时调用
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"4");//返回一个BOOL值，指定是否循序文本字段开始编辑
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"5");// 点击‘x’清除按钮时 调用
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"6");//返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出第一响应者
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"7");// 点击键盘的‘换行’会调用
    return YES;
}
// 相机权限
- (void)haveCameraAuthorityBlock:(void (^)(BOOL isHave))block
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        !block ? : block(NO);
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted ||
        status == AVAuthorizationStatusDenied) {
        !block ? : block(NO);
    }else if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
            !block ? : block(granted);
        }];
    }else {
        !block ? : block(YES);
    }
}
@end
