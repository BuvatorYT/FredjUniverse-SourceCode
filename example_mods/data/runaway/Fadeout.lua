-- fade out
function onCreatePost()
	-- end of "create"
	
	makeLuaSprite('fade', 'Blackk', -1000, -400)
	   scaleObject('fade', 3, 3)
	addLuaSprite('fade', true)
	setProperty('camHUD.alpha', 0)
end

function onStepHit()
	if curStep == 92 then
		doTweenAlpha('alpha', 'camHUD', 1, 3, 'expoInOut')
	end
	if curStep == 122 then
		doTweenAlpha('fadeout', 'fade', 0, 1, 'linear')
	end
	if curStep == 248 then
		doTweenAlpha('fadeout', 'fade', 1, 0.0000001, 'linear')
	end
	if curStep == 249 then
		doTweenAlpha('alpha', 'camHUD', 0, 0.5, 'linear')
	end
	if curStep == 264 then
		doTweenAlpha('fadeout', 'fade', 0, 1, 'linear')
	end
	if curStep == 324 then
		doTweenAlpha('alpha', 'camHUD', 1, 1, 'linear')
	end
	if curStep == 1424 then
		doTweenAlpha('fadeout', 'fade', 1, 0.0000001, 'linear')
	end
end