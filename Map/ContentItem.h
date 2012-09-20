//
//  ContentItem.h
//  ArcGISMobile
//
//  Created by ryan3374 on 1/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArcGIS+App.h"

@interface ContentItem : NSObject <AGSCoding> {
	NSString        *_itemId;
	NSString        *_item;
	NSString        *_itemType;
	NSString        *_contentType;
	NSString        *_title;
	NSString        *_type;
	NSString        *_thumbnail;
    NSString        *_access;
	NSString        *_owner;
	NSInteger       _size;
    NSString        *_description;
    NSString        *_snippet;
    AGSEnvelope     *_extent;
    double          _uploaded;
    NSString        *_name;
    double          _avgRating;
    NSMutableArray  *_tags;
    NSInteger       _numComments;
    NSInteger       _numRatings;
    NSInteger       _numViews;
}

@property (nonatomic, copy) NSString            *itemId;
@property (nonatomic, copy) NSString            *item;
@property (nonatomic, copy) NSString            *itemType;
@property (nonatomic, copy) NSString            *contentType;
@property (nonatomic, copy) NSString            *title;
@property (nonatomic, copy) NSString            *type;
@property (nonatomic, copy) NSString            *access;
@property (nonatomic, copy) NSString            *thumbnail;
@property (nonatomic, copy) NSString            *owner;
@property (nonatomic, assign) NSInteger         size;
@property (nonatomic, copy) NSString            *description;
@property (nonatomic, copy) NSString            *snippet;
@property (nonatomic, retain) AGSEnvelope       *extent;
@property (nonatomic, assign) double            uploaded;
@property (nonatomic, copy) NSString            *name;
@property (nonatomic, assign) double            avgRating;
@property (nonatomic, retain) NSMutableArray    *tags;
@property (nonatomic, assign) NSInteger         numComments;
@property (nonatomic, assign) NSInteger         numRatings;
@property (nonatomic, assign) NSInteger         numViews;

@end
