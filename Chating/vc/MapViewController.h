//
//  MapViewController.h
//  AiYu
//
//  Created by ibokan on 14/10/24.
//  Copyright (c) 2014年 iBokanWisom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UITableViewCell+Function.h"
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@end
