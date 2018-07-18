//
//  MyUIView.h
//
//  Created by KwangJo on 10. 10. 8..
//  Copyright 2010 Yonsei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MyUIView :UIView/* Specify a superclass (eg: NSObject or NSView) */ {
	int gX, gY;
}

-(IBAction) NewGame:(id)sender;
-(IBAction) CheckEnd:(id)sender;

@end
