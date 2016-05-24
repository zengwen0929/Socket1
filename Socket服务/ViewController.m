//
//  ViewController.m
//  Socket服务
//
//  Created by zhiangkeji on 16/4/16.
//  Copyright © 2016年 zengwen. All rights reserved.
//

#import "ViewController.h"
#import "ZWClientDelegate.h"
#import "AsyncSocket.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *shezhiID;
@property (weak, nonatomic) IBOutlet UITextField *shezhiMAC;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *passsword;
@property (weak, nonatomic) IBOutlet UITextField *ip;
@property (weak, nonatomic) IBOutlet UITextField *prot;




@end

@implementation ViewController{
    //声明服务端
    AsyncSocket *serverSocket;
    //声明客户端
    AsyncSocket *clientSocket;
    //声明客户端代理
    ZWClientDelegate *clientDelegate;

}
- (IBAction)btn:(id)sender {
    //建立一个管道333
    [clientSocket connectToHost:@"192.168.4.1" onPort:0x0014d withTimeout:-1 error:nil];
    NSString *msgString1=@"AT+\r\n";
    NSData *msgData1=[msgString1 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData1 withTimeout:5 tag:1];
    
}


- (IBAction)huoquid:(id)sender {
    NSString *msgString3=@"AT+SZAID?\r\n";
    NSData *msgData3=[msgString3 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData3 withTimeout:5 tag:1];
    

    
}

- (IBAction)huoqumac:(id)sender {
    NSString *msgString2=@"AT+SZABTMAC?\r\n";
    NSData *msgData2=[msgString2 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData2 withTimeout:5 tag:1];

}
- (IBAction)shezhiid:(id)sender {
    
    
    NSString *msgString2= [NSString stringWithFormat:@"AT+SZAID=\"ZAID%@OK\"\r\n",self.shezhiID.text] ;
    NSData *msgData2=[msgString2 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData2 withTimeout:5 tag:1];
    
}
- (IBAction)shezhimac:(id)sender {
    
    
        NSString *msgString3= [NSString stringWithFormat:@"AT+SZABTMAC=\"%@\"\r\n",self.shezhiMAC.text];
        NSData *msgData3=[msgString3 dataUsingEncoding:NSUTF8StringEncoding];
        [clientSocket writeData:msgData3 withTimeout:5 tag:1];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    clientDelegate=[[ZWClientDelegate alloc]init];
    clientSocket=[[AsyncSocket alloc]initWithDelegate:clientDelegate];
    
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidSelect:) name:@"ButtonDidClickNotification" object:nil];

}
- (void)tabBarDidSelect:(NSNotification *)notification{

    NSString *str = notification.userInfo[@"ButtonClickTag"];

    self.getBackData.text =str;
    NSLog(@"-----%@",str);

}


- (IBAction)huoqushuju:(id)sender {

}

/**
 
 设置<中转板>WiFi AT+SWNP=1"WiFi 名称","WiFi 密码"\r\n
 设置<中转板>Protocol AT+SWNP=2"IP 地址",端口\r\n
 重启<中转板> AT+RST\r\n
 */
- (IBAction)sendData:(id)sender {
    
    NSString *msgString3= [NSString stringWithFormat:@"AT+SWNP=1\"%@\",\"%@\"\r\n",self.name.text,self.passsword.text];
    
    //NSString *msgString3=@"AT+SWNP=1\"FAST_EBA026\",\"zxcvbnm256\"\r\n";
    NSData *msgData3=[msgString3 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData3 withTimeout:5 tag:1];
    
    
}

-(void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (IBAction)sendDataIP:(UIButton *)button{
    NSString *msgString4= [NSString stringWithFormat:@"AT+SWNP=2\"%@\",%@\r\n",self.ip.text,self.prot.text];
    NSData *msgData4=[msgString4 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData4 withTimeout:5 tag:1];
    
    NSString *msgString5=@"AT+RST\r\n";
    NSData *msgData5=[msgString5 dataUsingEncoding:NSUTF8StringEncoding];
    [clientSocket writeData:msgData5 withTimeout:5 tag:1];
    
}
@end
