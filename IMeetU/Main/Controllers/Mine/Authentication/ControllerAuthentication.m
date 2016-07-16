//
//  ControllerAuthentication.m
//  IMeetU
//
//  Created by Spring on 16/7/16.
//  Copyright © 2016年 zhanghao. All rights reserved.
//

#import "ControllerAuthentication.h"

@interface ControllerAuthentication ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectImageBtn;
@property (nonatomic,strong) UIImagePickerController *pickerController;

@end

@implementation ControllerAuthentication

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _finishBtn.layer.cornerRadius = 20;
    _finishBtn.clipsToBounds = YES;
    [_selectImageBtn setImage:[UIImage imageNamed:@"cp_public_authentication_nor"] forState:UIControlStateNormal];
    [_selectImageBtn setImage:[UIImage imageNamed:@"cp_public_authentication_click"] forState:UIControlStateHighlighted];
    
}

- (IBAction)getPhoto:(id)sender {
}

- (IBAction)finishBtnClick:(id)sender {
}


- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _pickerController.delegate = self;
        _pickerController.allowsEditing = NO;
    }
    return _pickerController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UIImagePickerDelegate
#pragma mark - 照片选择器代理方法:更新头像，增加照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        [_selectImageBtn setImage:[info objectForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.viewHUD animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//    hud.labelText = @"正在上传...";
//    [picker dismissViewControllerAnimated:YES completion:^{
//        if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
//            UIImage *imgPick;
//            NSString *prefix;
//            if (self.pickControllerProfile == picker) {
//                prefix = @"profile";
//                imgPick = [info objectForKey:UIImagePickerControllerEditedImage];
//            }else if (self.pickControllerImg == picker){
//                prefix = @"photos";
//                imgPick = [info objectForKey:UIImagePickerControllerOriginalImage];
//            }
//            

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
