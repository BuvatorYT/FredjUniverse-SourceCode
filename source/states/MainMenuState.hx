package states;

import backend.WeekData;
import backend.Achievements;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;

import flixel.input.keyboard.FlxKey;
import lime.app.Application;

import objects.AchievementPopup;
import states.editors.MasterEditorMenu;
import options.OptionsState;

import flixel.util.FlxGradient;

class MainMenuState extends MusicBeatState
{

    public static var psychEngineVersion:String = '0.7.3';
    public static var curSelected:Int = 0;

    var menuItems:FlxTypedGroup<FlxSprite>;
    private var camGame:FlxCamera;
    private var camAchievement:FlxCamera;

	var transGradient:FlxSprite;
   
    var optionShit:Array<String> = [
        'freeplay',
        'options',
        'credits'
    ];

    var camFollow:FlxObject;

    override function create()
    {
        #if MODS_ALLOWED
        Mods.pushGlobalMods();
        #end
        Mods.loadTopMod();

        #if desktop
        // Updating Discord Rich Presence
        DiscordClient.changePresence("In the Menus", null);
        #end

        camGame = new FlxCamera();
        camAchievement = new FlxCamera();
        camAchievement.bgColor.alpha = 0;

        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;

        persistentUpdate = persistentDraw = true;

        var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);

		var bg:FlxSprite = new FlxSprite();
		bg.antialiasing = ClientPrefs.data.antialiasing;

		bg.loadGraphic(Paths.image('MainMenu/BG'));

		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();
		add(bg);

		transGradient = FlxGradient.createGradientFlxSprite(800, 1000, ([0x0, FlxColor.BLACK, FlxColor.BLACK, 0x0]));
		transGradient.updateHitbox();
		transGradient.x += 670;
		transGradient.screenCenter(Y);
		add(transGradient);
		
		var line1:FlxSprite = new FlxSprite();
		line1.antialiasing = ClientPrefs.data.antialiasing;
		line1.makeGraphic(1500, 100, FlxColor.BLACK);
		line1.y -= 50;
		line1.x -= 200;
		line1.angle = 2.7;
		
		var line2:FlxSprite = new FlxSprite();
		line2.antialiasing = ClientPrefs.data.antialiasing;
		line2.makeGraphic(1500, 200, FlxColor.BLACK);
		line2.y += 670;
		line2.x -= 200;
		line2.angle = 2.7;

        menuItems = new FlxTypedGroup<FlxSprite>();
        add(menuItems);

        var scale:Float = 1;

        // UI CODE!
        
        for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(30 + (10 * i), 50);
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			FlxTween.tween(menuItem, {y: 30}, 1.2, {ease: FlxEase.quartInOut, type: FlxTween.PINGPONG});
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.scale.set(0.8, 0.8);
			menuItem.updateHitbox();

			switch(i)
		    {
				case 0:
					menuItem.x = 840;
					menuItem.y = 140;
					menuItem.updateHitbox();

				case 1:
					menuItem.x = 840; // 775
					menuItem.y = 320;
					menuItem.updateHitbox();

				case 2:
					menuItem.x = 840; // 750
					menuItem.y = 500;
					menuItem.updateHitbox();

				default:
					menuItem.screenCenter();
			}
		}

		// Lines

		add(line1);
		add(line2);

        // Version Information

        var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);

        var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);  
        changeItem();
    }  

    var selectedSomethin:Bool = false;

    override function update(elapsed:Float)
    {
        if (FlxG.sound.music.volume < 0.8)
        {
            FlxG.sound.music.volume += 0.5 * elapsed;
            if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
        }
        FlxG.camera.followLerp = FlxMath.bound(elapsed * 9 / (FlxG.updateFramerate / 60), 0, 1);

        if (!selectedSomethin)
        {
            if (controls.UI_UP_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.random.int(1, 3);
                changeItem(-1);
            }

            if (controls.UI_DOWN_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
				FlxG.random.int(1, 3);
                changeItem(1);
            }

            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new TitleState());
            }

            if (controls.ACCEPT)
            {
                if (optionShit[curSelected] == 'donate')
                {
                    CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
                }
                else
                {
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound('confirmMenu'));

                    menuItems.forEach(function(spr:FlxSprite)
                    {
                        if (curSelected != spr.ID)
                        {
                            FlxTween.tween(spr, {alpha: 0}, 0.4, {
                                ease: FlxEase.quadOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    spr.kill();
                                }
                            });
                        }
                        else
                        {
                            FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                            {
                                var daChoice:String = optionShit[curSelected];

                                switch (daChoice)
                                {
                                    case 'story_mode':
                                        LoadingState.loadAndSwitchState(new StoryMenuState());
                                    case 'freeplay':
                                        LoadingState.loadAndSwitchState(new FreeplayState());
                                    case 'credits':
                                        LoadingState.loadAndSwitchState(new CreditsState());
                                    case 'options':
                                        LoadingState.loadAndSwitchState(new OptionsState());
                                        OptionsState.onPlayState = false;
                                        if (PlayState.SONG != null)
                                        {
                                            PlayState.SONG.arrowSkin = null;
                                            PlayState.SONG.splashSkin = null;
                                        }
                                }
                            });
                        }
                    });
                }
            }
            #if desktop
            else if (controls.justPressed('debug_1'))
            {
                selectedSomethin = true;
                MusicBeatState.switchState(new MasterEditorMenu());
            }
            #end
        }

        super.update(elapsed);

        menuItems.forEach(function(spr:FlxSprite)
        {
            // spr.screenCenter(X);
        });
    }

    function changeItem(huh:Int = 0)
    {
        curSelected += huh;

        if (curSelected >= menuItems.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = menuItems.length - 1;

        menuItems.forEach(function(spr:FlxSprite)
        {
            spr.animation.play('idle');
            spr.updateHitbox();

            if (spr.ID == curSelected)
            {
                spr.animation.play('selected');
                var add:Float = 0;
                if(menuItems.length > 4) {
                    add = menuItems.length * 8;
                }
                spr.centerOffsets();
            }
        });
    }
}
