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

                    var resource = Template.call(this, options);
                    var parser = new DOMParser();
                    var doc = parser.parseFromString(resource, "application/xml");
                    var elements = doc.getElementsByTagName("menuItem");
                    console.log("::>> ELEMENTS: " + elements);

                    for(var i = 0; i < elements.length; i++) {
                    console.log("::>> ELEMENT: " + elements.item(i));
                        elements.item(i).addEventListener("select", function(event) {
                            console.log(event);
                        }, null);
                    }
                    
                    navigationDocument.pushDocument(doc);
                    });
}

App.onExit = function() {
    console.log('App finished');
}
