import XMonad
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Spacing
import XMonad.Hooks.EwmhDesktops
import System.IO

-- Main --
---- Put it all together
main = xmonad =<< myBar myConfig
myConfig = defaultConfig {
                borderWidth = myBorderWidth,
                -- Set mod key to windows key
                modMask = myModMask,
                -- Hooks
                manageHook = myManageHook,
                layoutHook = myLayoutHook
            } `additionalKeys` myKeys


-- Manage Hook --
---- Execute arbrary instructions upon creation of a new window.
myManageHook = manageDocks <+> manageHook defaultConfig

-- Layout Hook --
---- Change the look of layouts.
myLayoutHook = avoidStruts  $  layoutHook defaultConfig
myModMask = mod4Mask

-- Border Width --
---- Width of window border in pixels.
myBorderWidth = 1 

-- Status Bar --
---- Set the status bar and partially control it's layout.
myBar = xmobar
myPP = dynamicLogWithPP xmobarPP { 
                    ppCurrent = xmobarColor "blue" "",
                    ppTitle = xmobarColor "green" "" . shorten 80
                }

-- Custom Keys --
---- Empty for now.
myKeys = []

