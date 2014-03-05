//
//  AnatomyViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/26/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnatomyViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIButton *btnAbs;
    IBOutlet UIButton *btnFor;
    IBOutlet UIButton *btnChe;
    IBOutlet UIButton *btnTri;
    IBOutlet UIButton *btnBic;
    IBOutlet UIButton *btnLat;
    IBOutlet UIButton *btnSho;
    IBOutlet UIButton *btnMba;
    IBOutlet UIButton *btnLba;
    IBOutlet UIButton *btnTra;
    IBOutlet UIButton *btnLeg;
    IBOutlet UIImageView *body;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIImageView *imageView;
    IBOutlet UIView *zoomView;
    IBOutlet UILabel *txtChoose;
}
- (IBAction)selectedMuscle:(id)sender;

@end
