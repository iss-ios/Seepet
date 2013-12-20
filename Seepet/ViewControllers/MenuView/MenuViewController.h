//
//  MenuViewController.h
//  Seepet
//
//  Created by Mac on 13-11-11.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MenuViewController : BTEAbstractEngineAcitivity<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    NSArray *firstMenuData;
    NSArray *secondMenuData;
    NSArray *thirdMenuData;
    
    IBOutlet UIView *firstHeaderView;
    IBOutlet UITableView *_TableView;
    
    IBOutlet UIButton *headButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIButton *searchButton;
    IBOutlet UILabel  *locationLabel;
    CLLocationManager *locationManager;

}
@property(retain,nonatomic) UITableView *_TableView;
@end
