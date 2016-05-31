function getDocument(url) {
    var templateXHR = new XMLHttpRequest();
    templateXHR.responseType = "document";
    templateXHR.addEventListener("load", function() {pushDoc(templateXHR.responseXML);}, false);
    templateXHR.open("GET", url, true);
    templateXHR.send();
    return templateXHR;
}

function pushDoc(document) {
    navigationDocument.pushDocument(document);
}

App.onLaunch = function(options) {

    evaluateScripts([`${options.BASEURL}templates/hello-world.xml.js`], function(success) {
                    if(!success) {
                        console.log('Error loading hello-world.xml.js');
                        return;
                    }
                    
                    var adController = COLORAdController.sharedAdController();
                    adController.startWithAppIdentifier("566dbd1a326aeb750132fdfb");
                    adController.setCurrentPlacement("AppLaunch");

                    
                    var userProfile = adController.userProfile();
                    console.log("::>> shared profile: " + userProfile);
                    adController.userProfile().reset();
                    adController.userProfile().setAge(30);
                    adController.userProfile().setGender("female");
                    adController.userProfile().addKeyword("aviation");
                    adController.userProfile().addKeyword("airplane");
                    adController.userProfile().addKeyword("airport");

                    adController.currencyHandler = function(details) {
                        console.log("::>> currency handler ::<<");
                        console.log("::>> currency type: " + details.currencyType);
                        console.log("::>> currency amount: " + details.currencyAmount);
                        console.log("::>> placement: " + details.placement);
                        console.log("::>> status: " + details.status);
                        console.log("::>> timestamp: " + details.timestamp);
                    };

                    adController.registerThirdPartyUserIdWithCompletionHandler("jj@colortv.com", function(success) {
                                                         if(success) {
                                                            console.log("Third party user id registered.");
                                                         } else {
                                                            console.log("Third party user id failure.");
                                                         }
                                                                                           });

                    var resource = Template.call(this, options);
                    var parser = new DOMParser();
                    var doc = parser.parseFromString(resource, "application/xml");
                    var elements = doc.getElementsByTagName("menuItem");
                    console.log("::>> ELEMENTS: " + elements);

                    for(var i = 0; i < elements.length; i++) {
                        var titleNode = elements.item(i).getElementsByTagName("title").item(0);
                        console.log("::>> TITLE: " + titleNode.nodeType);
                    
                    
                    switch(i) {
                    case 0:
                        var placement = "MainMenu";
                    break;
                    case 1:
                        var placement = "StageFailed";
                    break;
                    case 2:
                        var placement = "StageOpen";
                    break;
                    case 3:
                        var placement = "LevelUp";
                    break;
                    case 4:
                        var placement = "AbandonInAppPurchase";
                    break;
                    
                    }
                    
                        elements.item(i).addEventListener("select", function(event) {
                            console.log(event + " " + placement);
                                                          
                                                          adController.prepareAdForPlacementWithCompletionAndExpirationHandler(placement, function(success){
                                                                                                          if(success) {
                                                                                                          console.log("AD prepared");
                                                                                                          adController.showLastAd();
                                                                                                          } else {
                                                                                                          console.log("AD NOT prepared");
                                                                                                          }
                                                                                                          }, function() {
                                                                                                                console.log("AD expired");
                                                                                                          });
                                                          
                        }, null);
                    
                    }

                    navigationDocument.pushDocument(doc);
                    });
}

App.onExit = function() {
    console.log('App finished');
}
