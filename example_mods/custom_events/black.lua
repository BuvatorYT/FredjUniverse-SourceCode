function onEvent(name,value1)
if name == 'black' then
if value1 == 'si' then
doTweenAlpha('hud3', 'camGame', 0, 0.1, 'linear')
end    
if value1 == 'no' then
doTweenAlpha('hud4', 'camGame', 1, 0.1, 'linear')
end
end 
end