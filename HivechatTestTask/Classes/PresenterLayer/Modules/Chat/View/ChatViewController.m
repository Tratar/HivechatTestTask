//
//  ChatViewController.m
//  HivechatTestTask
//
//  Created by Michael Belenchenko on 13/07/2017.
//  Copyright © 2017 Michael Belenchenko. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatPresenter.h"

#import "ChatTextMessageTableViewCell.h"
#import "ChatImageMessageTableViewCell.h"
#import "ChatGeoLocationMessageTableViewCell.h"

#import "Message+CoreDataClass.h"
#import "Chat+CoreDataClass.h"
#import "Person+CoreDataClass.h"

NSString *const ChatTextMessageTableViewCellIdentifier = @"ChatTextMessageTableViewCellIdentifier";
NSString *const ChatImageMessageTableViewCellIdentifier = @"ChatImageMessageTableViewCellIdentifier";
NSString *const ChatGeoLocationMessageTableViewCellIdentifier = @"ChatGeoLocationMessageTableViewCellIdentifier";

CGFloat const ChatTextMessageTableViewCellHeightAddendum
 = 40;
CGFloat const ChatImageMessageTableViewCellHeight = 204.0;
CGFloat const ChatGeoLocationMessageTableViewCellHeight = 230.0;

CGFloat const ChatTextMessageTableViewCellWidth = 200.0;

CGFloat const ChatInsetBottom = 200.0;
CGFloat const TextFieldBottomOffset = 44.0;

@interface ChatViewController() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomInputFieldConstraint;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <Message *> *messages;
@property (nonatomic, strong) Person *currentUser;

@end

@implementation ChatViewController

#pragma mark Lifecycle

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.messages = [NSMutableArray new];
    }
    
    return self;
}

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.presenter loaded];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, ChatInsetBottom, 0.0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)keyboardWillBeShown:(NSNotification *)notification {
    CGRect rect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    self.bottomInputFieldConstraint.constant = rect.size.height;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:2.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    self.bottomInputFieldConstraint.constant = TextFieldBottomOffset;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:2.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Actions

- (IBAction)send:(id)sender {
    [self.inputTextField resignFirstResponder];
    [self.presenter newTextMessage:self.inputTextField.text];
    self.inputTextField.text = @"";
}

- (IBAction)pictureButtonAction:(id)sender {
    
    [self.presenter choosePicture];
}

- (IBAction)geoButtonAction:(id)sender {
    [self.presenter chooseLocation];
}

#pragma mark Presenter Output.

- (void)newMessage:(Message *)message {
    NSUInteger oldCount = self.messages.count;
    [self.messages addObject:message];
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:oldCount inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)showChat:(Chat *)chat withMessages:(NSArray <Message *>*)messages forPerson:(Person *)person {
    self.title = chat.name;
    self.currentUser = person;
    self.messages = [messages mutableCopy];
    [self.tableView reloadData];
    if (messages.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (void)updateTitle:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = title;
    });
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    if (message.bodyText != nil) {
        return [self cellWidthByText:message.bodyText];
    } else if (message.bodyPicture != nil) {
        return ChatImageMessageTableViewCellHeight;
    } else if (message.bodyLocation != nil) {
        return ChatGeoLocationMessageTableViewCellHeight;
    }
    return 0.0;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.messages[indexPath.row];
    UITableViewCell *cell = nil;
    if (message.bodyPicture != nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ChatImageMessageTableViewCellIdentifier];
        [(ChatImageMessageTableViewCell *)cell configureWithMessage:message sentByCurrentUser:self.currentUser == message.sender];
    } else if (message.bodyLocation != nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ChatGeoLocationMessageTableViewCellIdentifier];
        [(ChatGeoLocationMessageTableViewCell *)cell configureWithMessage:message sentByCurrentUser:self.currentUser == message.sender];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:ChatTextMessageTableViewCellIdentifier];
        [(ChatTextMessageTableViewCell *)cell configureWithMessage:message sentByCurrentUser:self.currentUser == message.sender];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark Private

- (CGFloat)cellWidthByText:(NSString *)text {
    CGRect r = [text boundingRectWithSize:CGSizeMake(200, 0)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}
                                  context:nil];
    return r.size.height + ChatTextMessageTableViewCellHeightAddendum;
}

@end
