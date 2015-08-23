//
//  Clothes.h
//  LO_CoreData
//
//  Created by 侯志超 on 15/8/18.
//  Copyright (c) 2015年 河南蓝鸥科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Clothes : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * type;

@end
