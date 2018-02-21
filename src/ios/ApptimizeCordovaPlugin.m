#import "ApptimizeCordovaPlugin.h"
#import <Cordova/CDVPlugin.h>
#import <Apptimize/Apptimize.h>
#import <Apptimize/Apptimize+Variables.h>

@implementation ApptimizeCordovaPlugin

- (void)pluginInitialize {
    [super pluginInitialize];

    NSDictionary *settings = self.commandDelegate.settings;
    NSString *appKey = settings[@"com.apptimize.ios.app_key"];
    [Apptimize startApptimizeWithApplicationKey:appKey];
}

/*
- (void)startApptimize:(CDVInvokedUrlCommand*)command
{
    NSString* appKey = [[command arguments] objectAtIndex:0];
    [Apptimize startApptimizeWithApplicationKey:appKey];
}
*/

- (void)runTest:(nonnull CDVInvokedUrlCommand*)command
{
    NSString *callbackId = [command callbackId];
    NSString *testName = [command argumentAtIndex:0];
    NSArray *variationNames = [command argumentAtIndex:1];

    NSMutableArray *apptimizeCodeBlocks = [NSMutableArray new];
    for ( int i = 0; i < variationNames.count; i++ ) {
        ApptimizeCodeBlock *apptimizeCodeBlock = [[ApptimizeCodeBlock alloc] initWithName:variationNames[i]
                                                                                 andBlock:^()
        {
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:i+1];
            [self.commandDelegate sendPluginResult:result callbackId:callbackId];
        }];
        [apptimizeCodeBlocks addObject:apptimizeCodeBlock];
    }
    [Apptimize runTest:testName withBaseline:^() {
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:0];
        [self.commandDelegate sendPluginResult:result callbackId:callbackId];
    } andApptimizeCodeBlocks:apptimizeCodeBlocks];
}

- (void)track:(CDVInvokedUrlCommand*)command
{
    NSString *eventName = [command argumentAtIndex:0];
    [Apptimize track:eventName];
}

- (void)trackValue:(CDVInvokedUrlCommand*)command
{
    NSString *eventName = [command argumentAtIndex:0];
    NSNumber *eventValue = [command argumentAtIndex:1];
    [Apptimize track:eventName value:[eventValue doubleValue]];
}

- (void)isFeatureFlagOn:(CDVInvokedUrlCommand*)command
{
    NSString *name = [command argumentAtIndex:0];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[Apptimize isFeatureFlagOn:name]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)integerWithName:(CDVInvokedUrlCommand*)command
{
    NSString *name = [command argumentAtIndex:0];
    NSNumber *defaultInteger = [command argumentAtIndex:1];
    NSInteger value = [defaultInteger integerValue];
    [ApptimizeVariable integerWithName:name andDefaultInteger:value];
}

- (void)stringWithName:(CDVInvokedUrlCommand*)command
{
    NSString *name = [command argumentAtIndex:0];
    NSString *defaultString = [command argumentAtIndex:1];
    [ApptimizeVariable stringWithName:name andDefaultString:defaultString];
}

@end
