//
//  ViewController.m
//  LO_CoreData
//
//  Created by 侯志超 on 15/8/18.
//  Copyright (c) 2015年 河南蓝鸥科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Clothes.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataSource;

//  声明一个AppDelegate对象属性，来调用类中属性，比如被管理对象上下文
@property (nonatomic, strong)AppDelegate *myAppDelegate;

@end

@implementation ViewController

/**
 *  插入数据
 *
 *  @param sender ＋barButtonItem
 */
- (IBAction)addModel:(id)sender {
    //  插入数据
    
    //  创建实体描述对象
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Clothes" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    
    
    //  1.先创建一个模型对象
    Clothes *cloth = [[Clothes alloc] initWithEntity:description insertIntoManagedObjectContext:self.myAppDelegate.managedObjectContext];
    
    cloth.name = @"Puma";
    int price = arc4random() % 1000 + 1;
    cloth.price = [NSNumber numberWithInt:price];
    //  插入数据源数组
    [self.dataSource addObject:cloth];
    
    //  插入UI
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    
    //  对数据管理器中的更改进行永久存储
    [self.myAppDelegate saveContext];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //  初始化数组
    self.dataSource = [NSMutableArray array];
    self.myAppDelegate = [UIApplication sharedApplication].delegate;
    //  查询数据
    //  1.NSFetchRequst对象
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Clothes"];
    //  2.设置排序
    //  2.1创建排序描述对象
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    request.sortDescriptors = @[sortDescriptor];
    
    //  执行这个查询请求
    NSError *error = nil;
    
    NSArray *result = [self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error];
    //  给数据源数组中添加数据
    [self.dataSource addObjectsFromArray:result];
    
    
}

#pragma mark -tableView的delegate和dataSource方法
/**
 *
 *
 *  返回分区中的行数
 *  
 *
 *
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Clothes *cloth = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@", cloth.name, cloth.price];
    
    
    
    return cell;
}

//  允许tableView可以编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//  tableview编辑的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //  删除数据源
        Clothes *cloth = self.dataSource[indexPath.row];
        [self.dataSource removeObject:cloth];
        
        //  删除数据管理器中的数据
        [self.myAppDelegate.managedObjectContext deleteObject:cloth];
        //  将进行更改进行永久保存
        [self.myAppDelegate saveContext];
        
        
        //  删除单元格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

/**
 *  点击cell的方法用来修改数据
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  1.先找到模型对象
    Clothes *cloth = self.dataSource[indexPath.row];
    cloth.name = @"Nick";
    //  刷新单元行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //  通过saveContext方法对数据进行永久保存
    [self.myAppDelegate saveContext];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
