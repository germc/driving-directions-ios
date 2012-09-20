//
//  MapAppSettings.m
//  Map
//
//  Created by Scott Sirowy on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapAppSettings.h"
#import "MapSettings.h"
#import "NSDictionary+Additions.h"
#import "Location.h"
#import "ContactsManager.h"
#import "Bookmarks.h"
#import "ContactsManager+ContactsManager_DrawableList.h"
#import "ContactsManager.h"
#import "Route.h"
#import "Search.h"
#import "RecentSearches.h"
#import "ContactsList.h"
#import "Organization.h"
#import "RouteSolverSettings.h"

@implementation MapAppSettings

@synthesize recentSearches = _recentSearches;@synthesize bookmarks = _bookmarks;
@synthesize contacts = _contacts;
@synthesize customBasemap = _customBasemap;
@synthesize savedExtent = _savedExtent;
@synthesize legend = _legend;
@synthesize routeSolverSettings = _routeSolverSettings;
@synthesize organization = _organization;

- (id)init
{
    self = [super init];
    if (self) {
        self.recentSearches = [[[RecentSearches alloc] initWithName:NSLocalizedString(@"Recent Searches", nil) 
                                                        withItems:nil] autorelease];
        
        self.bookmarks = [[[Bookmarks alloc] init] autorelease];
        
        self.routeSolverSettings = [[[RouteSolverSettings alloc] init] autorelease];
        
        self.customBasemap = nil;
        
        self.savedExtent = nil;
    }
    
    return self;
}

#pragma mark -
#pragma mark AGSCoding
- (void)decodeWithJSON:(NSDictionary *)json 
{
    [super decodeWithJSON:json];
    
    self.recentSearches = [[[RecentSearches alloc] initWithJSON:[json objectForKey:@"recentSearches"]] autorelease];
    
    self.bookmarks = [[[Bookmarks alloc] initWithJSON:[json objectForKey:@"bookmarks"]] autorelease];
    
    NSDictionary *solverJSON = [json objectForKey:@"routeSolverSettings"];
    if (solverJSON) {
        self.routeSolverSettings = [[[RouteSolverSettings alloc] initWithJSON:solverJSON] autorelease];
    }
    else
    {
        self.routeSolverSettings = [[[RouteSolverSettings alloc] init] autorelease];
    }
    
#warning Commented Out for now. Needs to be moved to organization
    /*
    NSDictionary *webMapJSON = [json objectForKey:@"currentMap"];
    if (webMapJSON) {
        self.currentMap = [[[AGSWebMap alloc] initWithJSON:webMapJSON] autorelease];
    }
    
    NSDictionary *extentJSON = [json objectForKey:@"savedExtent"];
    if (webMapJSON) {
        self.savedExtent = [[[AGSEnvelope alloc] initWithJSON:extentJSON] autorelease];
    }
     */
}

- (id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    
    if (self) {
        [self decodeWithJSON:json];
    }
    return self;
}

- (NSDictionary *)encodeToJSON
{
    NSMutableDictionary *json = (NSMutableDictionary *)[super encodeToJSON];
    
    [json setObject:[self.recentSearches encodeToJSON] forKey:@"recentSearches"];

    [json setObject:[self.bookmarks encodeToJSON] forKey:@"bookmarks"];
    
    /*if (self.currentMap) {
        [json setObject:[self.currentMap encodeToJSON] forKey:@"currentMap"];
    }  */
    
    if (self.savedExtent) {
        [json setObject:[self.savedExtent encodeToJSON] forKey:@"savedExtent"];
    }
    
    
#warning Still need to do custom basemap!!
    
	return json;
}

#pragma mark -
#pragma mark Lazy Loads
-(DrawableList *)contacts
{
    if(_contacts == nil)
    {
        self.contacts = [[ContactsManager sharedContactsManager] drawableContactsList];
    }
    
    return _contacts;
}

#pragma mark -
#pragma Public Methods
-(void)addBookmark:(Location *)bookmark withCustomName:(NSString *)name withExtent:(AGSEnvelope *)envelope
{
    bookmark.name = name;
    bookmark.icon = [UIImage imageNamed:@"BookmarkPin.png"];
    
    [self.bookmarks addBookmark:bookmark];
}
 
-(void)addRecentSearch:(Search *)recentSearch onlyUniqueEntries:(BOOL)unique;
{
    if(!recentSearch)
        return;
    
    //if we're not constraining to unique entries, go ahead an immediately add
    if(!unique)
        [self.recentSearches addItem:recentSearch];
    
    else
    {
        //else check descriptions to make sure it doesn't exist
        for(int i  = 0; i < [self.recentSearches numberOfItems]; i++)
        {
            Search* search = (Search *)[self.recentSearches itemAtIndex:i];
            if ([search.name isEqualToString:recentSearch.name]) {
                return;
            }
        }
        
        //not in list, go ahead and add
        [self.recentSearches addItem:recentSearch];
    }
}


-(void)clearRecentSearches
{
    [self.recentSearches clear];
}

#pragma mark -
#pragma mark DrawableContainerDatasource
-(NSUInteger)numberOfResultTypes
{    
    return [self.recentSearches numberOfItems] > 0;
}
-(NSUInteger)numberOfResultsInSection:(NSUInteger)section
{
    return [self.recentSearches numberOfItems];
}

-(NSString *)titleOfResultTypeForSection:(NSUInteger)section
{
    return self.recentSearches.name;
}

-(id<TableViewDrawable>)resultForRowAtIndexPath:(NSIndexPath *)index
{
    return [self.recentSearches itemAtIndex:index.row];
}

-(BOOL)canMoveResultAtIndexPath:(NSIndexPath *)index
{
    return NO;
}

-(DrawableList *)listForSection:(NSUInteger)section
{
    return self.recentSearches;
}

-(void)dealloc
{
    self.recentSearches = nil;
    self.bookmarks = nil;
    self.contacts = nil;
    self.customBasemap = nil;
    self.savedExtent = nil;
    self.legend = nil;
    self.routeSolverSettings = nil;
    self.organization = nil;
    
    [super dealloc];
}

@end
