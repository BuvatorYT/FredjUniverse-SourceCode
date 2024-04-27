function onCreate()
	makeLuaSprite('fon', 'camp/betrayal', 0, 0)
	makeLuaSprite('fon2', 'camp/76-old', 0, 0)
	makeLuaSprite('fon3', 'camp/betrayal2', 0, 0)

	addLuaSprite('fon', false)
	addLuaSprite('fon2', false)
	addLuaSprite('fon3', false)

	setProperty('fon.visible', true)
	setProperty('fon2.visible', false)
	setProperty('fon3.visible', false)
end

function onStepHit()
	if curStep == 896 then
		setProperty('fon.visible', false)
		setProperty('fon2.visible', true)
	end
	if curStep == 1024 then
	    setProperty('fon2.visible', false)
	    setProperty('fon3.visible', true)
	end
	if curStep == 1 then
        -- !your note 1
        noteTweenX("x5", 4, 410, 0.6, "quartInOut");
        noteTweenAngle("r5", 4, 360, 0.6, "quartInOut");
        noteTweenAlpha("o5", 4, 1, 0.6,"quartInOut");
        -- !your note 2
        noteTweenX("x6", 5, 522, 0.6, "quartInOut");
        noteTweenAngle("r6", 5, 360, 0.6, "quartInOut");
        noteTweenAlpha("o6", 5, 1, 0.6, "quartInOut");
        -- !your note 3
        noteTweenX("x7", 6, 633, 0.6, "quartInOut");
        noteTweenAngle("r7", 6, 360, 0.6, "quartInOut");
        noteTweenAlpha("o7", 6, 1, 0.6, "quartInOut");
        -- !your note 4
        noteTweenX("x8", 7, 745, 0.6, "quartInOut");
        noteTweenAngle("r8", 7, 360, 0.6, "quartInOut");
        noteTweenAlpha("o8", 7, 1, 0.6, "quartInOut");
        noteTweenAlpha('outtaHere1Tween', 0, 0, 0.4, 'linear')
        noteTweenAlpha('outtaHere2Tween', 1, 0, 0.4, 'linear')
        noteTweenAlpha('outtaHere3Tween', 2, 0, 0.4, 'linear')
        noteTweenAlpha('outtaHere4Tween', 3, 0, 0.4, 'linear')
    end
end