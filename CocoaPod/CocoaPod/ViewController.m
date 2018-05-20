//
//  ViewController.m
//  CocoaPod
//
//  Created by HanYong on 2018/5/14.
//  Copyright © 2018年 HanYong. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>

#import <SDAutoLayout/SDAutoLayout.h>

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WS(ws);
    
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor blackColor];
                          
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.equalTo(ws.view);
    }];
    
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor redColor];
//    [sv addSubview:sv1];
//    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
//    }];
    
    
    UIScrollView *scrollView = [UIScrollView new];
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [sv addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(5,5,5,5));
        
    }];
    
    UIView *container = [UIView new];
    
    [scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(scrollView);
        
        make.width.equalTo(scrollView);
        
    }];
    
    
    
    int count = 10;
    
    UIView *lastView = nil;
    
    for ( int i = 1 ; i <= count ; ++i )
    
    {
        
        UIView *subv = [UIView new];
        
        [container addSubview:subv];
        
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                
                                               alpha:1];
        
        
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.and.right.equalTo(container);
            
            make.height.mas_equalTo(@(20*i));
            
            
            
            if ( lastView )
            
            {
                
                make.top.mas_equalTo(lastView.mas_bottom);
                
            }
            
            else
            
            {
                
                make.top.mas_equalTo(container.mas_top);
                
            }
            
        }];
        
        
        
        lastView = subv;
        
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(lastView.mas_bottom);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
