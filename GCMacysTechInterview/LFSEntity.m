//
//  LFSEntity.m
//  GCMacysTechInterview
//
//  Created by Gustavo Couto on 2015-03-11.
//  Copyright (c) 2015 makr.space. All rights reserved.
//

#import "LFSEntity.h"

@implementation LFSEntity

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.freq = [NSString stringWithFormat:@"%@",dictionary[@"freq"]];
        self.lf = dictionary[@"lf"];
        self.since = [NSString stringWithFormat:@"%@",dictionary[@"since"]];

    }
    return self;
}

@end
