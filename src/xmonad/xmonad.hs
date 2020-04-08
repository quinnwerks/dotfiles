-- System Imports --
import System.IO
import System.Exit
-- Xmonad Imports --
import XMonad
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeys)
-- Data Structure Imports --
import qualified Data.Map        as DataMap
import qualified XMonad.StackSet as Win

-- Main --
---- Put it all together
main = do
    xmonad =<< myBar myConfig
myConfig = defaultConfig {
                -- Workspaces --
                workspaces = myWorkspaces,
                -- Aesthetics --
                borderWidth = myBorderWidth,
                -- Hooks --
                startupHook = myStartupHook,
                manageHook = myManageHook,
                layoutHook = myLayoutHook,
                -- Key Bindings --
                modMask = myModMask,
                keys = myKeys
            }

-- Startup Hook --
---- Execute instructions on start or restart of Xmonad.
myStartupHook = do
    -- Set desktop background (don't want to rely on an xessionrc).
    spawnOnce "feh --bg-scale ~/.xmonad/wallpapers/firewatch.jpg &"

-- Manage Hook --
---- Execute arbrary instructions upon creation of a new window.
myManageHook = manageDocks <+> manageHook defaultConfig

-- Layout Hook --
---- Change the look of layouts.
myLayoutHook =  spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ avoidStruts  (
                Tall 1 (3/100) (1/2) 
                ) ||| noBorders (fullscreenFull Full) 

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
         
         ---- Floating Windows
              -- Push window back into tiling.
              ((mod, xK_t), withFocused $ windows . Win.sink),
       
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
             
            ++
        
        ---- Workspaces
        -- Switch workspaces.
        [((m .|. mod, k), windows $ f i)
            | (i,k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f,m) <- [(Win.greedyView, 0), (Win.shift, shiftMask)]]
            
            ++
        ---- Screens
        -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
        -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
        -- TODO: questoin? when will I use this?
        [((m .|. mod, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(Win.view, 0), (Win.shift, shiftMask)]]

