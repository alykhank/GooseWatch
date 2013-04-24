//
//  SightingAnnotation.m
//  Goose Watch
//
//  Created by alykhan.kanji on 23/04/13.
//  Copyright (c) 2013 Alykhan Kanji. All rights reserved.
//

#import "SightingAnnotation.h"

@implementation SightingAnnotation

@synthesize sighting;

+ (SightingAnnotation *)annotationForSighting:(NSDictionary *)sighting
{
    SightingAnnotation *annotation = [[SightingAnnotation alloc] init];
    annotation.sighting = sighting;
    return annotation;
}

- (NSString *)title
{
    return [self.sighting objectForKey:@"ID"];
}

- (NSString *)subtitle
{
    return [self.sighting objectForKey:@"Location"];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.sighting objectForKey:@"Latitude"] doubleValue];
    coordinate.longitude = [[self.sighting objectForKey:@"Longitude"] doubleValue];
    return coordinate;
}

@end
