function onCreate()
	makeLuaSprite('credits', 'creditSong/Weird', 0, 0);

	setObjectCamera('credits','camHUD')
	addLuaSprite('credits', true);
end
function onStartCountdown()
	doTweenAlpha('gone', 'credits', 0, 0.000000001, 'cubeIn')
    setProperty('camHUD.alpha', 0)
end

function onStepHit()
	if curStep == 53 then
		doTweenAlpha('alpha', 'camHUD', 1, 1, 'expoInOut')
	end
	if curStep == 128 then
		doTweenAlpha('gone', 'credits', 1, 0.4, 'cubeIn')
	end
	if curStep == 158 then
		doTweenAlpha('gone', 'credits', 0, 0.4, 'cubeIn')
	end
end