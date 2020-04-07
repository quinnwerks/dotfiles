import XMonad
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import System.IO

--main::IO()
--main = xmonad =<< statusBar myBar myPP (ewmh $ myConfig)

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ myConfig

myConfig = defaultConfig { layoutHook = myLayout,
                           manageHook = myManage,
                           handleEventHook = myEvent
                         } `additionalKeys` myKeys


myManage = manageDocks <+> manageHook defaultConfig
myEvent = handleEventHook defaultConfig <+> docksEventHook
myLayout = avoidStruts  $  layoutHook defaultConfig


myBar = "xmobar"
myPP = dynamicLogWithPP xmobarPP { 
                    ppCurrent = xmobarColor "blue" ""
                    ,ppTitle = xmobarColor "green" "" . shorten 80
                }


myKeys = []

