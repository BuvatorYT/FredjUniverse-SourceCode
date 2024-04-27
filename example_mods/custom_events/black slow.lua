function onEvent(name,value1)
if name == 'black slow' then
if value1 == 'si' then
doTweenAlpha('hud3', 'camGame', 0, 1.5, 'linear')
end    
if value1 == 'no' then
doTweenAlpha('hud4', 'camGame', 1, 1.5, 'linear')
end
end 
end