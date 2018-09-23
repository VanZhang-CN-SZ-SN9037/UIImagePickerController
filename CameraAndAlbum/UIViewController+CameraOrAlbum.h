//
//  UIViewController+CameraOrAlbum.h
//  相机Demo
//
//  Created by gzlx on 2018/9/18.
//  Copyright © 2018年 VanZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CameraOrAlbum)<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

- (UIImagePickerController *)imagePickerController;
/**
 *  调用相册
 */
- (void)showActionSheet;
- (void)useCamera;
- (void)showAlbum;
@end
