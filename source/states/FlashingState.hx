package states;

import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;

import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite();
		bg.antialiasing = ClientPrefs.data.antialiasing;

		bg.loadGraphic(Paths.image('titleBG'));
		add(bg);

		var bggradient:FlxSprite = new FlxSprite();
		bggradient.loadGraphic(Paths.image('other/pause/GradientBG'));
		bggradient.antialiasing = ClientPrefs.data.antialiasing;
		bggradient.alpha = 0.5;
		add(bggradient);

		var bgdots:FlxBackdrop = new FlxBackdrop(Paths.image('other/pause/WhiteDotBg'));
		bgdots.velocity.set(-20, -20);
		bgdots.antialiasing = ClientPrefs.data.antialiasing;
		bgdots.alpha = 0.4;
		add(bgdots);

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

		add(line1);
		add(line2);

		var line3:FlxSprite = new FlxSprite();
		line3.antialiasing = ClientPrefs.data.antialiasing;
		line3.makeGraphic(1500, 450, FlxColor.BLACK);
		line3.alpha = 0.45;
		line3.screenCenter(Y);
		
		add(line3);

		

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out! This Mod contains some flashing lights!
			Press ENTER to disable them now or go to Options Menu.
			Press ESCAPE to ignore this message.
			You've been warned!",
			32);
		warnText.setFormat("Minecraftia.ttf", 28, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);

		//FlxTween.tween(warnText,);

		FlxTween.tween(warnText, {y: warnText.y + 10}, 1.6, 
			{ease: FlxEase.quadInOut,
				type: PINGPONG,
				startDelay: 0.1});

		FlxTween.tween(line3, {y: line3.y + 15}, 1.6, 
			{ease: FlxEase.quadInOut,
				type: PINGPONG,
				startDelay: 0.1});

		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.data.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
