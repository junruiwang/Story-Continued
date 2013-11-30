//
//  StoryDetailViewController.m
//  StoryContinued
//
//  Created by jerry on 13-10-20.
//
//

#import "StoryDetailViewController.h"
#import "ContentCell.h"
#import "LeafContentCell.h"
#import "StoryDetailParser.h"
#import "LeafListParser.h"
#import "JBContent.h"

@interface StoryDetailViewController ()<LeafContentCellDelegate>

@property(nonatomic,strong) UILabel *writeMessageLabel;

@property(nonatomic,strong) JBContent *lastContent;
@property(nonatomic,strong) StoryDetailParser *storyDetailParser;
@property(nonatomic,strong) LeafListParser *leafListParser;
@property(nonatomic,strong) NSMutableArray *contentList;
@property(nonatomic,assign) NSInteger leafPageIndex;

@end

@implementation StoryDetailViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _contentList = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetTableSize];
    [self buildJieLongButton];
    [self downloadData];
	// Do any additional setup after loading the view.
}

- (void)resetTableSize
{
    CGRect rect = self.listTableView.frame;
    self.listTableView.frame = CGRectMake(rect.origin.x, rect.origin.y+8, rect.size.width, rect.size.height-8);
    UIImageView *topLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    topLineView.backgroundColor = [UIColor clearColor];
    topLineView.image = [UIImage imageNamed:@"box_top_line.png"];
    [self.listTableView addSubview:topLineView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    self.writeMessageLabel = nil;
    self.jielongButton = nil;
    self.listTableView = nil;
    
    [super viewDidUnload];
}

- (void)downloadData
{
    if (!self.storyDetailParser)
    {
        self.storyDetailParser = [[StoryDetailParser alloc] init];
        self.storyDetailParser.isHTTPGet = YES;
        self.storyDetailParser.serverAddress = kContentListSearchURL;
    }
    self.storyDetailParser.requestString = [NSString stringWithFormat:@"storyId=%@",self.story.storyId];
    self.storyDetailParser.delegate = self;
    [self.storyDetailParser start];
}

- (void)loadNodesData
{
    if (!self.leafListParser) {
        self.leafListParser = [[LeafListParser alloc] init];
        self.leafListParser.isHTTPGet = YES;
        self.leafListParser.serverAddress = kNodeListURL;
    }
    self.leafListParser.requestString = [NSString stringWithFormat:@"storyId=%@&contentId=%@",self.story.storyId,self.lastContent.contentId];
    self.leafListParser.delegate = self;
    [self.leafListParser start];
}

- (void)buildJieLongButton
{
    self.jielongButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jielongButton.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
    [self.jielongButton setBackgroundImage:[UIImage imageNamed:@"bottom_jielong_bg_ios7.png"] forState:UIControlStateNormal];
    
    UIImageView *writeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 12, 30, 30)];
    writeImageView.image = [UIImage imageNamed:@"icon_story_write.png"];
    [self.jielongButton addSubview:writeImageView];
    self.writeMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 16, 211, 21)];
    self.writeMessageLabel.backgroundColor = [UIColor clearColor];
    self.writeMessageLabel.textColor = RGBCOLOR(243, 152, 46);
    self.writeMessageLabel.font = [UIFont systemFontOfSize:15];
    [self.jielongButton addSubview:self.writeMessageLabel];
    [self.view addSubview:self.jielongButton];
}

//冒泡排序
- (void)sortByLevelRuleArray
{
    int arraylength = self.contentList.count;
    if (arraylength > 0) {
        for (int i=0; i < (arraylength - 1); i++) {
            for (int m=0; m < (arraylength-i-1); m++) {
                JBContent *currentContent = self.contentList[m];
                JBContent *nextContent = self.contentList[m+1];
                if (currentContent.level > nextContent.level) {
                    [self.contentList replaceObjectAtIndex:m withObject:nextContent];
                    [self.contentList replaceObjectAtIndex:(m+1) withObject:currentContent];
                }
            }
        }
    }
}

#pragma mark - CommonJsonParserDelegate
- (void)parser:(CommonJsonParser*)parser DidFailedParseWithMsg:(NSString*)msg errCode:(NSInteger)code
{
    NSLog(@"%@，code：%d", msg, code);
}

- (void)parser:(CommonJsonParser*)parser DidParsedData:(NSDictionary *)data
{
    if ([parser isKindOfClass:[StoryDetailParser class]]) {
        self.contentList = [data valueForKey:@"data"];
        [self sortByLevelRuleArray];
        //刷新查询结果集
        if (self.contentList.count > 0) {
            [self.listTableView reloadData];
            [self loadLeafList];
        }
    } else if ([parser isKindOfClass:[LeafListParser class]]) {
        NSArray *leafArray = [data valueForKey:@"data"];
        //存在叶子集,加入集合中
        if (leafArray && (leafArray.count > 0)) {
            [self.contentList addObject:leafArray];
            self.leafPageIndex = 0;
        }
        //添加一行空数据，给 jielongButton 留出位置
        [self.contentList addObject:@""];
        //刷新表视图
        [self.listTableView reloadData];
    }
}

- (void)loadLeafList
{
    //记录最后一层主干
    NSUInteger count = self.contentList.count;
    self.lastContent = [self.contentList objectAtIndex:(count-1)];
    //获取叶子集合
    [self loadNodesData];
}

- (void)showJieLongButton
{
    self.writeMessageLabel.text = [NSString stringWithFormat:@"故事还没完，接着#%d楼编吧...",self.lastContent.level];
    [UIView animateWithDuration:0.3 animations:^{
        self.jielongButton.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
        
    }];
}

#pragma mark - LeafContentCellDelegate
- (void)didScrollRowContent:(NSInteger)pageIndex
{
    self.leafPageIndex = pageIndex;
    [self.listTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    if ([self.contentList[row] isKindOfClass:[JBContent class]]) {
        JBContent *content = self.contentList[row];
        content.storyId = self.story.storyId;
        ContentCell *cell = (ContentCell *)[tableView dequeueReusableCellWithIdentifier:@"ContentCellID"];
        if (cell == nil)
        {
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentCellID"];
        }
        cell.dashedImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dashed_detail.png"]];
        if (row == (self.contentList.count-1)) {
            cell.dashedImageView.backgroundColor = RGBCOLOR(203, 203, 203);
        } else if ([self.contentList[row+1] isKindOfClass:[NSArray class]]) {
            cell.dashedImageView.backgroundColor = RGBCOLOR(203, 203, 203);
        }
        cell.content = content;
        return cell;
    } else if ([self.contentList[row] isKindOfClass:[NSArray class]]) {
        LeafContentCell *cell = (LeafContentCell *)[tableView dequeueReusableCellWithIdentifier:@"LeafContentCellID"];
        if (cell == nil)
        {
            cell = [[LeafContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeafContentCellID"];
        }
        cell.delegate = self;
        cell.storyId = self.story.storyId;
        cell.leafList = self.contentList[row];
        cell.pageIndex = self.leafPageIndex;
        cell.topTitleLabel.text = [NSString stringWithFormat:@"大家来评比，支持率高即可晋升到【%d楼】",self.lastContent.level+1];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonViewCellID"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonViewCellID"];
            cell.backgroundColor = [UIColor clearColor];
            [self showJieLongButton];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    if ([self.contentList[row] isKindOfClass:[JBContent class]]) {
        JBContent *content = self.contentList[row];
        return 50 + content.textHeight;
    } else if ([self.contentList[row] isKindOfClass:[NSArray class]]) {
        NSArray *contentArray = self.contentList[row];
        JBContent *content = contentArray[self.leafPageIndex];
        return 120 + content.textHeight;
    } else {
        return 55;
    }
}

@end
