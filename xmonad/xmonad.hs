import XMonad

import XMonad.Hooks.DynamicLog
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

main = do
    let defaultModMask = mod1Mask

    let vertical = (Tall 1 (3/100) (60/100))
    let horizontal = Mirror vertical
    let full = Full
    let gimp = withIM (1/6) ((ClassName "Gimp") `And` (Role "gimp-toolbox")) $ reflectHoriz $
               withIM (1/6) ((ClassName "Gimp") `And` (Role "gimp-dock")) Full

    nScreens <- countScreens
    xmobars <- mapM (\s -> spawnPipe ("xmobar -x " ++ show s ++ " ~/.xmonad/xmobarrc")) [0..nScreens-1]
    xmonad $ defaultConfig
        { modMask = defaultModMask
        , terminal = "urxvtc"
        , focusFollowsMouse = True
        , normalBorderColor = "#6c6d6e"
        , focusedBorderColor = "#dc6d6e"
        , workspaces = ["1", "2", "3", "4", "5", "6"]
        , manageHook = composeAll
            [ isDialog --> doCenterFloat
            , className =? "Google-chrome" --> doShift "3"
            , className =? "Chrome" --> doShift "3"
            , className =? "Deluge-gtk" --> doShift "3"
            , className =? "Deluge" --> doShift "3"
            , className =? "P4v.bin" --> doShift "4"
            , className =? "Gthumb" --> doShift "4"
            , className =? "Easytag" --> doShift "4"
            , className =? "Gimp" --> doShift "5"
            , (className =? "Gimp" <&&> (role =? "gimp-toolbox" <||> role =? "gimp-dock" <||> role =? "gimp-image-window")) --> unfloat
            , className =? "VirtualBox" --> doShift "6"
            , className =? "VBoxSDL" --> doShift "6"
            , className =? "qemu-system-i386" --> doCenterFloat
            , className =? "SWT" --> doCenterFloat -- Code Collaborator
            ] <+> manageDocks <+> manageHook defaultConfig
        , layoutHook = smartBorders . avoidStruts
            $ onWorkspaces ["1", "2"] (vertical ||| horizontal ||| full)
            $ onWorkspaces ["3", "4", "6"] (full ||| vertical ||| horizontal)
            $ onWorkspace "5" (gimp ||| full ||| vertical ||| horizontal)
            $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = mapM_ (\(h, s) -> hPutStrLn h s) . zip xmobars . replicate 2
            , ppCurrent = xmobarColor "#dcddde" "" 
            , ppUrgent = xmobarColor "#8c0d0e" ""
            , ppTitle = xmobarColor "#dcddde" "" . shorten 200
            , ppSep = " :: "
            , ppLayout = (\l -> case l of
                "Tall" -> "V"
                "Hinted Tall" -> "V"
                "Mirror Tall" -> "H"
                "Hinted Mirror Tall" -> "H"
                "Full" -> "F"
                "Hinted Full" -> "F"
                "IM ReflectX IM Full" -> "G"
                _ -> l)
            }
        } `additionalKeys`
        [ ((defaultModMask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")
        , ((0, xK_Print), spawn "scrot ~/tmp/%Y%m%d-%H%M%S.png")
        , ((defaultModMask, xK_Print), spawn "scrot -u ~/tmp/%Y%m%d-%H%M%S.png")
        , ((defaultModMask, xK_p), spawn "exe=`dmenu_path | dmenu -nf '#acadae' -nb '#6c6d6e' -sf '#6c6d6e' -sb '#acadae' -fn -misc-fixed-medium-r-normal--14-130-75-75-c-70-*-*` && eval \"exec $exe\"")
        ]
  where
    unfloat = ask >>= doF . W.sink
    role = stringProperty "WM_WINDOW_ROLE"
