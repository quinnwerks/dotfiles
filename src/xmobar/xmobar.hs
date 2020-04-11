Config {font = "xft:Sans Serif-10:normal,FontAwesome: size=11"  
        bgColor = "black",
        fgColor = "grey",
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
        template = "%StdinReader% }{ %bat%   %vol%   %wifi%    %weather%    %time%  "
       }
