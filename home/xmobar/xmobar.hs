-- @file XMobar Configuration File
-- @author Quinn Smith
-- @date April 11th, 2020
-- @dependencies IBM Plex Mono Font, FontAwesome

Config {font = "xft:IBM Plex Mono-9:normal,FontAwesome: size=11"  
        bgColor = "#282a36",
        fgColor = "#6272a4",
        position = TopW L 100, 
        sepChar = "%",
        alignSep = "}{",
        commands = [
                    Run StdinReader,
                    Run Com "bash" ["-c", "~/.scripts/xmobar/volume"]  "vol" 10,
                    Run Com "bash" ["-c", "~/.scripts/xmobar/wifi"]    "wifi" 10,
                    Run Com "bash" ["-c", "~/.scripts/xmobar/battery"] "bat" 10,
                    Run Com "bash" ["-c", "~/.scripts/xmobar/time"]    "time" 10,
                    Run Com "bash" ["-c", "~/.scripts/xmobar/weather"] "weather" 600
                   ],
        template = "%StdinReader% }{ %bat% %vol% %wifi%  %weather%  %time% "
       }
