//
//  ImageViewController.h
//  Seepet
//
//  Created by issuser on 13-12-4.
//
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
{
    IBOutlet UIImageView *imageView;
}
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy)   NSString *imageUrlString;

@end
