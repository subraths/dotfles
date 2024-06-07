import XMonad

import XMonad.Util.EZConfig (additionalKeysP)

import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Layout.NoBorders (noBorders)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Loggers

import XMonad.Layout.Fullscreen (fullscreenEventHook, fullscreenManageHook, fullscreenFull)

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure myXmobarPP)) toggleStrutsKey
     $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_t)

myConfig = def
    { modMask = myModMask
    , borderWidth = myBorderWidth
    , terminal = myTerminal
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    -- , handleEventHook = myHandleEventHook
    , startupHook = myStartupHook
    , focusFollowsMouse = True
    }
  `additionalKeysP`
    [ ("M-p", spawn "dmenu_run -fn 'FiraCode Nerd Font:size=12' -h 30 -l 10 -c")
    , ("M-b"  , spawn "google-chrome-stable")
    , ("M-S-<Return>", spawn "thunar")
    , ("M-<Return>", spawn "st")
    , ("M-q", kill)
    , ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 2")
    , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 2")
    , ("<XF86Explorer>", spawn "scrot")
    , ("M-<Tab>", toggleWS)
    , ("M-f", sendMessage ToggleLayout)
    , ("M-S-m", spawn "~/.screenlayout/secondaary-only.sh")
    , ("M-S-t", spawn "~/.config/scripts/toggle-touch-pad.sh")
    ]

myModMask = mod1Mask
myTerminal = "st"
myBorderWidth = 0

myLayoutHook = toggleLayouts (noBorders Full) $ Tall 1 (3/100) (1/2) ||| Full

myManageHook = fullscreenManageHook <+> manageHook def

-- myHandleEventHook = fullscreenEventHook <+> handleEventHook def

-- startuphook
myStartupHook :: X ()
myStartupHook = do
  spawn "~/.config/xmonad/scripts/pipes.sh &"
  spawn "~/.config/xmonad/scripts/volume-pipe.sh &"
  spawn "~/.config/xmonad/scripts/backlight-pipe.sh &"

-- xmobar config
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
