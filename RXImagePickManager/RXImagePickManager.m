//
//  RXImagePickManager.m
//  ZH
//
//  Created by ceshi on 16/3/25.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import "RXImagePickManager.h"


const NSString *kRXImagePickManager_ActionSheetTitle_AttributeName = @"kRXImagePickManager_ActionSheetTitle_AttributeName";
const NSString *kRXImagePickManager_ActionSheetSelectFromAlbum_AttributeName = @"kRXImagePickManager_ActionSheetSelectFromAlbum_AttributeName";
const NSString *kRXImagePickManager_ActionSheetSelectFromTakaAPicture_AttributeName = @"kRXImagePickManager_ActionSheetSelectFromTakaAPicture_AttributeName";
const NSString *kRXImagePickManager_ActionSheetCancel_AttributeName = @"kRXImagePickManager_ActionSheetCancel_AttributeName";
const NSString *kRXImagePickManager_AllowEditing_AttributeName = @"kRXImagePickManager_AllowEditing_AttributeName";

@interface RXImagePickManager () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSDictionary *defaultAttribute;
@property (nonatomic, strong) NSMutableDictionary *currentAttribute;



@end

@implementation RXImagePickManager

#pragma mark - Public
- (void)setManagerAttributes:(NSDictionary *)attributes
{
    self.currentAttribute = [NSMutableDictionary dictionaryWithDictionary:self.defaultAttribute];
    for (NSString *key in attributes.allKeys) {
        [self.currentAttribute setValue:attributes[key] forKey:key];
    }
}
- (void)pickAction
{
    NSString *title = nil;
    id idTitle = self.currentAttribute[kRXImagePickManager_ActionSheetTitle_AttributeName];
    if ([idTitle isKindOfClass:[NSNull class]]) {
        title = nil;
    } else {
        title = idTitle;
    }
    
    NSString *takeStr = self.currentAttribute[kRXImagePickManager_ActionSheetSelectFromTakaAPicture_AttributeName];
    NSString *albumStr = self.currentAttribute[kRXImagePickManager_ActionSheetSelectFromAlbum_AttributeName];
    NSString *cancelStr = self.currentAttribute[kRXImagePickManager_ActionSheetCancel_AttributeName];
    
    UIViewController *vc = [self.delegate viewControllerInRXImagePickManager:self];
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [as addButtonWithTitle:takeStr];
    [as addButtonWithTitle:albumStr];
    NSInteger cancelButtonIndex = [as addButtonWithTitle:cancelStr];
    as.cancelButtonIndex = cancelButtonIndex;
    [as showInView:vc.view];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    BOOL isEidt = [self.currentAttribute[kRXImagePickManager_AllowEditing_AttributeName] boolValue];
    NSString *key = isEidt ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage;
    
    UIImage *image = [info objectForKey:key];
    
    [self.delegate rxImagePickManager:self selectedImage:image];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIViewController *vc = [self.delegate viewControllerInRXImagePickManager:self];
    [vc dismissViewControllerAnimated:YES completion:^{
    }];
}


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    UIImagePickerControllerSourceType sourceType;
    UIViewController *vc = [self.delegate viewControllerInRXImagePickManager:self];

    switch (buttonIndex) {
        case 0: // 拍照
        {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
            break;
        case 1: // 从相册中选择
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
            break;
        default:
            break;
    }
    BOOL isEidt = [self.currentAttribute[kRXImagePickManager_AllowEditing_AttributeName] boolValue];

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = isEidt;
    imagePickerController.sourceType = sourceType;
    [vc presentViewController:imagePickerController animated:YES completion:^{}];
}




#pragma mark - Constructor And Destructor
- (id)init
{
    if (self = [super init]) {
        
        NSDictionary *defaultDic = @{kRXImagePickManager_ActionSheetTitle_AttributeName:[NSNull null],
                                     kRXImagePickManager_ActionSheetSelectFromAlbum_AttributeName:@"从相册中选择",
                                     kRXImagePickManager_ActionSheetSelectFromTakaAPicture_AttributeName:@"拍照",
                                     kRXImagePickManager_ActionSheetCancel_AttributeName:@"取消",
                                     kRXImagePickManager_AllowEditing_AttributeName:@(YES)};
        self.defaultAttribute = defaultDic;
        self.currentAttribute = [NSMutableDictionary dictionaryWithDictionary:defaultDic];
    }
    return self;
}

@end
