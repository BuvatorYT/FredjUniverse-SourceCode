-- thanks to @sir_top_hat for the script

local healthTweenin = false
function onEvent(tag, v1, v2)
	if tag == 'Health Tween' then
		healthTweenin = true
		setProperty('healthTweenObjThingy.x', getProperty('health'))
		doTweenX('healfTween', 'healthTweenObjThingy', tonumber(v1), tonumber(v2), 'cubeOut')
	end
end

function onUpdatePost()
	if healthTweenin then
		setProperty('health', getProperty('healthTweenObjThingy.x'))
	end
end

function onTweenCompleted(tag)
	if tag == 'healfTween' then
		healthTweenin = false
	end
end

function onCreatePost()
	makeLuaSprite('healthTweenObjThingy', 'icons/icon-bf', 0, 0)
	addLuaSprite('healthTweenObjThingy', true)
	setProperty('healthTweenObjThingy.visible', false)
end