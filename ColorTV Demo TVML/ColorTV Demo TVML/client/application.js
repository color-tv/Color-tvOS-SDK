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

function updateProfileInfo() {
    var userProfile = COLORAdController.sharedAdController().userProfile();
    userProfile.reset();
    userProfile.setAge(30);
    userProfile.setGender("female");
    userProfile.addKeyword("aviation");
    userProfile.addKeyword("airplane");
    userProfile.addKeyword("airport");
}

function configureAdController() {
    COLORAdController.sharedAdController().startWithAppIdentifier("08271056-5211-4ae6-bf1c-12e344455383");
    COLORAdController.sharedAdController().setCurrentPlacement("AppLaunch");
    COLORAdController.sharedAdController().currencyHandler = function(details) {
        console.log("::>> currency handler ::<<");
        console.log("::>> currency type: " + details.currencyType);
        console.log("::>> currency amount: " + details.currencyAmount);
        console.log("::>> placement: " + details.placement);
        console.log("::>> status: " + details.status);
        console.log("::>> timestamp: " + details.timestamp);
    };
    COLORAdController.sharedAdController().registerThirdPartyUserIdWithCompletionHandler("jj@colortv.com", function(success) {
        if(success) {
           console.log("Third party user id registered.");
        } else {
           console.log("Third party user id failure.");
        }
    });

}

function getDoc(options) {
    var resource = Template.call(this, options);
    var parser = new DOMParser();
    var doc = parser.parseFromString(resource, "application/xml");
    return doc;
}

function configureElements(doc) {
    var elements = doc.getElementsByTagName("menuItem");
    console.log("::>> ELEMENTS: " + elements);
    for(var i = 0; i < elements.length - 1; i++) {
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
            COLORAdController.sharedAdController().prepareAdForPlacementWithCompletionAndExpirationHandler(placement, function(success) {
                if(success) {
                console.log("AD prepared");
                COLORAdController.sharedAdController().showLastAdWithCompletionHandler(function(watched) {
                    console.log("AD completed " + watched);                                                                                                                  });
                } else {
                    console.log("AD NOT prepared");
                }
            }, function() {
                    console.log("AD expired");
            });
        }, null);
    }
    elements.item(elements.length - 1).addEventListener("select", function(event) {console.log("Show content recommendation now!")}, null);
}

App.onLaunch = function(options) {

    evaluateScripts([`${options.BASEURL}templates/hello-world.xml.js`], function(success) {
        if(!success) {
            console.log('Error loading hello-world.xml.js');
            return;
        }
        configureAdController();
        updateProfileInfo();
        var doc = getDoc(options);
        configureElements(doc);
        navigationDocument.pushDocument(doc);
        });
}

App.onExit = function() {
    console.log('App finished');
}
