//
//  ViewController.m
//  TableViewEditTest
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController {
    NSMutableArray *data;
}

- (IBAction)toggleEdit:(id)sender {
    self.table.editing = !self.table.editing;
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    //입력문자열의 길이가 2 이상일때 추가가능
    NSString *inputStr = [alertView textFieldAtIndex:0].text;
    return [inputStr length] > 2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //TODO : data 추가
    
}

//각 스타일을 번갈아 가면서 사용~
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        return UITableViewCellEditingStyleNone;
    }else if (indexPath.row % 3 == 1) {
        return UITableViewCellEditingStyleDelete;
    }else {
        return UITableViewCellEditingStyleInsert;
    }
}

//삭제/추가 작업 - 일단은 로그
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //데이터 삭제
        [data removeObjectAtIndex:indexPath.row];
        //테이블 셀 삭제
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
    }else {
        //데이터 추가를 위한 alertView 띄우기
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"추가" message:nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //dynamic prototypes 방식 사용
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", (int)indexPath.row];
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data =  [[NSMutableArray alloc] initWithObjects:@"Item0", @"Item1", @"Item2", @"Item3", @"Item4", @"Item5", @"Item6", @"Item7", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
