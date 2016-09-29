//
//  ZYYCodePayViewController.m
//  ZYYCodePayDemo
//
//  Created by liguo.chen on 16/9/29.
//  Copyright © 2016年 Slience. All rights reserved.
//

#import "ZYYCodePayViewController.h"
#import "Common.h"

@interface ZYYCodePayViewController ()

@end

@implementation ZYYCodePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"倒计时展示";
    [self setBackBarButtonItemWithTitle:@"返回"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    NSString *urlStr = @"http://www.ychpay.com/down.html";//测试二维码地址,次二维码不能支付,需要配合服务器来二维码的地址(跟后台人员配合)
    NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    //    UIImage *codeImage = [UIImage imageWithCIImage:outputImage scale:1.0 orientation:UIImageOrientationUp];
    
    UIImageView *wechatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 30, SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
    wechatImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];//重绘二维码,使其显示清晰
    [self.view addSubview:wechatImageView];
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


/**
 *  设置返回按钮标题
 */
- (void)setBackBarButtonItemWithTitle:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"NavBackSorrow"] forState:UIControlStateNormal];
    [btn setContentMode:UIViewContentModeScaleAspectFill];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -7, 0, 50)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 10)];
    [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

/**
 *  返回按钮点击事件
 */
- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
