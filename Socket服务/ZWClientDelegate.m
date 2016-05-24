//
//  ZWClientDelegate.m
//  SmartLock
//
//  Created by zhiangkeji on 16/3/8.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import "ZWClientDelegate.h"
#import "ViewController.h"

@implementation ZWClientDelegate
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"客户端--已经连接到%@：%d",host,port);
}
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"客户端--写入数据完成");
    [sock readDataWithTimeout:-1 tag:1];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"客户端--收到数据");
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",message);
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"ButtonDidClickNotification" object:nil userInfo:@{@"ButtonClickTag": message}];
       [sock readDataWithTimeout:-1 tag:1];
}


@end
