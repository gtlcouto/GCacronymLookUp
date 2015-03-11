//
//  LFSEntity.h
//  GCMacysTechInterview
//
//  Created by Gustavo Couto on 2015-03-11.
//  Copyright (c) 2015 makr.space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFSEntity : NSObject

@property (strong, nonatomic) NSString * freq;
@property (strong, nonatomic) NSString * lf;
@property (strong, nonatomic) NSString * since;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
