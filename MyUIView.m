//
//  MyUIView.m
//
//  Created by KwangJo on 10. 10. 8..
//  Copyright 2010 Yonsei. All rights reserved.
//

#import "MyUIView.h"
#import <UIKit/UIStringDrawing.h>
#include "sudoku.h"


@implementation MyUIView

//터치의 시작 이벤트
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for(UITouch *touch in [event allTouches])
	{
		CGPoint pt = [touch locationInView:self];	
		gX = pt.x;
		gY = pt.y;

		//눌러진 지점을 좌표로 변환후
		//데이터 입력을 받음
		if((gX/25-2)>=0 && (gX/25-2)<9)
		{
			if((gY/25-2)>=0 && (gY/25-2)<9)
			{
				if(!fixed[gY/25-2][gX/25-2])
				{
					UIAlertView *alertinput;
					NSString *message = [NSString stringWithFormat:@"%d를 바꿀 숫자 입력하세요",
										 board[gY/25-2][gX/25-2]];
					alertinput = [[UIAlertView alloc] initWithTitle:@"숫자 바꾸기" message:message 
														   delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"입력",nil];
					[alertinput addTextFieldWithValue:@"" label:@"newNumber"];
					UITextField *text1 = [alertinput textFieldAtIndex:0];
					text1.keyboardType = UIKeyboardTypeNumberPad;
					[alertinput show];
					[alertinput release];
				}
			}
		}
	}
}

//alert버튼 동작, alertview로부터 delegate된 함수
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	printf("%d\n", buttonIndex);
	if(buttonIndex ==1)
	{
		UITextField *text1 = [alertView textFieldAtIndex:0];
		if([text1.text intValue]<0 || [text1.text intValue]>9)
		{
			UIAlertView *alert;
			NSString *message = [NSString stringWithFormat:@"Touch OK to Continue"];
			alert = [[UIAlertView alloc] initWithTitle:@"잘못된 입력 1~9사이값을 입력하시오!" 
											   message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else board[gY/25-2][gX/25-2] = [text1.text intValue];
		//강제로 화면 갱신
		[self setNeedsDisplay];	
	}
	//이 함수가 종료된후 alert이 release된다.
}

//터치 진행 이벤트
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

//터치 종료 이벤트
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

//화면 갱신 이벤트
-(void)drawRect:(CGRect)rect
{
	printf("MOVEIN\n");
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	
	CGContextSetRGBStrokeColor(context, 1, 1, 1,1);
	CGContextSetLineWidth(context, 1.0);
	
	int x1,y1;// x1,y1 :세로 시작줄, X2,y2가로 시작줄 
	x1=y1 = 50;
	
	//판을 그린다
	for(int i=0;i<10;i++)
	{
		CGContextMoveToPoint(context, x1, y1);
		CGContextAddLineToPoint(context, x1, 225+50);
		x1+=25;
	}
	x1=y1=50;
	for(int i=0;i<10;i++)
	{
		CGContextMoveToPoint(context, x1, y1);
		CGContextAddLineToPoint(context, 225+50, y1);
		y1+=25;
	}
	//하얀색 격자
	CGContextStrokePath(context);//추가된 라인을 그린다
	

	//사용자 편의를 위한 Boarder
	CGContextSetRGBStrokeColor(context, 0, 0, 0,1);
	CGContextSetLineWidth(context, 2.0);
	CGContextMoveToPoint(context, 50, 50);
	CGContextAddLineToPoint(context, 50, 225+50);
	CGContextMoveToPoint(context, 75+50, 50);
	CGContextAddLineToPoint(context, 75+50, 225+50);
	CGContextMoveToPoint(context, 150+50, 50);
	CGContextAddLineToPoint(context, 150+50, 225+50);

	CGContextMoveToPoint(context, 225+50, 50);
	CGContextAddLineToPoint(context, 225+50, 225+50);
	CGContextMoveToPoint(context, 50, 50);
	CGContextAddLineToPoint(context, 225+50, 50);
	CGContextMoveToPoint(context, 50, 75+50);
	CGContextAddLineToPoint(context, 225+50, 75+50);
	CGContextMoveToPoint(context, 50, 150+50);
	CGContextAddLineToPoint(context, 225+50, 150+50);
	CGContextMoveToPoint(context, 50, 225+50);
	CGContextAddLineToPoint(context, 225+50, 225+50);
	CGContextStrokePath(context);//추가된 라인을 그린다

    
	//board의 텍스트를 출력한다.
	char data[50];
	for(int i=0;i<9;i++)
	{
		for(int j=0;j<9;j++)
		{
			if(board[i][j]==0) continue;
			memset(data,0,sizeof(char)*50);
			sprintf(data, "%d",board[i][j]);
			
			if(!fixed[i][j])
			{
				CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
				CGContextSetRGBFillColor (context, 0, 0, 1, 1); 
			}
			else{
				CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
				CGContextSetRGBFillColor (context, 0, 0, 0, 1); 
			}
			
			CGContextSelectFont(context, "Helvetica", 22.0, kCGEncodingMacRoman);
			CGAffineTransform transform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
			CGContextSetTextMatrix(context, transform);
			CGContextShowTextAtPoint(context, 55.0 + 25*j, 72.0+ 25*i, data, strlen(data));
		}
	}
	
	CGContextFlush(context);
	//[context release];
	
}

-(IBAction) NewGame:(id)sender
{
	//판 초기화
	Init();
	//강제로 화면 갱신
	[self setNeedsDisplay];		
}
-(IBAction) CheckEnd:(id)sender;
{
	UIAlertView *alert;
	NSString *message = [NSString stringWithFormat:@"Touch OK to Continue"];
	if(IsFinish())
	{
		alert = [[UIAlertView alloc] initWithTitle:@"축하합니다!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	}
	else
	{
		alert = [[UIAlertView alloc] initWithTitle:@"좀더 노력하세요!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	}
	[alert show];
	[alert release];


}
@end
