function onCreate()

	makeLuaSprite('fon', 'ddto/DDLC-1')

	addLuaSprite('fon')

        --Animated
	makeAnimatedLuaSprite('fakell', 'ddto/fakell')

	addAnimationByPrefix('fakell', 'fakell', 'fakell', 24, false)

	addLuaSprite('fakell')
end

function onBeatHit()
	if curBeat %1 == 0 then
		objectPlayAnimation('fakell', 'fakell')
	end
end