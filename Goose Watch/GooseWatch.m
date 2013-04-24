//
//  GooseWatch.m
//  Goose Watch
//
//  Created by alykhan.kanji on 23/04/13.
//  Copyright (c) 2013 Alykhan Kanji. All rights reserved.
//

#import "GooseWatch.h"
#import "OpenDataAPIKey.h"

@implementation GooseWatch

+ (NSArray *)retrieveSightings
{
    NSError *requestError = nil;
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.uwaterloo.ca/public/v1/?key=%@&service=GooseWatch", OpenDataAPIKey]];
    
    NSData *sightingsData = [NSData dataWithContentsOfURL:requestURL options:kNilOptions error:&requestError];
    if (requestError) NSLog(@"[%@ %@] Request Error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), requestError.localizedDescription);
    
    if (sightingsData) {
        NSError *parseError = nil;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:sightingsData options:kNilOptions error:&parseError];
        if (parseError) NSLog(@"[%@ %@] JSON Error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), parseError.localizedDescription);
        
//        NSLog(@"Response: %@", results);
        return [[[results objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"result"];
    }
    else return nil;
}

@end
