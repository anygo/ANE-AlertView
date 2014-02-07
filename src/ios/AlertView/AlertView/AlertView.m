//
//  AlertView.m
//  AlertView
//
//  Created by 1056ng on 2014/02/03.
//  Copyright (c) 2014年 1056ng. All rights reserved.
//

#import "AlertView.h"



@interface AlertView ()

@property (nonatomic) FREContext *_context;

@end

@implementation AlertView

AlertView *alertViewInstance;

//---------------------------------------------
//  init
//---------------------------------------------
- (id) initWithContext:(FREContext *)i_context {
    
    
    if( self = [super init] ) {
        
        self._context = i_context;
        
    }
    
    return self;
    
}

//---------------------------------------------
//  show
//---------------------------------------------
- (void) show:(FREObject *)argv argLength:(uint32_t)i_argLength {
    
    NSString* title = nil;
    NSString* message = nil;
    NSString* btn1 = nil;
    NSString* btn2 = nil;
    
    uint32_t stringLength;
    const uint8_t *string;
    
    //title
    if( FREGetObjectAsUTF8( argv[0], &stringLength, &string ) == FRE_OK ) {
        
        title = [NSString stringWithUTF8String:(char *)string];
        
    }
    
    //message
    if( FREGetObjectAsUTF8( argv[1], &stringLength, &string ) == FRE_OK ) {
        
        message = [NSString stringWithUTF8String:(char *)string];
        
    }
    
    //btn1
    if( FREGetObjectAsUTF8( argv[2], &stringLength, &string ) == FRE_OK ) {
        
        btn1 = [NSString stringWithUTF8String:(char *)string];
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:btn1 otherButtonTitles:nil];
    
    
    //btn2
    if( i_argLength > 3 ) {
        if( FREGetObjectAsUTF8( argv[3], &stringLength, &string ) == FRE_OK ) {
            
            btn2 = [NSString stringWithUTF8String:(char *)string];
            [alert addButtonWithTitle:btn2];
            
        }
    }
    
    
    [alert show];
    
}


//---------------------------------------------
//  alert view delegate
//---------------------------------------------
- (void) alertView:(UIAlertView *)i_alertView clickedButtonAtIndex:(NSInteger)i_buttonIndex {
    
    FREDispatchStatusEventAsync( self._context, (uint8_t *)"CLICK", (uint8_t *)[[NSString stringWithFormat:@"%d", i_buttonIndex] UTF8String] );
    
}


@end

//---------------------------------------------
//  show
//---------------------------------------------
FREObject AlertViewShow( FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] ) {
    
    [alertViewInstance show:argv argLength:argc];
    
    return nil;
    
    
}

//---------------------------------------------
//  ane context initialize
//---------------------------------------------
void AlertViewContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet ) {
    
    if( alertViewInstance == nil ) {
        alertViewInstance = [[AlertView alloc] initWithContext:ctx];
    }
    
    
    NSInteger nbFuntionsToLink = 1;
    
    *numFunctionsToTest = nbFuntionsToLink;
    
    FRENamedFunction* func = ( FRENamedFunction* )malloc( sizeof( FRENamedFunction ) * nbFuntionsToLink );
    
    func[0].name = (const uint8_t*)"AlertViewShow"; //ネイティブ拡張関数名
    func[0].functionData = NULL;
    func[0].function = &AlertViewShow; //ネイティブコード関数のポインタ
    
    *functionsToSet = func;
    
    
    
}

//---------------------------------------------
//  ane context finalize
//---------------------------------------------
void AlertViewContextFinalizer( FREContext ctx ) {
    return;
}

//---------------------------------------------
//  ane initialize
//---------------------------------------------
void AlertViewExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AlertViewContextInitializer;
    *ctxFinalizerToSet = &AlertViewContextFinalizer;
}

//---------------------------------------------
//  ane finalize
//---------------------------------------------
void AlertViewExtFinalizer( void* extData ) {
    return;
}