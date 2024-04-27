
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 500;
local yy = 500;
local xx2 = 500;
local yy2 = 500;
local ofs = 0;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
    makeLuaSprite('backgroundh','gp', -250,0)
    addLuaSprite('backgroundh')

    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'henryDeath')
    setPropertyFromClass('GameOverSubstate', 'characterName', 'henryphone')
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'deathHenryMusicLoop')
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'deathHenryMusicEnd')
end
function onStartCountdown()
    runHaxeCode([[
        game.iconP1.changeIcon('bf');
        game.iconP2.changeIcon('henry');
        game.healthBar.createFilledBar(0xFFbdd7d8, 0xFF31b0d1);
        game.healthBar.updateBar();
    ]])
end
function onEvent(n,v1,v2)
    if n == 'Greatest Plan Icons' then
        if v1 == 'bf' then
            runHaxeCode([[
                game.iconP1.changeIcon('henry');
                game.iconP2.changeIcon('bf');
                game.healthBar.createFilledBar(0xFF31b0d1, 0xFFbdd7d8);
                game.healthBar.updateBar();
            ]])
        elseif v1 == 'charles' then
            callScript('scripts/impostorUI','setHudColor',{'dad'})
            runHaxeCode([[
                game.iconP2.changeIcon('charles');
                game.healthBar.createFilledBar(0xFFff3333, 0xFFbdd7d8);
                game.healthBar.updateBar();
            ]])
        end
    end
    if n == 'Charles Enter' then
        myboicharles = true
    end
end
function onCreatePost()
	runHaxeCode([[
		beef = new Boyfriend(1110, 500, 'bf');
		game.addBehindBF(beef);
		game.variables.set('beef',beef);
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % beef.danceEveryNumBeats == 0 && beef.animation.curAnim != null && !StringTools.startsWith(beef.animation.curAnim.name, 'sing') && !beef.stunned)
		{
			beef.dance();
		}
	]]);
end


function onUpdate(elapsed)
    if myboicharles then
        setProperty('dad.x', lerp(getProperty('dad.x'),-600,boundTo(elapsed * 2.1,0,1)))
    end
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('mom.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('mom.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('mom.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('mom.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' or getProperty('mom.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('mom.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' or getProperty('mom.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' or getProperty('mom.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
        else
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end

    if curStep >= 32 then
        setProperty('defaultCamZoom',1.3)
        xx = 130
        xx2 = 130
        yy = 450;
        yy2 = 450;
    end
    if curStep == 40 then
        triggerEvent('Greatest Plan Icons', 'bf')
    end
    if curStep == 41 then
        triggerEvent('Greatest Plan Icons', 'charles')
    end
    if curStep == 45 then
        triggerEvent('Charles Enter')
    end
end


function lerp(a, b, t)
    return (1-t)*a + t*b
end

function boundTo(val, min, max)
    if val < min then
        return min
    elseif val > max then
        return max
    else
        return val
    end
end