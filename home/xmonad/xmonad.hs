---- XMonad Config ----
-- @author Quinn Smith
-- @date April 7th, 2020
-- @file Configuration for XMonad window manager

-- System Imports --
import System.IO
import System.Exit
-- Xmonad Imports --
import XMonad
import Xresources
-- This is the xmonad config function that works
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
-- Multi screen xmobar
import XMonad.Layout.IndependentScreens
-- Pipes and Spawn
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
-- Data Structure Imports --
import qualified Data.Map        as DataMap
import qualified XMonad.StackSet as Win
import Graphics.X11.ExtraTypes.XF86

-- Status Bar
-- Allows bar to update in real time
import XMonad.Hooks.DynamicLog
import qualified Codec.Binary.UTF8.String as UTF8
import qualified DBus        as D
import qualified DBus.Client as D

xmobarBgColor = fromXres "*.color0"
xmobarFgColor = fromXres "*.color15"

main :: IO() 
main = mkDbusClient >>= main'

main' :: D.Client -> IO()
main' dbus = do
    spawnPipe "polybar example &"
    xmonad $ desktopConfig
        {  terminal = myTerminal,
	   logHook = myPolybarLogHook dbus,
           -- Layout Hook
           startupHook =  myStartupHook,
           manageHook = manageDocks <+> manageHook defaultConfig,
           layoutHook = avoidStruts  $  myLayoutHook,
           -- Aesthetics --
           borderWidth = myBorderWidth,
           focusedBorderColor = myBorderColor,
           -- Workspaces --
           workspaces = myWorkspaces,
           -- Key Bindings --
           modMask = myModMask,
           keys = myKeys,
           -- Mouse --
           focusFollowsMouse = myFocusFollowsMouse,
           mouseBindings = myMouseBindings
        }

mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = (D.signal opath iname mname)
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      blue   = "#2E9AFE"
      gray   = "#7F7F7F"
      orange = "#ea4300"
      purple = "#9058c7"
      red    = "#722222"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper blue
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppTitle           = shorten 100 . wrapper purple
          }
myPolybarLogHook dbus = dynamicLogWithPP (polybarHook dbus)

-- Startup Hook --
---- Execute instructions on start or restart of Xmonad.
myStartupHook = do
    -- Set desktop background (don't want to rely on an xessionrc).
    spawnOnce "feh --bg-scale ~/.xmonad/wallpapers/foggy_forest.jpg &"
    spawnOnce "xrdb ~/.Xresources &"

-- Manage Hook --
---- Execute arbrary instructions upon creation of a new window.
myManageHook = manageDocks <+> manageHook defaultConfig

-- Layout Hook --
---- Change the look of layouts.
myLayoutHook =  spacingRaw True (Border 0 15 15 15) True (Border 15 15 15 15) True $ avoidStruts  (
                Tall 1 (3/100) (1/2)  |||
                Mirror (Tall 1 (3/100) (3/5))
                ) ||| noBorders (fullscreenFull Full)

myTerminal = "termite"

myModMask = mod4Mask

-- Border Width --
---- Width of window border in pixels.
myBorderWidth = 3
myBorderColor = fromXres "*.color1"

-- Workspaces --
---- Configure workspaces.
myWorkspaces = map show [1..9]

-- Pretty Printer --
---- Configure the pretty printer
-- Set up StdInReader for each bar.


-- xmobar
myPPOutput :: [Handle] -> Int -> String -> IO()
myPPOutput handles 0 x = hPutStrLn (handles !! 0) x
myPPOutput handles n x = do
                         io <- hPutStrLn (handles !! n) x
                         io <- myPPOutput handles (n-1) x
                         return io

-- Get the pretty printer
myPP :: [Handle] -> PP
myPP handles = xmobarPP
                {   ppOutput = \x -> myPPOutput handles (length handles - 1) x,
                    ppCurrent = xmobarColor (fromXres "*.color11") "",
                    ppHidden = xmobarColor (fromXres "*.color7") "",
                    ppTitle = xmobarColor (fromXres "*.color7") "" . shorten 80,
                    ppLayout = xmobarColor (fromXres "*.color15") ""
                }

-- Screen Saver --
---- Set up command to lock the screen
myScreenSaver = "sh $HOME/.scripts/lock.sh $HOME/.xmonad/wallpapers/lock.png"

-- Program Launcher --
---- Set up command to run window launcher
myLauncher = "rofi -show run"

-- Key Bindings --
---- Set up *all* keybindings for xmonad.
------ Descriptions from xmonad man page.
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

         ---- Master Window
             -- Swap the focused window and the master window.
             ((mod, xK_Return), windows Win.swapMaster),
             -- Move focus to the master window.
             ((mod, xK_m), windows Win.focusMaster),
             -- Shrink the master area.
             ((mod, xK_h), sendMessage Shrink),
             -- Expand the master area.
             ((mod, xK_l), sendMessage Expand),
             -- Increment the number of windows in the master area.
             ((mod, xK_comma), sendMessage (IncMasterN 1)),
             -- Decrement the number of windows in the master area.
             ((mod, xK_period), sendMessage (IncMasterN (-1))),

         ---- Floating Windows
              -- Push window back into tiling.
              ((mod, xK_t), withFocused $ windows . Win.sink),

         ---- Making New Windows
             -- Spawn a term.
             ((mod .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf),
             -- Spawn Rofi.
             -- TODO: make this generic
             ((mod, xK_p), spawn myLauncher),

         ---- Layouts
             --  Reset the layouts on the current workspace to default.
             ((mod .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
             -- Rotate through the available layout algorithms.
             ((mod, xK_space), sendMessage NextLayout),

         ---- Media
             -- Mute volume.
             ((0, xF86XK_AudioMute), spawn "amixer set Master toggle"),
             -- Decrease volume.
             ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+"),
             -- Increase volume.
             ((0, xF86XK_AudioLowerVolume),
             spawn "amixer set Master 5%-"),
             -- Audio previous.
             ((0, 0x1008FF16), spawn ""),
             -- Play/pause.
             ((0, 0x1008FF14), spawn ""),
             -- Audio next.
             ((0, 0x1008FF17), spawn ""),

         ---- Screen
             -- Raise Brightness
             ((0, xF86XK_MonBrightnessUp), spawn "lux -a 5%"),
             -- Lower Brightness
             ((0, xF86XK_MonBrightnessDown), spawn "lux -s 5%"),

         ---- Meta
             -- Quit xmonad.
             ((mod .|. shiftMask, xK_q), io (exitWith ExitSuccess)),
             -- Toggle struts (bar visibility)
             ((mod, xK_b), do
                           spawn "polybar-msg cmd toggle" 
                           sendMessage ToggleStruts),
             -- Lock the screen.
             -- Lock the screen using command specified by myScreensaver.
             ((mod .|. shiftMask, xK_l), spawn myScreenSaver),
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
        -- TODO: question? when will I use this?
        [((m .|. mod, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
            , (f, m) <- [(Win.view, 0), (Win.shift, shiftMask)]]

-- Mouse bindings --
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = mod}) = DataMap.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((mod, button1),
     (\w -> focus w >> mouseMoveWindow w))
    -- mod-button2, Raise the window to the top of the stack
    , ((mod, button2),
       (\w -> focus w >> windows Win.swapMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((mod, button3),
       (\w -> focus w >> mouseResizeWindow w))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]
