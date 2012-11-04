module Main where

import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.Reflect
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.IndependentScreens

import XMonad.Util.Run
import XMonad.Util.EZConfig

import qualified XMonad.StackSet as W

main :: IO ()
main = xmonad $ ewmh $ defaultConfig
    { modMask = mod1Mask
    , terminal = "urxvtc"
    , focusFollowsMouse = True
    , normalBorderColor = "#6c6d6e"
    , focusedBorderColor = "#dc6d6e"
    , workspaces = ["1", "2", "3", "4", "5", "6"]
    , layoutHook = myLayoutHook
    , manageHook = myManageHook
    , logHook = myLogHook =<< spawnPipe "xmobar ~/.xmobarrc"
    } `additionalKeys` myKeys mod1Mask

myLayoutHook = smartBorders . avoidStruts
    $ onWorkspaces ["1", "2"] (vertical ||| horizontal ||| Full)
    $ onWorkspaces ["3", "4", "6"] (Full ||| vertical ||| horizontal)
    $ onWorkspace "5" (gimp ||| Full ||| vertical ||| horizontal)
    $ layoutHook defaultConfig
  where
    vertical = (Tall 1 (3/100) (60/100))
    horizontal = Mirror vertical
    gimp = withIM (1/6) ((ClassName "Gimp") `And` (Role "gimp-toolbox"))
         $ reflectHoriz
         $ withIM (1/6) ((ClassName "Gimp") `And` (Role "gimp-dock")) Full

myLogHook xmobar = dynamicLogWithPP xmobarPP
    { ppOutput = hPutStrLn xmobar
    , ppCurrent = xmobarColor "#dcddde" "" 
    , ppUrgent = xmobarColor "#8c0d0e" ""
    , ppTitle = xmobarColor "#dcddde" "" . shorten 200
    , ppSep = " :: "
    , ppLayout = (\l -> case l of
        "Tall"                -> "V"
        "Hinted Tall"         -> "V"
        "Mirror Tall"         -> "H"
        "Hinted Mirror Tall"  -> "H"
        "Full"                -> "F"
        "Hinted Full"         -> "F"
        "IM ReflectX IM Full" -> "G"
        _                     -> l)
    }

myManageHook :: ManageHook
myManageHook = composeAll
    [ isDialog                            --> doCenterFloat
    , className  =? "Google-chrome"       --> doShift "3"
    , className  =? "Chrome"              --> doShift "3"
    , className  =? "Deluge-gtk"          --> doShift "3"
    , className  =? "Deluge"              --> doShift "3"
    , className  =? "P4v.bin"             --> doShift "4"
    , className  =? "Gthumb"              --> doShift "4"
    , className  =? "Easytag"             --> doShift "4"
    , className  =? "Inkscape"            --> doShift "4"
    , className  =? "Gimp"                --> doShift "5"
    , (className =? "Gimp" <&&>
           (role =? "gimp-toolbox"
       <||> role =? "gimp-dock"
       <||> role =? "gimp-image-window")) --> unfloat
    , className  =? "VirtualBox"          --> doShift "6"
    , className  =? "VBoxSDL"             --> doShift "6"
    , className  =? "qemu-system-i386"    --> doCenterFloat
    , className  =? "SWT"                 --> doCenterFloat
    ] <+> manageDocks
      <+> manageHook defaultConfig
  where
    unfloat = ask >>= doF . W.sink
    role = stringProperty "WM_WINDOW_ROLE"

myKeys :: ButtonMask -> [((ButtonMask, KeySym), X ())]
myKeys modMask =
    [ ((modMask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
    , ((0, xK_Print), spawn "scrot ~/storage/tmp/%Y%m%d-%H%M%S.png")
    , ((modMask, xK_Print), spawn "scrot -u ~/storage/tmp/%Y%m%d-%H%M%S.png")
    , ((modMask, xK_p), spawn "exe=`dmenu_path | dmenu -nf '#acadae' -nb '#6c6d6e' -sf '#6c6d6e' -sb '#acadae' -fn -misc-fixed-medium-r-normal--14-130-75-75-c-70-*-*` && eval \"exec $exe\"")
    ]
