//
//  AppDelegate.h
//  LO_CoreData
//
//  Created by 侯志超 on 15/8/18.
//  Copyright (c) 2015年 河南蓝鸥科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//  被管理对象上下文（数据管理器）相当于一个临时数据库
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//  被管理对象模型（数据模型器）
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//  持久化存储助理（数据链接器）整个CoreData框架中的核心
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//  把我们临时数据库中进行的改变进行永久保存
- (void)saveContext;
//  获取真实文件的存储路径
- (NSURL *)applicationDocumentsDirectory;


@end

