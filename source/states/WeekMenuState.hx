package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import backend.Song;

import states.PlayState;
import states.StoryMenuState;
import states.FreeplayState;

import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

import flixel.effects.FlxFlicker;

class WeekMenuState extends MusicBeatState
{
    var bg:FlxSprite;
    var week1:FlxSprite;
    var week3:FlxSprite;
    var demo:FlxSprite;
    
    var curSelected:Int = 0;

    var shit:Array<String> = ['Week1', 'Week3'];

    var menuItems:FlxTypedGroup<FlxSprite>;

    override function create()
    {
        bg = new FlxSprite(0,0).loadGraphic(Paths.image("other/WeekMenu/bgg"));
        bg.antialiasing = FlxG.save.data.antialiasing;
        add(bg);

        demo = new FlxSprite(0,0).loadGraphic(Paths.image("other/WeekMenu/demo"));
        demo.antialiasing = FlxG.save.data.antialiasing;
        add(demo);

        menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

        var tex = Paths.getSparrowAtlas("other/WeekMenu/items");

        for (i in 0...shit.length)
            {
                var offset:Float = 108 - (Math.max(shit.length, 4) - 4) * 80;
                var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
                menuItem.antialiasing = ClientPrefs.data.antialiasing;
                menuItem.frames = Paths.getSparrowAtlas('other/WeekMenu/items');
                menuItem.animation.addByPrefix('idle', shit[i] + " idle", 24);
                menuItem.animation.addByPrefix('selected', shit[i] + " sel", 24);
                menuItem.animation.play('idle');
                menuItem.ID = i;
                menuItems.add(menuItem);
                var scr:Float = (shit.length - 4) * 0.135;
                if (shit.length < 6)
                    scr = 0;
                menuItem.scrollFactor.set(0, scr);
                menuItem.updateHitbox();
                menuItem.screenCenter(X);
                changeItem();

                switch (i)
                {
                    case 0:
                        menuItem.setPosition(0.0);
                    case 1:
                        menuItem.setPosition(0,0);
                }
            }

        super.create();
    }

    override function update(elapsed:Float)
        {
            if (controls.BACK){
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
            }
            if (controls.UI_LEFT_P)
                changeItem(-1);
            if (controls.UI_RIGHT_P)
                changeItem(1);
            if (controls.ACCEPT)
                startWeek();

            if(FlxG.keys.justPressed.CONTROL){
                persistentUpdate = false;
                openSubState(new GameplayChangersSubstate());
            }
            super.update(elapsed);
        }
        function startWeek():Void {
            // Check if the currently selected menu item is "Week 1"

            FlxG.sound.play(Paths.sound('confirmMenu'));
            FlxG.camera.flash(FlxColor.WHITE, 1);

            FlxFlicker.flicker(menuItems.members[curSelected], 1.5, 0.06, false, false, function(flick:FlxFlicker)
                {

                    if (curSelected == 0) {
                    
                        LoadingState.loadAndSwitchState(new PlayState(), true);
                        PlayState.storyDifficulty = 0;
                        PlayState.storyPlaylist = ['big-business', 'loan', 'trap'];
                        PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-hard', PlayState.storyPlaylist[0].toLowerCase());
                        PlayState.campaignScore = 0;
                        PlayState.campaignMisses = 0;
                        PlayState.isWeekMode = true;
                        FreeplayState.destroyFreeplayVocals();
                    
                    }
                    
                    if (curSelected == 1) {
                    
                        LoadingState.loadAndSwitchState(new PlayState(), true);
                        PlayState.storyDifficulty = 0;
                        PlayState.storyPlaylist = ['weird', 'camp', 'betrayal'];
                        PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + '-normal', PlayState.storyPlaylist[0].toLowerCase());
                        PlayState.campaignScore = 0;
                        PlayState.campaignMisses = 0;
                        PlayState.isWeekMode = true;
                        FreeplayState.destroyFreeplayVocals();
                    
                    }


                });
  
        }
        

        function changeItem(huh:Int = 0)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                menuItems.members[curSelected].animation.play('idle');
                menuItems.members[curSelected].updateHitbox();
                menuItems.members[curSelected].screenCenter(X);
        
                curSelected += huh;
        
                if (curSelected >= menuItems.length)
                    curSelected = 0;
                if (curSelected < 0)
                    curSelected = menuItems.length - 1;
        
                menuItems.members[curSelected].animation.play('selected');
                menuItems.members[curSelected].centerOffsets();
                menuItems.members[curSelected].screenCenter(X);
                //menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
            }
        }