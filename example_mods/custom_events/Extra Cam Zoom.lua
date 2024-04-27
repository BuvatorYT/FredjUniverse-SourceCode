function onSongStart()
    ogCam = getProperty('defaultCamZoom')
    return Function_Continue
end
function onEvent(n,v1,v2)
    if n == "Extra Cam Zoom" then
        extraZoom = tonumber(value1) or 0
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - oldExtra + extraZoom)
    end
end
