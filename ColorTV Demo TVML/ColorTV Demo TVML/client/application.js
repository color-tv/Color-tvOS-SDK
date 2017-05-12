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
        logger.log("::>> currency handler ::<<");
        logger.log("::>> currency type: " + details.currencyType);
        logger.log("::>> currency amount: " + details.currencyAmount);
        logger.log("::>> placement: " + details.placement);
        logger.log("::>> status: " + details.status);
        logger.log("::>> timestamp: " + details.timestamp);
    };
    COLORAdController.sharedAdController().registerThirdPartyUserIdWithCompletionHandler("jj@colortv.com", function(success) {
        if(success) {
           logger.log("Third party user id registered.");
        } else {
           logger.log("Third party user id failure.");
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
    logger.log("::>> ELEMENTS: " + elements);
    for(var i = 0; i < elements.length - 1; i++) {
        var titleNode = elements.item(i).getElementsByTagName("title").item(0);
        logger.log("::>> TITLE: " + titleNode.nodeType);
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
            logger.log(event + " " + placement);
            COLORAdController.sharedAdController().prepareAdForPlacementWithCompletionAndExpirationHandler(placement, function(success) {
                if(success) {
                logger.log("AD prepared");
                COLORAdController.sharedAdController().showLastAdWithCompletionHandler(function(watched) {
                    logger.log("AD completed " + watched);                                                                                                                  });
                } else {
                    logger.log("AD NOT prepared");
                }
            }, function() {
                    logger.log("AD expired");
            });
        }, null);
    }
    elements.item(elements.length - 1).addEventListener("select", function(event) {
        logger.log("Show content recommendation now!");
        playMedia("https://s3.amazonaws.com/colortv-testapp-data/0017.mp4", "video");
    }, null);
}

function playMedia(videoURL, mediaType) {
    var singleVideo = new MediaItem(mediaType, videoURL);
    var videoList = new Playlist();
    videoList.push(singleVideo);
    var myPlayer = new Player();
    myPlayer.playlist = videoList;
    myPlayer.play();
    COLORAdController.sharedAdController().prepareRecommendationControllerForPlacementAndVideoIdWithCompletion("VideoStart", "0017", function(error) {
        if (error) {
            logger.log("Error while fetching recommendation for curent video");
        }
    })
    myPlayer.addEventListener("stateDidChange", function(event) {
        logger.log("stateDidChange from: " + event.oldState + " to: " + event.state);
        if ((event.state == "paused" && event.oldState != "loading") || event.state == "end") {
            showRecommendationsForPlayer(myPlayer);
        }
    });
}

function showRecommendationsForPlayer(myPlayer) {
    COLORAdController.sharedAdController().showLastRecommendationWithCompletionHandler(function(newVideoId, newVideoURL) {
        if (!newVideoURL) {
            return;
        }
        logger.log("newVideo: " + newVideoURL);
        //Setting timeout here is like doing dispach_async on main thread. Without this it would probably crash.
        setTimeout(playNewVideo, 0, newVideoId, newVideoURL, myPlayer);
    });
}

function playNewVideo(newVideoId, newVideoURL, myPlayer) {
    myPlayer.stop();
    logger.log("playNewVideo");
    //This implementation closes current video and then open new one. But actually it can be played using current player or added to playlist.
    playMedia(newVideoURL, "video");
}

App.onLaunch = function(options) {

    evaluateScripts([`${options.BASEURL}templates/hello-world.xml.js`], function(success) {
        if(!success) {
            logger.log('Error loading hello-world.xml.js');
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
    logger.log('App finished');
}
