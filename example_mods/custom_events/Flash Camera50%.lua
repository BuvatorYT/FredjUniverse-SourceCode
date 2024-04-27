function onEvent(n,v1,v2)


	if n == 'Flash Camera50%' then

	   makeLuaSprite('flash2', '', 0, 0);
        makeGraphic('flash2',1280,720,'ffffff')
	      addLuaSprite('flash2', true);
	      setLuaSpriteScrollFactor('flash2',0,0)
	      setProperty('flash2.scale.x',2)
	      setProperty('flash2.scale.y',2)
	      setProperty('flash2.alpha',0.3)
		setProperty('flash2.alpha',1)
		doTweenAlpha('flTw','flash2',0,v1,'linear')
	end



end