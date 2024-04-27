function onCreate()
	makeLuaSprite('sky', 'grif-home/sky', -600, -750)
	makeLuaSprite('forest', 'grif-home/forest', -600 , 150)
	makeLuaSprite('grass', 'grif-home/grass', -650, 250)
        makeLuaSprite('home', 'grif-home/home', 500, -1100)

	setScrollFactor('sky', 0.6, 1)

	addLuaSprite('sky', false)
	addLuaSprite('forest', false)
	addLuaSprite('grass', false)
        addLuaSprite('home', false)
	--Animated
	makeAnimatedLuaSprite('fredjUUU', 'grif-home/fredjUUU', 1100, 300)
        makeAnimatedLuaSprite('3prydurka', 'grif-home/3prydurka', 575, 300)

	addAnimationByPrefix('fredjUUU', 'fredjUUU', 'fredjUUU', 24, false)
        addAnimationByPrefix('3prydurka', '3prydurka', 'dance', 24, false)

	addLuaSprite('fredjUUU', true)
        addLuaSprite('3prydurka', false)
end

function onBeatHit()
	if curBeat %1 == 0 then
		objectPlayAnimation('fredjUUU', 'fredjUUU')
                objectPlayAnimation('3prydurka', '3prydurka')
	end
end