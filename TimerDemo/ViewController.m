//
//  ViewController.m
//  TimerDemo
//
//  Created by volive solutions on 10/09/18.
//  Copyright © 2018 volive solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    int timeSec ;
    int timeMin ;
    int timeHour ;
    NSTimer *timer;
    NSString *totalTime;
    NSString* timeNow;
}
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
 
}
-(void)viewWillAppear:(BOOL)animated{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"timerValue"] !=nil) {
        NSLog(@"timer value %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"timerValue"]);
        NSString *timne = [NSString stringWithFormat:@"%2@",[[NSUserDefaults standardUserDefaults]objectForKey:@"timerValue"]];
        NSLog(@"time value %@",timne);
        NSArray*timeArr = [timne componentsSeparatedByString:@":"];
        timeSec = [timeArr[2] intValue];
        timeMin = [timeArr[1] intValue];
        timeHour = [timeArr[0] intValue];
    }
    else{
        NSLog(@"timer value %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"timerValue"]);
        NSString *timne = [NSString stringWithFormat:@"%2@",[[NSUserDefaults standardUserDefaults]objectForKey:@"timerValue"]];
        NSLog(@"time value %@",timne);
        timeSec = 0;
        timeMin = 0;
        timeHour = 0;
    }
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateUI:)
                                           userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)updateUI:(NSTimer *)timer
{
    
    //dispatch_async(dispatch_get_main_queue(), ^{
    
    
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    if (timeMin == 60) {
        timeHour++;
    }
    //Format the string 00:00
    timeNow = [NSString stringWithFormat:@"%02d:%02d:%02d",timeHour, timeMin, timeSec];
    //Display on your label
    //[timeLabel setStringValue:timeNow];
    [[NSUserDefaults standardUserDefaults]setObject:timeNow forKey:@"timerValue"];
    NSLog(@"timer value %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"timerValue"]);
    _timerLabel.text= timeNow;
    
   
    
}




- (void) StopTimer
{
    totalTime = [NSString stringWithFormat:@"%02d:%02d:%02d",timeHour, timeMin, timeSec];
    
    [timer invalidate];
    timeSec = 0;
    timeMin = 0;
    timeHour = 0;
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d:%02d",timeHour, timeMin, timeSec];
    //Display on your label
    // [timeLabel setStringValue:timeNow];
   _timerLabel.text= timeNow;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
