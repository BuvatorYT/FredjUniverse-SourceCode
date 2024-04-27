function onCreate()
	makeLuaSprite('credits', 'creditSong/Trap', 0, 0);
	setObjectCamera('credits','camHUD')
	addLuaSprite('credits', true);
end
function onStartCountdown()
	doTweenAlpha('gone', 'credits', 0, 0.000000001, 'cubeIn')
	doTweenAlpha('gone', 'camHUD', 0, 0.0000001, 'cubeIn')
end

function onStepHit()
	if curStep == 130 then
		doTweenAlpha('gone', 'camHUD', 1, 0.4, 'cubeIn')
	end
	if curStep == 140 then
		doTweenAlpha('gone', 'credits', 1, 0.4, 'cubeIn')
	end
	if curStep == 174 then
		doTweenAlpha('gone', 'credits', 0, 0.4, 'cubeIn')
	end
end