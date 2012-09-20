//
//  AppSettings.h
//  Map
//
//  Created by Scott Sirowy on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArcGIS+App.h"

@class ArcGISOnlineConnection;

@interface AppSettings : NSObject <AGSCoding>
{
    ArcGISOnlineConnection  *_arcGISOnlineConnection;
}

@property (nonatomic, retain) ArcGISOnlineConnection    *arcGISOnlineConnection;

@end
