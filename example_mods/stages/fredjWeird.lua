function onCreate()
    makeAnimatedLuaSprite("fon","weird/bg",0,0);
    addLuaSprite("fon",false);
    addAnimationByPrefix('fon', 'bg', 'bg idle', 30, false)
end

function onBeatHit()
    if curBeat %2 == 0 then
        objectPlayAnimation('fon', 'bg')
    end
end