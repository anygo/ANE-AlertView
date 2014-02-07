//
//  AlertView.h
//  AlertView
//
//  Created by 1056ng on 2014/02/03.
//  Copyright (c) 2014年 1056ng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"

@interface AlertView : NSObject <UIAlertViewDelegate>

- (void) show:(FREObject *)argv argLength:(uint32_t)i_argLength;

@end

//---------------------------------------------
// show
//---------------------------------------------
FREObject AlertViewShow( FREContext ctx, void* funcData, uint32_t argc, FREObject arg[] );

//---------------------------------------------
// ane context initialize
//---------------------------------------------
void AlertViewContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet );

//---------------------------------------------
// ane context finalize
//---------------------------------------------
void AlertViewContextFinalizer( FREContext ctx );

//---------------------------------------------
// ane initialize
//---------------------------------------------
void AlertViewExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet );

//---------------------------------------------
// ane finalize
//---------------------------------------------
void AlertViewExtFinalizer(void* extData);