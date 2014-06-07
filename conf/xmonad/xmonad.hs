import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myManageHook = composeAll
	[ className =? "Gimp" --> doFloat
	, className =? "mplayer" --> doFloat
	]

main = do
	xmproc <- spawnPipe "xmobar $HOME/.xmonad/.xmobar.hs"
	xmonad $ defaultConfig
		{ manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
		, layoutHook = avoidStruts $ layoutHook defaultConfig
		, logHook = dynamicLogWithPP xmobarPP
			{ ppOutput = hPutStrLn xmproc
			, ppTitle = xmobarColor "green" "" . shorten 50
			}
		, startupHook         = setWMName "LG3D"
		, borderWidth = 1
		,	terminal = "xterm"
		,	normalBorderColor = "#cccccc"
		,	focusedBorderColor = "#cd8b00"
		} `additionalKeys`
		[ ((mod4Mask, xK_l), spawn "gnome-screensaver-command -l")
		, ((mod4Mask, xK_a), spawn "gnome-alsamixer")
		, ((mod4Mask, xK_c), spawn "google-chrome")
		, ((mod4Mask, xK_e), spawn "pcmanfm")
		, ((mod4Mask, xK_p), spawn "poweroff")
		, ((mod4Mask, xK_o), spawn "reboot")
		, ((mod4Mask, xK_Print), spawn "sleep 0.2; scrot -s")
		, ((0, xK_Print), spawn "scrot")
		]
