//
//  HTSheetView.h
//  HTSheetDemo
//
//  Created by taotao on 8/10/16.
//  Copyright © 2016 taotao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DoneBlock)(NSString*) ;
typedef void(^CancelBlock)() ;

@interface HTSheetView : UIButton
- (instancetype) initWithTitle:(NSString*)title items:(NSArray*)items done:(DoneBlock)done cancel:(CancelBlock) cancel;
- (void)show;



@end
