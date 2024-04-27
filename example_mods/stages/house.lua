function onCreate()

	makeLuaSprite('fon', 'bulishnik/bulishnik', -200, -100);

	addLuaSprite('fon', false);
	--Animated
	makeAnimatedLuaSprite('y4enuk', 'bulishnik/y4enuk', -100, 220);

	addAnimationByPrefix('y4enuk', 'i', 'idle', 30, false);

	addLuaSprite('y4enuk');
end

function onBeatHit()
	if curBeat %2 == 0 then
		objectPlayAnimation('y4enuk', 'i');
		objectPlayAnimation('fredj', 'a');
	end
end