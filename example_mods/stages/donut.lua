function onCreate()

	makeAnimatedLuaSprite('stage', 'bulishnik/bg', -300, -200)
	addAnimationByPrefix('stage', 'idle', 'bg', 24, true);
	addLuaSprite('stage', false)
end

function onbeatHit()
    if curBeat %2 == 0 then
        objectPlayanimation('stage', 'bg')
end
end