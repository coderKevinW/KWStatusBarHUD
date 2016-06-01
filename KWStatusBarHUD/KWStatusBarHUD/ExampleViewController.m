/** 
 *  1 首先准备好example，考虑在例子中如何使用该自定义控件，并且思考如何在自定义控件写对应的方法。
 *  2 
 */

#import "ExampleViewController.h"
#import "KWStatusBarHUD.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/** 显示自定义的信息 */
- (IBAction)showCustomedMessage
{
    [KWStatusBarHUD showMessage:@"百思不得姐" image:nil];
}

/** 加载成功 */
- (IBAction)loadSuccessfully
{
    [KWStatusBarHUD showSuccess:@"加载成功！"];
}

/** 加载失败 */
- (IBAction)loadFailurely
{
    [KWStatusBarHUD showFailure:@"加载失败！"];
}

/** 加载中 */
- (IBAction)loading
{
    [KWStatusBarHUD showLoading:@"正在拼命加载..."];
}

/** 隐藏蒙板 */
- (IBAction)hideStatusBarHUD
{
    [KWStatusBarHUD hideHUD];
}
@end
