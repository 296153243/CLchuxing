//
//  QuLocationManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/28.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "QuLocationManager.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5

@interface QuLocationManager ()<AMapLocationManagerDelegate>

@property (strong, nonatomic) AMapLocationManager *locationManager;
@property (copy, nonatomic) AMapLocatingCompletionBlock completionBlock;

@end

@implementation QuLocationManager

+ (QuLocationManager *)shareManager
{
    static dispatch_once_t pred;
    static QuLocationManager *shared = nil;
    dispatch_once(&pred, ^{
        
        shared = [[self alloc]init];
        
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if(self){
        
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDelegate:self];
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        //设置期望定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

        //设置允许在后台定位
        [_locationManager setAllowsBackgroundLocationUpdates:NO];
        
        //设置定位超时时间
        [_locationManager setLocationTimeout:DefaultLocationTimeout];
        
        //设置逆地理超时时间
        [_locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];

        [self initCompleteBlock];
    
    }
    return self;
}


- (void)initCompleteBlock
{
   WS(weakSelf)
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error){
        
        weakSelf.isLocating = NO;
        if (error != nil && error.code == AMapLocationErrorLocateFailed){
            
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
            if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
                NSLog(@"定位权限未开");
                
            }
            else {
                NSLog(@"定位失败");
            }
            
            [weakSelf.locationManager stopUpdatingLocation];
            if (weakSelf.locationFailBlock) {
                weakSelf.locationFailBlock();
            }
            
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost)){
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
                     
             weakSelf.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
             weakSelf.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
             
             QuCityModel *cityModel = [[QuCityModel alloc]init];
             cityModel.cityName = @"苏州";
             cityModel.cityCode = @"320500";
             cityModel.provinceCode = @"320000";
             weakSelf.locationCityModel = cityModel;
             
             if (weakSelf.locationSuccessBlock) {
                 weakSelf.locationSuccessBlock(regeocode);
             }
             [[NSNotificationCenter defaultCenter]postNotificationName:LOCATION_SUCCESS_NOTIFICATION object:nil];
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation){
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else{
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
            [weakSelf.locationManager stopUpdatingLocation];
       
            NSLog(@"%@, %@, %@", location, regeocode.city, regeocode.district);
            
            weakSelf.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            weakSelf.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            weakSelf.currentPosition = regeocode.formattedAddress;
            weakSelf.name = regeocode.AOIName.length > 0 ? regeocode.AOIName:regeocode.POIName;
            QuCityModel *cityModel = [[QuCityModel alloc]init];
            cityModel.cityName = [regeocode.city replace:@"市" withString:@""];
            cityModel.cityCode = [[QuDBManager shareDataManger]getTheCityCodeWithCityName:cityModel.cityName];
            cityModel.provinceCode = [[QuDBManager shareDataManger]getTheProvinceCodeWithCityName:cityModel.cityName];
            weakSelf.locationCityModel = cityModel;
            
            if (weakSelf.locationSuccessBlock) {
                weakSelf.locationSuccessBlock(regeocode);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:LOCATION_SUCCESS_NOTIFICATION object:nil];

        }
       
    };
}


- (void)startUpdatingLocationWithSuccess:(void(^)(AMapLocationReGeocode *lbsLocation))successBlock fail:(void(^)(void))failBlock {

    self.locationSuccessBlock = successBlock;
    self.locationFailBlock = failBlock;
    self.isLocating = YES;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
//    [self.locationManager startUpdatingLocation];

}

//连续定位
#pragma mark - AMapLocationManager Delegate
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
    NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        NSLog(@"定位权限未开");
        
    }
    else {
        NSLog(@"定位失败");
    }
    
    [self.locationManager stopUpdatingLocation];
    if (self.locationFailBlock) {
        self.locationFailBlock();
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
    [self.locationManager stopUpdatingLocation];
  
    self.latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    self.currentPosition = reGeocode.formattedAddress;
    self.name = reGeocode.formattedAddress;
    QuCityModel *cityModel = [[QuCityModel alloc]init];
    cityModel.cityName = [reGeocode.city replace:@"市" withString:@""];
    cityModel.cityCode = [[QuDBManager shareDataManger]getTheCityCodeWithCityName:cityModel.cityName];
    cityModel.provinceCode = [[QuDBManager shareDataManger]getTheProvinceCodeWithCityName:cityModel.cityName];
    self.locationCityModel = cityModel;
    
    if (self.locationSuccessBlock) {
        self.locationSuccessBlock(reGeocode);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:LOCATION_SUCCESS_NOTIFICATION object:nil];
}



@end
