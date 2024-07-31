function onCreate()
    makeLuaSprite('TopBar', nil, 0, -350)
	makeGraphic('TopBar', 1280, 350, '000000')
	setObjectCamera('TopBar', 'camHUD')
	addLuaSprite('TopBar', true)

    makeLuaSprite('BottomBar', nil, 0, 720)
	makeGraphic('BottomBar', 1280, 350, '000000')
	setObjectCamera('BottomBar', 'camHUD')
	addLuaSprite('BottomBar', true)

    TopY = getProperty('TopBar.y')
	BotY = getProperty('BottomBar.y')
    runHaxeCode([[
        FlxG.cameras.remove(game.camOther,false);
        FlxG.cameras.remove(game.camHUD,false);
        var camBAR = new FlxCamera();
        camBAR.bgColor = 0x00;
        setVar('camBAR',camBAR);
        game.getLuaObject('TopBar').camera = camBAR;
        game.getLuaObject('BottomBar').camera = camBAR;
        FlxG.cameras.add(camBAR,false);
        FlxG.cameras.add(game.camHUD,false);
        FlxG.cameras.add(game.camOther,false);
    ]])
end

function onStepHit()
    if curStep == 0 then
        function onUpdate()
            doTweenY('TopBar', 'TopBar', TopY + 15 * 2, 0.0001, 'quintOut');
            doTweenY('BottomBar', 'BottomBar', BotY - 15 * 2, 0.0001, 'quintOut');
        end
    end
    if curStep == 130 then
        function onUpdate()
            doTweenY('TopBar', 'TopBar', TopY + 0 * 2, 0.8, 'quintOut');
            doTweenY('BottomBar', 'BottomBar', BotY - 0 * 2, 0.8, 'quintOut');
        end
    end
end