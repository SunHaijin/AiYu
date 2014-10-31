//
//  MapViewController.m
//  AiYu
//
//  Created by ibokan on 14/10/24.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import "MapViewController.h"
#import <XMPPStream.h>
#import <MapKit/MapKit.h>
#import "NSObject+Location.h"
#import <XMPPJID.h>
#import <XMPPMessage.h>
#import <AFHTTPRequestOperationManager.h>
@interface MapViewController ()
{
    XMPPMessage *message;
}
@property(nonatomic,strong)CLLocationManager*locationManager;
@property(nonatomic,strong)XMPPStream *xmppStream;
@property(nonatomic,strong)XMPPJID *jid;
@property(nonatomic,strong)NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * it = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(tapFanHui)];
    self.navigationItem.leftBarButtonItem = it;
    self.locationManager=[[CLLocationManager alloc]init];
    self.locationManager.delegate=self;
    self.locationManager.distanceFilter = 10;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8)
    {
        [self.locationManager requestAlwaysAuthorization];
        
    }
    
    self.manager=[[AFHTTPRequestOperationManager alloc]init];
    [self.locationManager startUpdatingLocation];
    
    UIApplication * app = [UIApplication sharedApplication];
    id delegate = [app delegate];
    self.managedObjectContext=[delegate managedObjectContext];
    self.xmppStream=[delegate xmppStream];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    self.jid=[XMPPJID jidWithUser:@"yxj" domain:@"xuyingcloud.com" resource:nil];
    
    
    
    NSLog(@"5555555");
}
-(void)tapFanHui
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    [self.locationManager stopUpdatingLocation];
    
    
    CLLocation *loca=[locations lastObject];
    
    
    CLLocationCoordinate2D location;
    location.latitude=loca.coordinate.latitude;
    location.longitude=loca.coordinate.longitude;
    NSString * str3 = [NSString stringWithFormat:@"%f,%f",location.longitude,location.latitude];
    NSLog(@"%@",str3);
    NSLog(@"%f",location.latitude);
    NSLog(@"%f",location.longitude);
    MKCoordinateSpan span;
    span.latitudeDelta = 0.3;
    span.longitudeDelta= 0.3;
    MKCoordinateRegion region;
    region.span=span;
    region.center=location;
    [self.mapView setRegion:region];
    self.mapView.showsUserLocation =YES;
    
    NSString * stee =@"https://api.weibo.com/2/location/geo/geo_to_address.json";
    NSDictionary * dic = @{@"access_token":@"2.00FhYUhFr3m8tD86ffb019a1Vv4GOD",@"coordinate":str3};
    AFHTTPRequestOperation * op = [self.manager GET:stee parameters:dic success:^(AFHTTPRequestOperation *operation,NSData * responseObject) {
        NSLog(@"-------------");
        NSLog(@"%@",responseObject);
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        NSArray * arr = dic[@"geos"];
        NSLog(@"%@",arr);
        NSDictionary * dic1 = arr[0];
        NSLog(@"%@",dic1);
        NSString * str =dic1[@"address"];
        NSLog(@"%@",str);
        NSDictionary * body = @{@"type": @"Location",@"content":str};
        NSError *error;
        NSData * data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
        if (!data) {
            NSLog(@"body转Data error = %@",[error localizedDescription]);
            return ;
        }
        NSString * bodyStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        
        
        message = [XMPPMessage messageWithType:@"chat" to:self.jid];
        [message addBody:bodyStr];
        NSLog(@"%@",message);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    op.responseSerializer=[AFHTTPResponseSerializer serializer];
    [op start];
    /*
     CLGeocoder * geocoder = [[CLGeocoder alloc]init];
     
     [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error)
     {
     
     if (placemarks.count > 0)
     {
     CLPlacemark * placemark = [placemarks lastObject];
     NSString * str = [NSString stringWithFormat:@"位置:%@",    placemark.addressDictionary[@"Name"]];
     NSDictionary * body = @{@"type": @"Location",@"content":str};
     
     NSData * data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
     if (!data) {
     NSLog(@"body转Data error = %@",[error localizedDescription]);
     return ;
     }
     NSString * bodyStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
     
     message = [XMPPMessage messageWithType:@"chat" to:self.jid];
     [message addBody:bodyStr];
     
     
     
     }
     }];
     */
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
    
    NSLog(@"定位出现错误：%@",[error localizedDescription]);
}

- (IBAction)tapFs:(UIBarButtonItem *)sender
{
    
    
    [self.xmppStream sendElement:message];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)tapSeg:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            //标准模式
            [self.mapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            //卫星模式
            [self.mapView setMapType:MKMapTypeSatellite];
            break;
        case 2:
            //具有街道等信息的卫星地图模式
            [self.mapView setMapType:MKMapTypeHybrid];
            break;
        default:
            break;
    }
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
