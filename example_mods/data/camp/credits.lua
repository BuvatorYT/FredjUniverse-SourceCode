function onCreate()
	makeLuaSprite('credits', 'creditSong/Camp', 0, 0);

	setObjectCamera('credits','camHUD')
	addLuaSprite('credits', true);
end
function onStartCountdown()
	doTweenAlpha('gone', 'credits', 0, 0.000000001, 'cubeIn')
end

function onStepHit()
	if curStep == 272 then
		doTweenAlpha('gone', 'credits', 1, 0.4, 'cubeIn')
	end
	if curStep == 292 then
		doTweenAlpha('gone', 'credits', 0, 0.4, 'cubeIn')
	end
end