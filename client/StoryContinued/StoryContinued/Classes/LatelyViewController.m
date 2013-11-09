//
//  LatelyViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-15.
//
//

#import "LatelyViewController.h"
#import "ContentListCell.h"
#import "StoryListParser.h"
#import "JBStory.h"
#import "MJRefresh.h"
#import "StoryDetailViewController.h"
#import "ShareToSNSManager.h"

@interface LatelyViewController ()<MJRefreshBaseViewDelegate, ContentListCellDelegate>

@property(nonatomic,strong) MJRefreshHeaderView *refreshHeaderView;
@property(nonatomic,strong) MJRefreshFooterView *refreshFooterView;

@property(nonatomic, strong) StoryListParser *storyListParser;
@property(nonatomic,strong) NSMutableArray *storyList;
@property(nonatomic) int currentPageIndex;
@property(nonatomic,strong) JBStory *selectedStory;

@end

@implementation LatelyViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _storyList = [[NSMutableArray alloc] initWithCapacity:10];
        _currentPageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IOS7) {
        [self resetTableSize];
    }
    [self downloadData];
    // 下拉刷新
    self.refreshHeaderView = [[MJRefreshHeaderView alloc] init];
    self.refreshHeaderView.delegate = self;
    self.refreshHeaderView.scrollView = self.listTableView;
    
    // 上拉加载更多
    self.refreshFooterView = [[MJRefreshFooterView alloc] init];
    self.refreshFooterView.delegate = self;
    self.refreshFooterView.scrollView = self.listTableView;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self.refreshHeaderView free];
    [self.refreshFooterView free];
    self.listTableView = nil;
    [super viewDidUnload];
}

- (void)resetTableSize
{
    CGRect rect = self.view.frame;
    self.listTableView.frame = CGRectMake(rect.origin.x, self.navigationController.navigationBar.frame.size.height+23, rect.size.width, rect.size.height-self.navigationController.navigationBar.frame.size.height-49-30);
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self downloadData];
}

- (void)downloadData
{
    if (!self.storyListParser)
    {
        self.storyListParser = [[StoryListParser alloc] init];
        self.storyListParser.isHTTPGet = YES;
        self.storyListParser.serverAddress = kStoryListSearchURL;
    }
    self.storyListParser.requestString = [NSString stringWithFormat:@"storyType=%@&pageIndex=%d&length=%d",kStoryTypeLast,self.currentPageIndex,kPageSize];
    self.storyListParser.delegate = self;
    [self.storyListParser start];
}

#pragma mark - CommonJsonParserDelegate
- (void)parser:(CommonJsonParser*)parser DidFailedParseWithMsg:(NSString*)msg errCode:(NSInteger)code
{
    NSLog(@"%@，code：%d", msg, code);
}

- (void)parser:(CommonJsonParser*)parser DidParsedData:(NSDictionary *)data
{
    self.storyList = [data valueForKey:@"data"];
    [self.listTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 让刷新控件恢复默认的状态
    [self.refreshHeaderView endRefreshing];
    [self.refreshFooterView endRefreshing];
    return self.storyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentListCell *cell = (ContentListCell *)[tableView dequeueReusableCellWithIdentifier:@"ContentListCellID"];
    if (cell == nil)
    {
        cell = [[ContentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentListCellID"];
        
    }
    cell.delegate = self;
    int row = [indexPath row];
    JBStory *story = [self.storyList objectAtIndex:row];
    cell.story = story;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    JBStory *story = [self.storyList objectAtIndex:row];
    return 120+story.textHeight;
}

#pragma mark - ContentListCellDelegate
- (void)didTapRowContent:(JBStory*)story
{
    self.selectedStory = story;
    [self performSegueWithIdentifier:FROM_STORY_LIST_TO_DETAIL sender:nil];
}

- (void)didShareButtonClicked:(NSString *)context
{
    [ShareToSNSManager shareWithList:self shareImage:[UIImage imageNamed:@"icon.png"] shareText:context];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:FROM_STORY_LIST_TO_DETAIL])
    {
        StoryDetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.story = self.selectedStory;
    }
}

@end
