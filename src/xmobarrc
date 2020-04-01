Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
       , bgColor = "black"
       , fgColor = "grey"
       , position = TopW L 100 
       , commands = [ Run Weather "EGPF" ["-t"
                                         ," <tempC>C"
                                         ,"-L","64"
                                         ,"-H","77"
                                         ,"--normal","green"
                                         ,"--high","red"
                                         ,"--low","lightblue"] 36000
                    , Run Cpu            ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory         ["-t","Mem: <usedratio>%"] 10
                    , Run Battery        ["--template" , "Batt: <acstatus>"
                                         ,"--Low"      , "10"        -- units: %
                                         , "--High"     ,"80"        -- units: %
                                         , "--low"      ,"darkred"
                                         , "--normal"   ,"darkorange"
                                         , "--high"     ,"darkgreen"
                                         , "--" -- battery specific options
                                         , "-o"	, "<left>% (<timeleft>)" --discharging status
                                         , "-O"	, "<fc=#dAA520>Charging</fc>" --AC "on" status
                                         , "-i"	, "<fc=#006000>Charged</fc>" -- charged status
                                         ] 50
    
                    , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                                         , "--Low"      , "1000"       -- units: B/s
                                         , "--High"     , "5000"       -- units: B/s
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10

                    , Run Date "%a %b %_d %l:%M" "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %cpu% | %memory% | %battery% | %dynnetwork%    <fc=#ee9a00>%date%</fc> | %EGPF%"
       }
