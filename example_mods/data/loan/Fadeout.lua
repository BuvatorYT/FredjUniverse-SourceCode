-- fade out
function onCreatePost()
	-- end of "create"
	
	makeLuaSprite('fade', 'Black', -1000, -400)
	   scaleObject('fade', 3, 3)
	addLuaSprite('fade', true)
	setProperty('fade.visible', false)
end

function onStepHit()
	if curStep == 1536 then
		setProperty('fade.visible', true)
	end
end

