function onCreate()
    makeLuaSprite('fon', 'PVbg', 0, 0);
    addLuaSprite('fon', false);

    makeAnimatedLuaSprite('ParticleFon', 'PVfireP', 0, 0);
    addLuaSprite('ParticleFon', false);
    addAnimationByPrefix('ParticleFon', 'p', 'p idle', 24, true);


    makeAnimatedLuaSprite("fonAnim","RunBG",0,0);
    addLuaSprite("fonAnim",false);
    addAnimationByPrefix('fonAnim', 'bg', 'bg idle', 24, true)
end

function onStepHit()
    if curStep == 256 then
        setProperty('fonAnim.visible', false)
    end
end