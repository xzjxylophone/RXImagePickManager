//
//  RXImagePickManager.h
//  ZH
//
//  Created by ceshi on 16/3/25.
//  Copyright © 2016年 Rush.D.Xzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// default is nil, not @""
extern const NSString *kRXImagePickManager_ActionSheetTitle_AttributeName;
// default is @"从相册中选择"
extern const NSString *kRXImagePickManager_ActionSheetSelectFromAlbum_AttributeName;
// default is @"拍照"
extern const NSString *kRXImagePickManager_ActionSheetSelectFromTakaAPicture_AttributeName;
// default is @"取消"
extern const NSString *kRXImagePickManager_ActionSheetCancel_AttributeName;
// default is YES
extern const NSString *kRXImagePickManager_AllowEditing_AttributeName;

@class RXImagePickManager;

@protocol RXImagePickManagerDelegate <NSObject>

- (UIViewController *)viewControllerInRXImagePickManager:(RXImagePickManager *)rxImagePickManager;

- (void)rxImagePickManager:(RXImagePickManager *)rxImagePickManager selectedImage:(UIImage *)selectedImage;


// custom select From album
- (void)customAlbumActionInRXImagePickManager:(RXImagePickManager *)rxImagePickManager;

@end


@interface RXImagePickManager : NSObject


@property (nonatomic, weak) id<RXImagePickManagerDelegate> delegate;

#pragma mark - Public
- (void)setManagerAttributes:(NSDictionary *)attributes;

- (void)pickAction;





@end
