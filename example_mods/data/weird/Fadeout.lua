-- fade out
function onCreatePost()
	-- end of "create"
	
	makeLuaSprite('fade', 'Black', -1000, -400)
	   scaleObject('fade', 3, 3)
	addLuaSprite('fade', true)
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenAlpha('fadeout', 'fade', 0, 8, 'linear')
end

function onStepHit()
	if curStep == 1408 then
		doTweenAlpha('fadeout', 'fade', 1, 12, 'linear')
	end
	if curStep == 1474 then
		doTweenAlpha('gone', 'camHUD', 0, 0.4, 'cubeIn')
	end
end