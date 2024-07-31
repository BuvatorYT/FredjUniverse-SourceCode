function onCreate()
	makeLuaSprite('bar','songToast',1020, -500)
    makeLuaSprite('creditText', 'creditSongtext/Runaway', 1020, -500)

    scaleObject('bar', 1.5, 1.5)
    scaleObject('creditText', 1.5, 1.5)

    addLuaSprite('bar', false)
    addLuaSprite('creditText', false)

    setObjectCamera('bar','camHUD')
    setObjectCamera('creditText','camHUD')
end

function onStepHit()
	if curStep == 110 then
		doTweenY('in','bar',0,0.5,'sineOut')
		doTweenY('out', 'creditText', 0, 0.5, 'sineOut')
	end
	if curStep == 145 then
		doTweenY('in','bar',-500,1,'sineIn')
		doTweenY('out','creditText',-500,1,'sineIn')
	end
end