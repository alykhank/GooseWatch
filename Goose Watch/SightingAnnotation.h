//
//  SightingAnnotation.h
//  Goose Watch
//
//  Created by alykhan.kanji on 23/04/13.
//  Copyright (c) 2013 Alykhan Kanji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SightingAnnotation : NSObject <MKAnnotation>

+ (SightingAnnotation *)annotationForSighting:(NSDictionary *)sighting; //sighting dictionary

@property (nonatomic, strong) NSDictionary *sighting;

@end
