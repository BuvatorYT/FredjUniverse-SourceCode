function onCreate()
	makeLuaSprite('1', 'wfstage2', 100, -100);
	scaleObject('1', 0.4, 0.4);
	makeLuaSprite('2', 'yoffstage', 0, 350);
	scaleObject('2', 0.6, 0.6);


	setProperty('1.visible', true)
	setProperty('2.visible', false)

	addLuaSprite('1', false);
	addLuaSprite('2', false)
end

function onEvent(name,value1,value2)
	if name == 'Play Animation' then
		if value1 == '0' then
			setProperty('1.visible', true)
			setProperty('2.visible', false)
end
    if value1 == '1' then
    	setProperty('1.visible', false)
    	setProperty('2.visible', true)
end
end
end
