var Apptimize = function () {
}

/* Apptimize start is done automatically and the appkey is set via the config.xml preference */
/*
Apptimize.prototype.start = function(appKey) {
    cordova.exec(function(success){}, function(error) {}, "ApptimizeCordovaPlugin", "startApptimize", [appKey]);
};
*/

Apptimize.prototype.runTest = function(testName, baseline, variationNames, variationBlocks) {
    cordova.exec(function(codeblockNumber){
        if ( codeblockNumber === 0 || codeblockNumber > variationBlocks.length ) {
            baseline();
        }
        else {
            variationBlocks[codeblockNumber-1]();
        }
    }, function(error) {}, "ApptimizeCordovaPlugin", "runTest", [testName, variationNames]);
};

Apptimize.prototype.track = function(eventName) {
    cordova.exec(function(success){}, function(error) {}, "ApptimizeCordovaPlugin", "track", [eventName]);
};

Apptimize.prototype.trackValue = function(eventName, value) {
    cordova.exec(function(success){}, function(error) {}, "ApptimizeCordovaPlugin", "trackValue", [eventName, value]);
};

Apptimize.prototype.isFeatureFlagOn = function(name) {
    cordova.exec(function(success){
        alert(success);
    }, function(error) {}, "ApptimizeCordovaPlugin", "isFeatureFlagOn", [name]);
};

Apptimize.prototype.integerWithName = function(name, defaultInteger) {
    cordova.exec(function(success){}, function(error) {}, "ApptimizeCordovaPlugin", "integerWithName", [name, defaultInteger]);
};

Apptimize.prototype.stringWithName = function(name, defaultString) {
    cordova.exec(function(success){}, function(error) {}, "ApptimizeCordovaPlugin", "stringWithName", [name, defaultString]);
};

module.exports = new Apptimize();
