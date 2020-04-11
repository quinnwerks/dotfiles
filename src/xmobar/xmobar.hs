Config {font = "xft:Sans Serif-10:normal,FontAwesome: size=14"  
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
                    Run Weather "RJTT" [ "--template", "<fc=#4682B4><tempC></fc>°C/<fc=#4682B4><rh></fc>%"] 36000
                   ],
        template = "%StdinReader% }{ %bat% %vol% | Wifi:%wifi% | %date% | %RJTT%"
       }
