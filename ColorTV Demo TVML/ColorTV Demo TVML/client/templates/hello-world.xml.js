var Template = function(obj) { console.log(obj); return `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
        <mainTemplate>
            <title>ColorTV Demo TVML</title>
            <description>This is ColorTV demo app.</description>
            <background>
                <img src="${obj.BASEURL}templates/demo-app-bg.png" />
            </background>
            <menuBar>
                <section>
                    <menuItem>
                        <title>Discovery Center</title>
                    </menuItem>
                    <menuItem>
                        <title>App Feature</title>
                    </menuItem>
                    <menuItem>
                        <title>Direct Engagement</title>
                    </menuItem>
                    <menuItem>
                        <title>Video</title>
                    </menuItem>
                    <menuItem>
                        <title>Random Ad</title>
                    </menuItem>
                </section>
            </menuBar>
        </mainTemplate>
    </document>`
}