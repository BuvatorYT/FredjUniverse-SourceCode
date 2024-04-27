function onCreate()
    setProperty('camHUD.alpha', 0)
        makeLuaSprite('fade', 'Black', -1000, -400)
       scaleObject('fade', 3, 3)
    addLuaSprite('fade', true)
    setProperty('fade.alpha', 0)
end

function onStepHit()
    if curStep == 16 then
        setProperty('camGame.alpha', 0)
        setProperty('camHUD.alpha', 0)
    end
    if curStep == 25 then
        cameraFlash('game', '000000', 1, 1)
        setProperty('camGame.alpha', 1)
        doTweenAlpha('alpha', 'camHUD', 1, 3, 'expoInOut')
    end
    if curStep == 527 then
        doTweenAlpha('alpha', 'fade', 0.7, 0.5, 'expoInOut')
    end
    if curStep == 534 then
        doTweenAlpha('alpha', 'fade', 0, 5, 'expoInOut')
    end
    if curStep == 786 then
        doTweenAlpha('alpha', 'camHUD', 0, 0.8, 'expoInOut')
    end
    if curStep == 848 then
        doTweenAlpha('alpha', 'camHUD', 1, 1, 'expoInOut')
    end
    if curStep == 1090 then
        doTweenAlpha('alpha', 'fade', 0.7, 1, 'expoInOut')
    end
    if curStep == 1104 then
        doTweenAlpha('alpha', 'fade', 0, 0.1, 'expoInOut')
    end
    if curStep == 1360 then
        doTweenAlpha('alpha', 'camGame', 0, 1, 'expoInOut')
    end
end


