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

@interface StoryDetailViewController ()

@property(nonatomic,strong) NSString *lastContentId;
@property(nonatomic,strong) StoryDetailParser *storyDetailParser;
@property(nonatomic,strong) NSMutableArray *contentList;

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
    [self buildJieLongButton];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadData
{
    self.storyDetailParser = [[StoryDetailParser alloc] init];
    self.storyDetailParser.isHTTPGet = YES;
    self.storyDetailParser.serverAddress = kContentListSearchURL;
    self.storyDetailParser.requestString = [NSString stringWithFormat:@"storyId=%@",self.story.storyId];
    self.storyDetailParser.delegate = self;
    [self.storyDetailParser start];
}

- (void)loadNodesData
{
    self.storyDetailParser = [[StoryDetailParser alloc] init];
    self.storyDetailParser.isHTTPGet = YES;
    self.storyDetailParser.serverAddress = kNodeListURL;
    self.storyDetailParser.requestString = [NSString stringWithFormat:@"storyId=%@&contentId=%@",self.story.storyId,self.lastContentId];
    self.storyDetailParser.delegate = self;
    [self.storyDetailParser start];
}

- (void)buildJieLongButton
{
    self.jielongButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jielongButton.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    [self.jielongButton setBackgroundImage:[UIImage imageNamed:@"bottom_jielong_bg_ios7.png"] forState:UIControlStateNormal];
    
    UIImageView *writeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 12, 30, 30)];
    writeImageView.image = [UIImage imageNamed:@"write_bottom.png"];
    [self.jielongButton addSubview:writeImageView];
    UILabel *writeMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 16, 211, 21)];
    writeMessageLabel.backgroundColor = [UIColor clearColor];
    writeMessageLabel.textColor = RGBCOLOR(129, 129, 129);
    writeMessageLabel.font = [UIFont systemFontOfSize:15];
    writeMessageLabel.text = @"故事还没完，接着#5楼编吧...";
    [self.jielongButton addSubview:writeMessageLabel];
    
    [self.view addSubview:self.jielongButton];
}

#pragma mark - CommonJsonParserDelegate
- (void)parser:(CommonJsonParser*)parser DidFailedParseWithMsg:(NSString*)msg errCode:(NSInteger)code
{
    NSLog(@"%@，code：%d", msg, code);
}

- (void)parser:(CommonJsonParser*)parser DidParsedData:(NSDictionary *)data
{
    self.contentList = [data valueForKey:@"data"];
    [self.listTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    if (row < 4) {
        ContentCell *cell = (ContentCell *)[tableView dequeueReusableCellWithIdentifier:@"ContentCellID"];
        
        if (cell == nil)
        {
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentCellID"];
            
        }
        cell.levelTag.text = [NSString stringWithFormat:@"#%d",row+1];
        return cell;
    } else if(row == 4) {
        LeafContentCell *cell = (LeafContentCell *)[tableView dequeueReusableCellWithIdentifier:@"LeafContentCellID"];
        
        if (cell == nil)
        {
            cell = [[LeafContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeafContentCellID"];
            
        }
        cell.topTitleLabel.text = @"大家来评比，好评度高即可晋升到#6楼";
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonViewCellID"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonViewCellID"];
            cell.backgroundColor = [UIColor clearColor];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    if (row < 4) {
        return 190;
    } else if(row == 4)  {
        return 180;
    } else {
        return 55;
    }
    
}

@end
