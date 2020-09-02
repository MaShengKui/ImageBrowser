//
//  ImageBrowserViewController.h
//  ImageBrowser
//
//  Created by mask on 16/9/1.
//  Copyright © 2016年 mask. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 跳转方式
 */
typedef NS_ENUM(NSUInteger,PhotoBroswerVCType) {
    
    //modal
    PhotoBroswerVCTypePush  = 0,
    
    //push
    PhotoBroswerVCTypeModal = 1,
    
    //zoom
    PhotoBroswerVCTypeZoom  = 2
};

@interface ImageBrowserViewController : UIViewController

/**
 *  显示图片
 */
+ (void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock;

@end
