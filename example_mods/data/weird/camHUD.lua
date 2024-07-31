function onStartCountdown()
	doTweenAlpha('gone', 'credits', 0, 0.000000001, 'cubeIn')
    setProperty('camHUD.alpha', 0)
end

function onStepHit()
	if curStep == 53 then
		doTweenAlpha('alpha', 'camHUD', 1, 1, 'expoInOut')
	end
end