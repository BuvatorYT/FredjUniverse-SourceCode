@echo off

rem Install actuate
haxelib install actuate 1.9.0

rem Install box2d
haxelib install box2d 1.2.3

rem Install discord_rpc
rem As it's specified as [git], no version is provided for installation.

rem Install flixel-addons
haxelib install flixel-addons 3.2.1

rem Install flixel-demos
haxelib install flixel-demos 3.1.0

rem Install flixel-templates
haxelib install flixel-templates 2.6.6

rem Install flixel-tools
haxelib install flixel-tools 1.5.1

rem Install flixel-ui
haxelib install flixel-ui 2.5.0

rem Install flixel
haxelib install flixel 5.5.0

rem Install flxanimate
haxelib git flxanimate https://github.com/ShadowMario/flxanimate dev

rem Install hscript
haxelib install hscript 2.5.0

rem Install hxCodec
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec.git

rem Install hxcpp
haxelib install hxcpp 4.3.2

rem Install hxdiscord_rpc
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc.git

rem Install layout
haxelib install layout 1.2.1

rem Install lime-samples
haxelib install lime-samples 7.0.0

rem Install lime
haxelib install lime 8.0.1

rem Install linc_luajit
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git

rem Install newgrounds
haxelib install newgrounds 2.0.2

rem Install openfl-samples
haxelib install openfl-samples 8.7.0

rem Install openfl
haxelib install openfl 9.3.2

rem Install polymod
rem As it's specified as [git], no version is provided for installation.

rem Install SScript
haxelib install SScript 7.7.0

rem Install systools
haxelib install systools 1.1.0

rem Install thx.semver
haxelib install thx.semver 0.2.2

rem Install tjson
haxelib install tjson 1.4.0

rem Set versions
haxelib set flixel 5.5.0
haxelib set flixel-addons 3.0.2
haxelib set flixel-tools 1.5.1
haxelib set flixel-ui 2.5.0
haxelib set flxanimate 3.0.4
haxelib set hxCodec 3.0.2
haxelib set hxdiscord_rpc 1.1.1
haxelib set lime 8.0.1
haxelib set openfl 9.3.2
haxelib set SScript 7.7.0
haxelib set tjson 1.4.0

echo Installation and version setting completed.
pause