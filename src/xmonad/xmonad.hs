-- System Imports --
import System.IO
import System.Exit
-- Xmonad Imports --
import XMonad
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
-- Data Structure Imports --
import qualified Data.Map        as DataMap
import qualified XMonad.StackSet as Win
-- Main --
---- Put it all together
main = xmonad =<< myBar myConfig
myConfig = defaultConfig {
                workspaces = myWorkspaces,
                borderWidth = myBorderWidth,
                -- Set mod key to windows key
                modMask = myModMask,
                -- Hooks
                manageHook = myManageHook,
                layoutHook = myLayoutHook,
                keys = myKeys
            }


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

-- Workspaces --
---- Configure workspaces.
myWorkspaces = ["1:term","2:web", "3:code", "4:ssh"]

-- Status Bar --
---- Set the status bar and partially control it's layout.
myBar = xmobar
myPP = dynamicLogWithPP xmobarPP { 
                    ppCurrent = xmobarColor "blue" "",
                    ppTitle = xmobarColor "green" "" . shorten 80
                }

-- Key Bindings --
---- Set up *all* keybindings for xmonad.
---- Descriptions from xmonad man page.
myKeys conf@(XConfig {XMonad.modMask = mod}) = DataMap.fromList $
        [
         ---- Focus Window
             -- Move focus to the next window.
             ((mod, xK_j), windows Win.focusDown),
             ((mod, xK_Tab), windows Win.focusDown),

             -- Move focus to the previous window.
             ((mod, xK_k), windows Win.focusUp),
             ((mod .|. shiftMask, xK_Tab), windows Win.focusDown),
            
             -- Swap the focused window with the next window.
             ((mod .|. shiftMask, xK_j), windows Win.swapDown),
             
             -- Swap the focused window with the previous window.
             ((mod .|. shiftMask, xK_k), windows Win.swapUp),
             
             -- Close focused window.
             ((mod.|. shiftMask, xK_c), kill),
             
             -- Rotate through the available layout algorithms.
             ((mod, xK_space), sendMessage NextLayout),
         
         ---- Master Window
             -- Swap the focused window and the master window.
             ((mod, xK_Return), windows Win.swapMaster),
             
             -- Move focus to the master window.
             ((mod, xK_m), windows Win.focusMaster),

             -- Shrink the master area.
             ((mod, xK_h), sendMessage Shrink),

             -- Expand the master area.
             ((mod, xK_l), sendMessage Expand),
       
         ---- Making New Windows 
             -- Spawn a term.
             ((mod .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
             
             -- Spawn Rofi.
             ((mod, xK_p), spawn "rofi -show run"),

         ---- Meta         
             -- Quit xmonad.
             ((mod .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
             
             -- Restart xmonad.
             ((mod, xK_q), restart "xmonad" True)]

