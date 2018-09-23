//
//  UIViewController+CameraOrAlbum.m
//  相机Demo
//
//  Created by gzlx on 2018/9/18.
//  Copyright © 2018年 VanZhang. All rights reserved.
//

#import "UIViewController+CameraOrAlbum.h"

@implementation UIViewController (CameraOrAlbum)
-(UIImagePickerController *)imagePickerController{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    //setNavigationBar to adaptive curr App's NavigationBar
    [imgPicker.navigationBar setBarTintColor:[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f]];// navigation bar background.
    [imgPicker.navigationBar setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]];// setBtnTitleColor
    [imgPicker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];//specify the color of the text during rendering. If you do not specify this attribute, the text is rendered in black.
    imgPicker.delegate = self;
    return imgPicker;
}
-(void)showActionSheet{
    CGFloat sysVersion  = [[UIDevice currentDevice].systemVersion floatValue];
    if (sysVersion>8.0f) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIActionSheet *actionSheet  = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        [actionSheet showInView:self.view];
#pragma clang diagnostic pop
    }else{
        UIAlertController *alertCtrl  = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self useCamera];
        }]];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self showAlbum];
        }]];
        [self presentViewController:alertCtrl animated:YES completion:NULL];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //调用相机
    if (buttonIndex == 0) {
        [self useCamera];
    }else if (buttonIndex == 1){
        [self showAlbum];
    }
}
#pragma clang diagnostic pop

-(void)useCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        self.imagePickerController.allowsEditing = YES;
        self.imagePickerController.sourceType = sourceType;
        [self presentViewController:self.imagePickerController animated:YES completion:NULL];
    }else{
        [self showMessage:@"当前设备不支持摄像头，请从相册获取"];
        [self showAlbum];
    }
}
-(void)showAlbum{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerController animated:YES completion:NULL];
    
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
- (void)showMessage:(NSString*)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];
    });
}

#pragma clang diagnostic pop
////getSelectedImg
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    [picker dismissViewControllerAnimated:YES completion:NULL];
////    NSLog(@"info:%@",info);
//    //Judge the selected file MediaType
//    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:@"public.image"]) {
//        UIImage *selectedImg = info[UIImagePickerControllerOriginalImage];
//    //压缩图片
////        NSData *fileData = UIImageJPEGRepresentation(selectedImg, 1.0);
//        NSLog(@"selectedImg:%@",selectedImg);
//    }
//}



@end
