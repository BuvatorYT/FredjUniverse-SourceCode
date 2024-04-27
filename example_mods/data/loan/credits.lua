function onCreate()
	makeLuaSprite('credits', 'creditSong/Loan', 0, 0);

	setObjectCamera('credits','camHUD')
	addLuaSprite('credits', true);
end
function onStartCountdown()
	doTweenAlpha('gone', 'credits', 0, 0.000000001, 'cubeIn')
end

function onStepHit()
	if curStep == 5 then
		doTweenAlpha('gone', 'credits', 1, 0.4, 'cubeIn')
	end
	if curStep == 45 then
		doTweenAlpha('gone', 'credits', 0, 0.4, 'cubeIn')
	end
end