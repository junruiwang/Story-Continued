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

@interface LatelyViewController ()<MJRefreshBaseViewDelegate>

@property(nonatomic,strong) MJRefreshHeaderView *refreshHeaderView;
@property(nonatomic,strong) MJRefreshFooterView *refreshFooterView;

@property(nonatomic, strong) StoryListParser *storyListParser;
@property(nonatomic,strong) NSMutableArray *storyList;
@property(nonatomic) int currentPageIndex;

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
    int row = [indexPath row];
    JBStory *story = [self.storyList objectAtIndex:row];
    cell.userName.text = story.userName;
    cell.totalMember.text = [NSString stringWithFormat:@"%d人参与接龙",story.totalPartake];
    cell.contentLabel.text = story.storyHeadContext;
    cell.zanCount = story.totalLike;
    cell.caiCount = story.totalDislike;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    JBStory *story = [self.storyList objectAtIndex:row];
    return 120+story.textHeight;
}


@end
