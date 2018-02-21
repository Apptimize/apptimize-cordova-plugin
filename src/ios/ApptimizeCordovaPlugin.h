#import <Cordova/CDVPlugin.h>
#import <Apptimize/Apptimize.h>
#import <Apptimize/Apptimize+Variables.h>

@interface ApptimizeCordovaPlugin : CDVPlugin
//- (void)startApptimize:(CDVInvokedUrlCommand*)command;
- (void)runTest:(CDVInvokedUrlCommand*)command;
- (void)track:(CDVInvokedUrlCommand*)command;
- (void)trackValue:(CDVInvokedUrlCommand*)command;
- (void)isFeatureFlagOn:(CDVInvokedUrlCommand*)command;
- (void)integerWithName:(CDVInvokedUrlCommand*)command;
- (void)stringWithName:(CDVInvokedUrlCommand*)command;
@end
