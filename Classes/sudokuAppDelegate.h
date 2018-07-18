//
//  sudokuAppDelegate.h
//  sudoku
//
//  Created by KwangJo on 10. 10. 8..
//  Copyright 2010 Yonsei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sudokuViewController;

@interface sudokuAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    sudokuViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet sudokuViewController *viewController;

@end

