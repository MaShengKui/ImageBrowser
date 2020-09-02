//
//  ViewController.m
//  ImageBrowser
//
//  Created by mask on 16/9/1.
//  Copyright © 2016年 mask. All rights reserved.
//

#import "ViewController.h"
#import "ImageBrowserViewController.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define isShowNetWorkImages  0

@interface ViewController ()

@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片浏览器";
    [self createUI];
}

#pragma mark - 创建buttons
- (void)createUI {
    if (isShowNetWorkImages) {
        [self loadNetWorkImages];
    } else {
        [self loadLocalImages];
    }
    
    // 利用切割函数，创建按钮区域
    CGRect aRect,bRect,bounds = CGRectMake((WIDTH - 300) * 0.5, (HEIGHT - 300) * 0.5, 300, 300);
    // 列数
    NSUInteger column = 5;
    // 行数
    NSUInteger rows = (self.imageArray.count % column) == 0 ? (self.imageArray.count / column) : (self.imageArray.count / column) + 1;
    
    for (int i = 0; i < rows; i++) {
        CGRectDivide(bounds, &aRect, &bounds, 300 / 5, CGRectMinYEdge);
        CGFloat width = aRect.size.width / 5;

        for (int j = 0; j < column; j++) {
            NSInteger countIndex = i * column + j;
            if (countIndex >= self.imageArray.count) {
                continue ;
            }
            
            CGRectDivide(aRect, &bRect, &aRect, width, CGRectMinXEdge);
            UIButton *button = [[UIButton alloc] init];
            button.frame = bRect;
            
            if (isShowNetWorkImages) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageArray[countIndex]] options:NSDataReadingMappedIfSafe error:nil];
                UIImage *image = [UIImage imageWithData:data];
                [button setBackgroundImage:image forState:UIControlStateNormal];
            } else {
                [button setBackgroundImage:self.imageArray[countIndex] forState:UIControlStateNormal];
            }
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            button.tag = countIndex;
            [button addTarget:self action:@selector(scanImageClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
}

#pragma mark - 加载本地图片
- (void)loadLocalImages {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSUInteger i = 0; i < 9; i++) {
        UIImage *imagae = [UIImage imageNamed:[NSString stringWithFormat:@"%@",@(i+1)]];
        [arrayM addObject:imagae];
    }
    self.imageArray = arrayM;
}

#pragma mark - 展示网络图片
- (void)loadNetWorkImages {
    NSArray *networkImages = @[
        @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
        @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
        @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
        @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
        @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
        @"http://www.netbian.com/d/file/20140522/3e939daa0343d438195b710902590ea0.jpg",
        @"http://www.netbian.com/d/file/20141018/7ccbfeb9f47a729ffd6ac45115a647a3.jpg",
        @"http://www.netbian.com/d/file/20140724/fefe4f48b5563da35ff3e5b6aa091af4.jpg",
        @"http://www.netbian.com/d/file/20140529/95e170155a843061397b4bbcb1cefc50.jpg"
    ];
    self.imageArray = networkImages;
}

#pragma mark - 点击查看大图
- (void)scanImageClickAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    __weak typeof(self) weakSelf=self;
    [ImageBrowserViewController show:self type:PhotoBroswerVCTypeModal index:button.tag imagesBlock:^NSArray *{
        return weakSelf.imageArray;
    }];
}

@end
