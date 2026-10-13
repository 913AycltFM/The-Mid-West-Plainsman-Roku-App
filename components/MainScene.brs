sub init()
    m.menu = m.top.findNode("menu")
    m.status = m.top.findNode("status")
    m.video = m.top.findNode("video")
    m.infoHeading = m.top.findNode("infoHeading")
    m.infoText = m.top.findNode("infoText")

    menuContent = CreateObject("roSGNode", "ContentNode")
    for each item in ["Live TV", "Latest Videos", "Local News", "About Us"]
        row = menuContent.createChild("ContentNode")
        row.title = item
    end for
    m.menu.content = menuContent
    m.menu.observeField("itemSelected", "onMenuSelected")
    m.menu.setFocus(true)

    m.video.observeField("state", "onVideoStateChanged")
end sub

sub onMenuSelected()
    selected = m.menu.itemSelected
    if selected = invalid then return

    if selected = 0 then
        playLiveTV()
    else if selected = 1 then
        showInfo("Latest Videos", "The video section is ready for a video feed. Add your public video or playlist feed to populate this section.")
    else if selected = 2 then
        showInfo("Local News", "The local news section is ready for a news feed. Add your published news feed to display current stories.")
    else if selected = 3 then
        showInfo("About The Mid West Plainsman", "The Mid West Plainsman is an independent media outlet covering Waterloo, the Cedar Valley Corridor, and Central Iowa.")
    end if
end sub

sub playLiveTV()
    m.infoHeading.text = "Live TV"
    m.infoText.text = "Connecting to The Mid West Plainsman TV live stream..."
    m.status.text = "Press BACK to return to the menu."
    m.video.visible = true
    m.video.setFocus(true)

    content = CreateObject("roSGNode", "ContentNode")
    content.url = "https://tv.913aycltfm.com/memfs/552ab1b0-d31a-4a5f-a9d7-d58a280deba2.m3u8"
    content.streamFormat = "hls"
    m.video.content = content
    m.video.control = "play"
end sub

sub showInfo(heading as String, body as String)
    m.video.control = "stop"
    m.video.visible = false
    m.infoHeading.text = heading
    m.infoText.text = body
    m.status.text = "Press OK on a menu item to continue."
    m.menu.setFocus(true)
end sub

sub onVideoStateChanged()
    state = m.video.state
    if state = "error" then
        m.status.text = "The live stream could not play. Check that the HLS URL is active and reachable by Roku."
        m.video.visible = false
        m.menu.setFocus(true)
    else if state = "playing" then
        m.status.text = "Live stream playing. Press BACK to return to the menu."
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false

    if key = "back" and m.video.visible then
        m.video.control = "stop"
        m.video.visible = false
        m.menu.setFocus(true)
        m.status.text = "Choose an option and press OK."
        return true
    end if

    return false
end function
