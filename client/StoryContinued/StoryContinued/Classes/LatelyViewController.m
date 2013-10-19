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

@interface LatelyViewController ()

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.contentLabel.text = story.storyHeadContext;
    cell.zanCount = 100;
    cell.caiCount = 50;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    JBStory *story = [self.storyList objectAtIndex:row];
    return 120+story.textHeight;
}


@end
