#ColorTV tvOS SDK

##Getting started


Before getting started make sure you have: 

* Added your app in the My Applications section of the Color Dashboard. You need to do this so that you can get your App ID that you'll be adding to your app with our SDK.

* Our newest tvOS SDK supports the newest Xcode (7.2). Please ensure you are using Xcode (7.2) or higher to ensure smooth integration.

---

##Adding tvOS SDK

###Connecting Your App
There are two ways to add Color to your Xcode project:

####1. Cocoapods
Easily add Color to your project by adding the following code to your Podfile:

```
pod 'Color-tvOS-SDK'
```

After adding this value, run `pod install` and the latest version of our tvOS SDK will be installed!

If you are using CocoaPods and Swift, you might encounter a compiler error: "Include of non-modular header inside framework...". It is [a bug in CocoaPods](https://github.com/CocoaPods/CocoaPods/issues/4420) which was fixed in 1.0.0.beta.1. If you are using an earlier version of CocoaPods, please add the following lines to your `Podfile`:

```ruby
post_install do |installer|
   `rm Pods/Headers/Public/Color-tvOS-SDK/COLORAdFramework/*.h`
end
```

####2. Manual Integration

[Download the tvOS SDK here](https://github.com/replaytv/Color-tvOS-SDK)

####Download & Unzip SDK 

Unzip and open the folder, then navigate to the ColorTV framework folder. Included are both frameworks for simulator and actual devices. Use the framework from the tvos-device folder for production, **only** use the framework for simulator for testing. 

Click on your Application at the top-left side of Xcode and go to project settings. Select *General* and choose proper target, it name in most cases corresponds to name of your project. Then drag and drop the COLORAdFramework.framework directory into the **Embeded Binaries** section.

![Importing Framework](https://raw.githubusercontent.com/color-tv/colortv-docs/master/colortv/docs/images/add_framework_tvOS.gif)

Once complete, you will see the COLORAdFramework in both the **Embedded Binaries and Linked Frameworks and Libraries** sections. Please note that the framework will be automatically added to **Linked Frameworks and Libraries**. It will **not** be automatically added to both if you add it to Linked Frameworks and Libraries first.

![Xcode configuration](https://www.filepicker.io/api/file/ncUuqdGR1GSOBtTaoUE3)

---

##Adding custom JS classes (TVML only)

Open AppDelegate.m and add function `appController:evaluateAppJavaScriptInContext`. If the function already exists please add following code to the function's body.

```objective-c
-(void)appController:(TVApplicationController *)appController evaluateAppJavaScriptInContext:(JSContext *)jsContext {
    [jsContext.globalObject setObject:[COLORAdController class] forKeyedSubscript:@"COLORAdController"];
    [jsContext.globalObject setObject:[COLORUserProfile class] forKeyedSubscript:@"COLORUserProfile"];
}

```

---

##Submitting to AppStore

**Before submitting your application to iTunesConnect please make sure that correct version of COLORAdFramework is used. Just to remind. We deliver two binaries - universal both for arm64 and i86 architecture as well as arm64 (directory: tvos-device). Remember, only the second one passes iTunesConnect validation.**

---

##Initializing SDK

Open AppDelegate.m and modify body of function `application:DidFinishLaunchingWithOptions:` with the App ID generated in the dashboard

```objective-c
[[COLORAdController sharedAdController] startWithAppIdentifier:@"YOUR_APP_ID_HERE"];
```

```Swift
COLORAdController.sharedAdController().startWithAppIdentifier("YOUR_APP_ID_HERE");
```

```JavaScript
COLORAdController.sharedAdController().startWithAppIdentifier("YOUR_APP_ID_HERE");
```

Remember to import COLORAdFramework module. Add following line of code above class implementation (If using TVML/TVJS add import declaration to AppDelegate.m.).

```objective-c
@import COLORAdFramework;
```

```Swift
@import COLORAdFramework
```

---

##Displaying ads

ColorTV offers lot of different types of advertisement which are automatically provided by our server in order to attract you audience. You do not need to care about proper ad and its content, we optimize the best performing content for all of your users. All you need to do is to add a few lines of code and an ad will be displayed wherever and whenever you want.

```objective-c
[[COLORAdController sharedAdController] adViewControllerForPlacement:COLORAdFrameworkPlacementAppLaunch withCompletion:^(COLORAdViewController * _Nullable vc, NSError * _Nullable error) {
        if(vc) {
            
            vc.adCompleted = ^(BOOL videoWatched) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            };
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
            });
        } else {
            NSLog(@"Error: %@", error);
        }
    } expirationHandler:^(COLORAdViewController * _Nullable expiredVC){
        //If you kept a reference to COLORAdViewController but haven't shown it yet, you should discard it now
    }];
```

```Swift
        COLORAdController.sharedAdController().adViewControllerForPlacement(placement, withCompletion:{ (vc , error) in
            guard let vc = vc else {
                print("Failed to initialize ad view controller, error: \(error?.description)")
                return
            }
    
            vc.adCompleted = { (videoWatched) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
    
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }, expirationHandler: { (expiredVc) in
            //If you kept a reference to COLORAdViewController but haven't shown it yet, you should discard it now
        })
```

```JavaScript
COLORAdController.sharedAdController().prepareAdForPlacementWithCompletionAndExpirationHandler("MainMenu", function(success) {
        if(success) {
            console.log("AD prepared");
            COLORAdController.sharedAdController().showLastAdWithCompletionHandler(function(watched) {
            		console.log("AD closed " + watched);
            });
        } else {
            console.log("AD NOT prepared");
        }
    }, function() {
        console.log("AD expired");
    }
);
```

We understand how imporant user experience is to your app's performance. Nobody wants to wait a few seconds to see an advertisement regardless how relevant it's content is, so we developed the method `adViewControllerWithCompletion` for optimal performance. Call `adViewControllerWithCompletion` whenever you think an ad is likely to be shown. We highly reccommend invoking this method in all potential places you will show an ad. By doing this you can decide to either stop or start showing ads at specific placements in your app via our dashboard without pushing updates to your users! 

Completion block is called when some elements of ad are loaded. It provides you two arguments, `viewController` and `error`. The framework generates `viewController` which is to be displayed in the manner which matches your application's structure. In most cases modal view controller is OK but sometimes navigation view controller or some kind if embedded view controller will be better. It is up to you.

When the ad should no longer be displayed you will be informed and need to define completion block. In the example above that controller is simply dismissed from screen.

You can keep a reference to `viewController` and show it later. However, the ad is valid only for some period of time (about 5-15 minutes). When it becomes invalid, `expirationHandler` is called, so you can discard the reference to `viewController`.

Please note that majority of operations are done on the background threads while interactions with User Interface are only made on the main thread. Remember to use `[NSThread mainThread]` (old style) or main queue from GCD (new style) when interacting with UI.

---

##Placements

When showing an ad you must provide the context inside your app where you are showing the ad. It will allow us to target ads more effectively and give you the ability to control the ads shown in the dashboard.

```objective-c
[[COLORAdController sharedAdController] setCurrentPlacement:COLORAdFrameworkPlacementStageOpen];
```

```Swift
COLORAdController.sharedAdController().currentPlacement = COLORAdFrameworkPlacementMainMenu
```

```JavaScript
COLORAdController.sharedAdController().setCurrentPlacement("StageOpen");
```

The predefined values available as constants whose names start with COLORAdFrameworkPlacement... 

---

##Displaying content recommendation

Displaying Recommendation is simillar to displaying ads. It may be shown wherever you place them inside your app, but you need to include a Placement parameter to indicate the specific location. As with ads, you can display content recommendation view controller in many ways: show it a modal view controller, push onto a navigation controller and so on.

```objective-c
[[COLORAdController sharedAdController] contentRecommendationControllerForPlacement:COLORAdFrameworkPlacementVideoEnd
    andVideoId:@"570d799457dde161ef006cbc" 
    withCompletion:^(COLORRecommendationViewController *vc, NSError *error) {
        if(!vc) {
            NSLog(@"Failed to get recommendation view controller for placement %@, error %@", COLORAdFrameworkPlacementMainMenu, error);
            return;
        }
        vc.contentRecommendationClosed = ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        vc.itemSelected = ^(NSString *videoId, NSURL *videoURL) {
            //play the selected video
        };
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:vc animated:YES completion:nil];
        });
    }];
```
To load a Content Recommendation for a certain placement, you need to call `contentRecommendationControllerForPlacement:andVideoId:withCompletion` method. You can use one of the predefined placements, like `COLORAdFrameworkPlacementVideoFinished`. If you show Content Recommendation after playing a video, you can pass its identifier in a `videoId` parameter to get more accurate recommendations.

When the user selects one of the recommended videos, you get notified by `itemSelected` handler, so you can play this video.

After the content recommendation view controler is closed by the user, `contentRecommendationClosed` block is called and you need to dismiss the recommendation view controller or remove it from the navigation stack.

###Reporting video events

In order to get even better content recommendation, you can use our SDK to collect data about the users' behavior in your app's videos. For example, you can report that a user stopped a video after watching it for 25 seconds. Simply call `trackEventForPartnerVideoId:eventType:secondsWatched` method, like this:

```objective-c
[[COLORAdController sharedAdController] trackEventForPartnerVideoId:@"570d799457dde161ef006cbc" eventType:COLORAdFrameworkVideoEventStopped secondsWatched:25];
```

The types of events which can be reported are defined in `COLORAdFrameworkVideoEventType` enum.

---

##User Profile

Another way to provide valuable information which allows us to provide suitable ads to your audience is user profile. You can provide basic information which characterise specific user by setting properties of `COLORUserProfile` Singleton. If for some reason you believe that user of your application has changed, e.g. account is switched call `-(void)reset` method and set new values.
Property `age` is an unsigned integer which represent number of years elapsed since user was born. If you do not know exact value but you are able to predict age range pass number in the middle of predicted range.
Property `gender` is a string literal which should contain `male` of `female`.
Additionally set of keywords may be added in order to let us know something more about user of your app. You can manipulate keywords by calling methods `-(void)addKeyword:(NSString*)keyword` and `-(void)removeKeyword:(NSString*)keyword`. If profile is reseted collection of keywords becomes empty.

```objective-c
COLORUserProfile *profile = [COLORUserProfile sharedProfile];

[profile reset]; //reset current profile if user is switched in your application.

profile.age = 30;
profile.gender = @"female"; //male or female are expected here

//keywords which may characterize your audience. They are used to target ads more effectively.
[profile addKeyword:@"aviation"];
[profile addKeyword:@"airplane"];
[profile addKeyword:@"airport"];
```

```Swift
    let profile = COLORUserProfile.sharedProfile()
    profile.reset() //reset current profile if user is switched in your application.
    
    profile.age = 30
    profile.gender = "female" //male or female are expected here
    
    //keywords which may characterize your audience. They are used to target ads more effectively.
    profile.addKeyword("aviation")
    profile.addKeyword("airplane")
    profile.addKeyword("airport")
```

```JavaScript
var userProfile = COLORAdController.sharedAdController().userProfile();

userProfile.reset(); //reset current profile if user is switched in your application.

userProfile.setAge(30);
userProfile.setGender("female"); //male or female are expected here

//keywords which may characterize your audience. They are used to target ads more effectively.
userProfile.addKeyword("aviation");
userProfile.addKeyword("airplane");
userProfile.addKeyword("airport");
```

---

##Earning Virtual Currency

Integrating virtual currency inside of your advertisments greatly increases user interaction as well as monetization for your app. We offer a mechanism to provide users a variety of incentives using your app's virtual currency. Virtual Currency must first be set up in the dashboard for your application and then a few lines of code need to be added to be fully setup.

Ad conversions are monitored by our server and you will be informed when some currency is assigned. It is up to you whether you prefer to get the notification through NSNotificationCenter or use delegate pattern.

####NSNotificationCenter

```objective-c
[[NSNotificationCenter defaultCenter] addObserverForName:COLORAdFrameworkNotificationDidGetCurrency object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
    NSLog(@"userInfo: %@", note);
}];
```

```swift
NSNotificationCenter.defaultCenter().addObserverForName(COLORAdFrameworkNotificationDidGetCurrency, object: nil, queue: nil) { note in
    print("userInfo: \(note.userInfo)")
}
```        

Each time a conversion is registered (usually when application returns to foreground) a notification will be triggered for each conversion. Note is an object of class NSNotification which contains property userInfo of class NSDictionary. It contains some useful information like amount of currency to be assigned or name of the currency.

####Delegate

If you prefer to use delegates please remember to set desired class as compliant to COLORAdControllerDelegate protocol. Then set the delegate.

```objective-c
[COLORAdController sharedAdController].delegate = self;
```

```swift
COLORAdController.sharedAdController().delegate = self
```

Whenever a conversion is registered, the following method is to be called. Details contains the same information as userInfo.

```objective-c
#pragma mark - COLORAdControllerDelegate

-(void)didGetCurrency:(NSDictionary *)details {
    NSLog(@"didGetcurrency delegate method: %@", details);
}
```

```swift
func didGetCurrency(details: [NSObject : AnyObject]!) {
    print("didGetCurrency delegate method: \(details)")
}
```

#####Server response
Server returns key-value encoded dictionary describing assigned currency.

```
{
    currencyAmount = 20;
    currencyType = "Gold Coins";
    placement = AppResume;
    status = true;
    timestamp = "2016-08-26T13:02:38.004Z";
}
```

Currency amount is an unsigned integer. It tells amount of currency assigned.
Currency type is a string. It returns name of the currency as defined on server through developer's dashboard.
Placement - placement describing where ad with registered conversion was shown.
Status - defines that operation is successful.
Timestamp - Date and time designator (ISO-8601 standard) describing when conversionwas registered on server.

####Currency Handler (JavaScript)

```JavaScript
COLORAdController.sharedAdController().currencyHandler = function(details) {
    console.log("::>> currency handler ::<<");
    console.log("::>> currency type: " + details.currencyType);
    console.log("::>> currency amount: " + details.currencyAmount);
    console.log("::>> placement: " + details.placement);
    console.log("::>> status: " + details.status);
    console.log("::>> timestamp: " + details.timestamp);
};

```

