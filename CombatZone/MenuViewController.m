//
//  MenuViewController.m
//  CombatZone
//
//  Created by Adluna on 09.07.2014.
//  Copyright (c) 2014 Adluna. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
- (void) loadMenu;
- (CGSize) scaleImage:(CGSize)menu image:(CGSize)image;
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@property BOOL isLogo;
@end

@implementation MenuViewController

- (void) tmp:(UIGestureRecognizer *)recognizer{
    NSLog(@"jestem w tmp");
    //[self.tmplabel setText:[NSString stringWithFormat:@"trololo"]];
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    self.isLogo = YES;
    [super viewDidLoad];

    UITapGestureRecognizer *singleTap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tmp:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.naviButton addGestureRecognizer:singleTap];
    [self loadMenu];
    
    
    // Do any additional setup after loading the view.
}

- (void) clear
{
    self.isLogo = NO;
    
    NSUInteger numOfSubViews = self.menuScrollView.subviews.count;
    for(int i = 0; i< numOfSubViews;i++){
        [[self.menuScrollView.subviews objectAtIndex:i] removeFromSuperview];
    }
    
}

- (void) loadMenu
{
    NSArray *menu = [NSArray arrayWithObjects:@"logo", @"news", @"facebook", @"training", @"seminar",@"page", nil];
    NSInteger imageHeight = self.menuScrollView.frame.origin.y;
    NSInteger numberOfViews = [menu count];
    
    
    for (int i = 0; i < numberOfViews; i++) {
        CGSize size = CGSizeMake( self.view.frame.size.width,
                                 self.view.frame.size.height);
        CGFloat yOrigin =imageHeight;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(0, yOrigin,
                                         self.view.frame.size.width,
                                         120)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat: menu[i]]];
        
        size = [self scaleImage:size image:image.image.size];
        image.image = [self imageWithImage:image.image scaledToSize:size];
        
        
        image.contentMode = UIViewContentModeCenter;
        image.center = CGPointMake(self.menuScrollView.frame.size.width / 2, image.frame.origin.y);
        [self.menuScrollView addSubview:image];
        imageHeight += image.image.size.height + 20;
    }
    
    

    
    NSInteger width = self.menuScrollView.frame.size.width;
    CGSize scrollableSize = CGSizeMake(width, imageHeight);
    [self.menuScrollView setContentSize:scrollableSize];
    

   }

- (CGSize) scaleImage:(CGSize)menu image:(CGSize)image
{
    //if(image.width>menu.width)
    //{
        float IW;
        if(self.isLogo){
            IW = menu.width;
            self.isLogo = NO;
        }else
            IW = menu.width * 0.7;
        
        float ratio = image.width / image.height;
        float IH = IW/ratio;
        return CGSizeMake(IW,IH);
    //}
    //else
    //    return image;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self clear];
    [self loadMenu];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
