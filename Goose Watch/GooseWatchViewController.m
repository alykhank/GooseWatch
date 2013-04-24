//
//  GooseWatchViewController.m
//  Goose Watch
//
//  Created by alykhan.kanji on 23/04/13.
//  Copyright (c) 2013 Alykhan Kanji. All rights reserved.
//

#import "GooseWatchViewController.h"
#import <MapKit/MapKit.h>
#import "GooseWatch.h"
#import "SightingAnnotation.h"

@interface GooseWatchViewController ()
@property (nonatomic, strong) NSArray *sightings;
@property (nonatomic, strong) NSArray *annotations; // of id <MKAnnotation>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation GooseWatchViewController

@synthesize sightings = _sightings;
@synthesize annotations = _annotations;
@synthesize mapView = _mapView;

- (void)setAnnotations:(NSArray *)annotations
{
    if (_annotations != annotations) {
        _annotations = annotations;
        [self updateMapView];
    }
}

- (void)setMapView:(MKMapView *)mapView
{
    if (_mapView != mapView) {
        _mapView = mapView;
        [self updateMapView];
    }
}

- (void)updateMapView
{
    if (self.mapView.annotations) [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.annotations) [self.mapView addAnnotations:self.annotations];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshPressed:(UIBarButtonItem *)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_queue_t downloadQueue = dispatch_queue_create("GooseWatch Queue", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *sightings = [GooseWatch retrieveSightings];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            self.sightings = sightings;
            NSMutableArray *annotations = [NSMutableArray arrayWithCapacity:self.sightings.count];
            for (NSDictionary *sighting in self.sightings) {
                [annotations addObject:[SightingAnnotation annotationForSighting:sighting]];
            }
            self.annotations = annotations;
        });
    });
}
@end
