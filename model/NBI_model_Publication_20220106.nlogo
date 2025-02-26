globals [
       ;; monitors
          deaths
          births
       ;; Years for supplements
          supple_year
       ;; Scenario names
          scenario]

turtles-own [age colony raising]

;;
;; SETUP Procedures
;;

to setup
   clear-all                                  ; clear everything (Monitors, Plot, World) before you start a new simulation

;; create the population
 ; create juvenile NBI
   create-turtles Number_Juveniles            ; create Turtles/Agents
     [
       setxy random-pxcor random-pycor        ; with random xy coordinates
       set heading random 360                 ; random direction
       set age 0                              ; set Age to 0
       set shape "nbi"                        ; change the shape to nbi
       set size 1.5                           ; change the size of the turtles
     ]
     ; set up the colony and the raising type for the individuals
;       ask n-of 3 turtles with [colony = 0 and raising = 0 and age = 0]  [set colony "Burghausen" set raising "P" set color green]
;       ask n-of 2 turtles with [colony = 0 and raising = 0 and age = 0]  [set colony "Kuchl" set raising "P" set color yellow]
;       ask n-of 11 turtles with [colony = 0 and raising = 0 and age = 0] [set colony "Ueberlingen" set raising "FP" set color blue]

;       ask turtles with [age = 0 and colony = 0 and raising = 0]
;       [
;         let cr random-float 1
;         ifelse cr < 0.1875
;           [set colony "Burghausen" set raising "P" set color green]
;           [ifelse cr < 0.3125    ; 0.125 + 0.1875
;             [set colony "Kuchl" set raising "P" set color yellow]
;             [set colony "Ueberlingen" set raising "FP" set color blue]
;           ]
;       ]



 ; create 1-Year-Old NBI
   create-turtles Number_Subadults_Age1
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 1
       set shape "nbi"
       set size 1.5
     ]
     ; set up the colony and the raising type for the individuals
;       ask n-of 3 turtles with [colony = 0 and raising = 0 and age = 1] [set colony "Burghausen" set raising "FP" set color green]
;       ask n-of 2 turtles with [colony = 0 and raising = 0 and age = 1] [set colony "Kuchl" set raising "FP" set color yellow]
;       ask n-of 2 turtles with [colony = 0 and raising = 0 and age = 1] [set colony "Ueberlingen" set raising "FP" set color blue]

;       ask turtles with [age = 1 and colony = 0 and raising = 0]
;       [
;         let cr random-float 1
;         ifelse cr < 0.333
;           [set colony "Burghausen" set raising "FP" set color green]
;           [ifelse cr < 0.666    ; 0.333 + 0.333
;             [set colony "Kuchl" set raising "FP" set color yellow]
;             [set colony "Ueberlingen" set raising "FP" set color blue]
;           ]
;       ]

 ; create 2-Year-Old NBI
   create-turtles Number_Subadults_Age2
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 2
       set shape "nbi"
       set size 1.5
     ]
     ; set up the colony and the raising type for the individuals
;       ask n-of 4 turtles with [colony = 0 and raising = 0 and age = 2] [set colony "Burghausen" set raising "FP" set color green]
;       ask n-of 3 turtles with [colony = 0 and raising = 0 and age = 2] [set colony "Kuchl" set raising "FP" set color yellow]
;       ask n-of 3 turtles with [colony = 0 and raising = 0 and age = 2] [set colony "Kuchl" set raising "P" set color blue]

;       ask turtles with [age = 2 and colony = 0 and raising = 0]
;       [
;         let cr random-float 1
;         ifelse cr < 0.233
;           [set colony "Burghausen" set raising "FP" set color green]
;           [ifelse cr < 0.466    ; 0.233 + 0.233
;             [set colony "Kuchl" set raising "FP" set color yellow]
;             [ifelse cr < 0.766    ; 0.233 + 0.233 + 0.3
;             [set colony "Kuchl" set raising "P" set color yellow]
;             [set colony "Ueberlingen" set raising "FP" set color blue]
;             ]
;           ]
;       ]

 ; create adult NBI
   create-turtles Number_Adults
     [
       setxy random-pxcor random-pycor
       set heading random 360
       set age 3
       set shape "nbi"
       set size 1.5
     ]
     ; set up the colony and the raising type for the individuals
;       ask n-of 3 turtles with [colony = 0 and raising = 0 and age = 3] [set colony "Burghausen" set raising "P" set color green]
;       ask n-of 5 turtles with [colony = 0 and raising = 0 and age = 3] [set colony "Kuchl" set raising "FP" set color yellow]

;       ask turtles with [age = 3 and colony = 0 and raising = 0]
;       [
;         let cr random-float 1
;         ifelse cr < 0.375
;           [set colony "Burghausen" set raising "P" set color green]
;           [set colony "Kuchl" set raising "FP" set color yellow]
;       ]

;; reset monitors and ticks
   set deaths 0                              ; set deaths (Monitor) to 0
   set births 0                              ; set births (Monitor) to 0
   reset-ticks                               ; set ticks to 0
;; add supplements if the switch is "On"
   supplement
end

;;
;; GO Procedures
;;

to go
   breeding
   supplement
   death
   stoch_event
   aging
   tick
end

;; Breeding with Reproductive rate
to breeding
   if Repro_Rate < 1                                             ; if the reproductive rate is smaller than 1
     [
       ask turtles with [age >= 3]                              ; ask turtles with age 3 or more
         [
           if random-float 1 < Repro_Rate                        ; test if the random number is smaller than a random number
             [                                                  ; if it is, then
               hatch 1                                          ; hatch 1 chick (turtle)
                 [                                              ; this chick has the following properties
                   set births births + 1                        ; increase the births (Monitor) by 1 per new turtle
                   setxy random-pxcor random-pycor              ; with random xy coordinates
                   set heading random 360                       ; with random direction
                   set age 0                                   ; set age to -1, because these chicks age in the same tick again, but that should not be, only in the next step
                   set raising "P"                              ; set the raising type to "P" because their parents are birds of the population
                   set label ""                                 ; they are not supplemented, so they need no label
                 ]

            ;; testing birth procedure
             ; print "I gave birth"
             ]
         ]
     ]


   if (Repro_Rate >= 1) and (Repro_Rate < 2)                      ; if the reproductive rate is at least 1 and smaller than 2
     [
       ask turtles with[age >= 3]
         [
           ifelse random-float 1 + 1 < Repro_Rate                ; increase the random number by 1 because the reproductive rate is higher
             [ ;if
               hatch 2                                          ; hatch 2 chicks (turtles)
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                  ; print "I hatch 2"
                 ]
             ]
             [ ;else
               hatch 1
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                 ]
             ]
         ]
     ]

  if (Repro_Rate >= 2) and (Repro_Rate < 3)                      ; if the reproductive rate is at least 2 and smaller than 3
     [
       ask turtles with[age >= 3]
         [
           ifelse random-float 1 + 2 < Repro_Rate                ; increase the random number by 1 because the reproductive rate is higher
             [ ;if
               hatch 3                                          ; hatch 3 chicks (turtles)
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                 ;  print "I hatch 3"
                 ]
             ]
             [ ;else
               hatch 2
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                 ]
             ]
         ]
     ]


   if (Repro_Rate >= 3) and (Repro_Rate < 4)
     [
       ask turtles with[age >= 3]
         [
           ifelse random-float 1 + 3 < Repro_Rate
             [ ; if
            ;r   print "I hatch 4"
               hatch 4
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                 ]
             ]
             [ ; else
               hatch 3
                 [
                   set births births + 1
                   setxy random-pxcor random-pycor
                   set heading random 360
                   set age 0
                   set raising "P"
                   set label ""
                 ]
             ]
         ]
     ]
end

to death
   ask turtles with [age = 0]                                  ; death probabilities per step for stage 1, the juveniles
     [
       if random-float 1 < Mortality_Juveniles                 ; test if the random number is smaller than the mortality probability for Juveniles
         [                                                     ; if it is, then
           set deaths deaths + 1                               ; increase Deaths (Monitor) by 1 per death individual
          ; print "Juvenile dies"                              ; print "Juvenile dies"
           die                                                 ; die
         ]
     ]

   ask turtles with [age = 1]                                  ; death probabilities per step for stage 2, the 1-Year-Olds
     [
       if random-float 1 < Mortality_Subadults_Age1
         [
           set deaths deaths + 1
          ; print "Subadult 1 dies"
           die
         ]
     ]

   ask turtles with [age = 2]                                  ; death probabilities per step for stage 3, the 2-Year-Olds
     [
       if random-float 1 < Mortality_Subadults_Age2
         [
           set deaths deaths + 1
          ; print "Subadult 2 dies"
           die
         ]
     ]

   ask turtles with [age >= 3]                                 ; death probabilities per step for stage 4, the adults
     [
       if random-float 1 < Mortality_Adults
         [
           set deaths deaths + 1
          ; print "Adult dies"
           die
         ]
     ]
end

to aging
   ask turtles                                                 ; ask every turtle
     [
       set age age + 1                                         ; increase age by 1
       forward 0.3                                             ; move by 0.3 patches forward
       if age > 25                                             ; if a turtle is older than 25
         [
           set deaths deaths + 1                               ; increase deaths (Monitor) by 1
           print "I am old"                                    ; print "I am old"
           die                                                 ; die
         ]
     ]
end

;;
;; SUPPLEMENT Procedure
;;

to supplement
   if Supplements? = true                                      ; test if the switch "Supplements?" is "On"
     [                                                         ; if it is, then ...
       set supple_year 0                                       ; set the year for supplements to 0
       if ticks < Supplement_Time                           ; as long as the ticks are smaller than the Supplement time do the following:
         [
           create-turtles Number_Supplements                   ; create as many turtles as defined with the Number_Supplements-Slider
             [
               setxy random-pxcor random-pycor
               set heading random 360
               set age 0
               set raising "FP"
               set shape "nbi"
               set size 1.5
               set label "S"
               set supple_year supple_year + 1
             ]
;          ask n-of 10 turtles with [colony = 0 and age = 0] [set colony "Burghausen" set color green]
;          ask n-of 10 turtles with [colony = 0 and age = 0] [set colony "Kuchl"      set color yellow]
;          ask n-of 10 turtles with [colony = 0 and age = 0] [set colony "Ueberlingen" set color blue]

           ask turtles with [label = "S"] ; or age = 0 and raising = "FP" and label = "S"
             [
               let cr random-float 1
               ifelse cr < 0.333
                 [set colony "Burghausen" set raising "FP" set color green]
                 [ifelse cr < 0.666    ; 0.333 + 0.333
                    [set colony "Kuchl" set raising "FP" set color yellow]
                    [set colony "Ueberlingen" set raising "FP" set color blue]
                 ]
             ]
         ]
     ]
end

;;
;; STOCHASTIC EVENT Procedure
;;

to stoch_event
   if Stoch_events?                                            ; test if the switch "Stoch_events?" is "On"
     [                                                         ; if it is, then ...
       if random-float 1 < Frequency                           ; is the random number between 0 and 1 smaller than the Frequency?
         [                                                     ; if it is, then ...
           print "Stochastic event"
           ask turtles                                         ; ask Turtles
             [
               if random-float 1 < Severity                    ; is the random number between 0 and 1 smaller than the Severity?
                 [                                             ; if it is, then ...
                   set deaths deaths + 1                       ; increase Deaths (Monitor) by 1
                   die                                         ; die
                 ]
             ]
         ]
     ]
end


;;
;; SCENARIOS
;;

; these are scenarios for the stochastic event & supplement simulations
to prep

  if scenario = "100RR"
    [
     set Mortality_Juveniles 0.36
     set Mortality_Subadults_Age1 0.26
     set Mortality_Subadults_Age2 0.31
     set Mortality_Adults 0.22
     set Repro_Rate 1.06
    ]

  if scenario = "10adu"
    [
     set Mortality_Juveniles 0.36
     set Mortality_Subadults_Age1 0.26
     set Mortality_Subadults_Age2 0.31
     set Mortality_Adults 0.14
     set Repro_Rate 0.53
    ]

  if scenario = "25adu"
    [
     set Mortality_Juveniles 0.36
     set Mortality_Subadults_Age1 0.26
     set Mortality_Subadults_Age2 0.31
     set Mortality_Adults 0.02
     set Repro_Rate 0.53
    ]

  if scenario = "10all"
    [
     set Mortality_Juveniles 0.30
     set Mortality_Subadults_Age1 0.19
     set Mortality_Subadults_Age2 0.24
     set Mortality_Adults 0.14
     set Repro_Rate 0.53
    ]

  if scenario = "25all"
    [
     set Mortality_Juveniles 0.20
     set Mortality_Subadults_Age1 0.08
     set Mortality_Subadults_Age2 0.14
     set Mortality_Adults 0.02
     set Repro_Rate 0.53
    ]

  if scenario = "10all10RR"
    [
     set Mortality_Juveniles 0.30
     set Mortality_Subadults_Age1 0.19
     set Mortality_Subadults_Age2 0.24
     set Mortality_Adults 0.14
     set Repro_Rate 0.58
    ]

  if scenario = "25all25RR"
    [
     set Mortality_Juveniles 0.20
     set Mortality_Subadults_Age1 0.08
     set Mortality_Subadults_Age2 0.14
     set Mortality_Adults 0.02
     set Repro_Rate 0.66
    ]
  if scenario = "Statusquo"
    [
     set Mortality_Juveniles 0.36
     set Mortality_Subadults_Age1 0.26
     set Mortality_Subadults_Age2 0.31
     set Mortality_Adults 0.22
     set Repro_Rate 1.41
    ]
  if scenario = "All_chicks"
    [
     set Mortality_Juveniles 0.36
     set Mortality_Subadults_Age1 0.26
     set Mortality_Subadults_Age2 0.31
     set Mortality_Adults 0.22
     set Repro_Rate 3.97
    ]
  if scenario = "All_chicks_Cata"
    [
     set Mortality_Juveniles 0.36
     set Mortality_Subadults_Age1 0.26
     set Mortality_Subadults_Age2 0.31
     set Mortality_Adults 0.22
     set Repro_Rate 3.97
    ]

end
@#$#@#$#@
GRAPHICS-WINDOW
436
10
873
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
Years
30.0

BUTTON
11
14
74
47
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
113
293
287
326
Repro_Rate
Repro_Rate
0
4
3.97
0.01
1
NIL
HORIZONTAL

SLIDER
216
93
389
126
Mortality_Juveniles
Mortality_Juveniles
0
1
0.36
0.01
1
NIL
HORIZONTAL

SLIDER
216
126
389
159
Mortality_Subadults_Age1
Mortality_Subadults_Age1
0
1
0.26
0.01
1
NIL
HORIZONTAL

SLIDER
216
159
389
192
Mortality_Subadults_Age2
Mortality_Subadults_Age2
0
1
0.31
0.01
1
NIL
HORIZONTAL

SLIDER
216
192
389
225
Mortality_Adults
Mortality_Adults
0
1
0.22
0.01
1
NIL
HORIZONTAL

PLOT
919
127
1345
408
Population size
Year
N
0.0
10.0
0.0
100.0
true
true
"" ""
PENS
"Population size" 1.0 0 -16777216 true "" "plot count turtles"
"B" 1.0 0 -10899396 true "" "plot count turtles with [colony = \"Burghausen\"]"
"K" 1.0 0 -1184463 true "" "plot count turtles with [colony = \"Kuchl\"]"
"Üb" 1.0 0 -13345367 true "" "plot count turtles with [colony = \"Ueberlingen\"]"

MONITOR
920
13
992
58
Individuals
count turtles
17
1
11

MONITOR
1115
13
1172
58
Births
births
17
1
11

MONITOR
1179
13
1236
58
Deaths
deaths
17
1
11

SLIDER
16
93
186
126
Number_Juveniles
Number_Juveniles
0
100
37.0
1
1
NIL
HORIZONTAL

SLIDER
16
126
186
159
Number_Subadults_Age1
Number_Subadults_Age1
0
100
11.0
1
1
NIL
HORIZONTAL

SLIDER
16
159
186
192
Number_Subadults_Age2
Number_Subadults_Age2
0
100
8.0
1
1
NIL
HORIZONTAL

SLIDER
16
192
186
225
Number_Adults
Number_Adults
0
100
18.0
1
1
NIL
HORIZONTAL

BUTTON
91
14
154
47
step
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
165
14
228
47
run
while [any? turtles and ticks < 50][ go ]\n;go\n;while [ticks < 50][ go ]\n;while [ any? turtles ] [ go ]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SWITCH
16
402
169
435
Supplements?
Supplements?
1
1
-1000

SLIDER
16
435
169
468
Number_Supplements
Number_Supplements
0
50
30.0
1
1
NIL
HORIZONTAL

MONITOR
1004
13
1109
58
Number Juveniles
count turtles with [age = 0]
17
1
11

MONITOR
919
68
992
113
Burghausen
count turtles with [colony = \"Burghausen\"]
17
1
11

MONITOR
1006
67
1063
112
Kuchl
count turtles with [colony = \"Kuchl\"]
17
1
11

MONITOR
1074
67
1146
112
Überlingen
count turtles with [colony = \"Ueberlingen\"]
17
1
11

MONITOR
1209
70
1343
115
Supplements per Year
supple_year
17
1
11

SWITCH
249
400
387
433
Stoch_events?
Stoch_events?
0
1
-1000

SLIDER
249
433
385
466
Frequency
Frequency
0
1
0.9
0.1
1
NIL
HORIZONTAL

SLIDER
249
466
385
499
Severity
Severity
0
1
0.88
0.01
1
NIL
HORIZONTAL

TEXTBOX
36
64
186
82
Number of Individuals
14
0.0
1

TEXTBOX
269
64
357
82
Mortality
14
0.0
1

TEXTBOX
142
267
259
289
Reproductive Rate
14
0.0
1

TEXTBOX
50
375
139
393
Supplements
14
0.0
1

TEXTBOX
260
372
374
393
Stochastic events
14
0.0
1

SLIDER
16
468
169
501
Supplement_Time
Supplement_Time
0
10
7.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

The model is intended to represent the survival of a Northern Bald Ibis (NBI; _Geronticus eremita_) population, considering mortality probabilities per stage (age class), reproductive probabilities, the addition of supplements and the occurrence of catastrophic stochastic events.

## HOW IT WORKS

As many agents per age class are created as are set with the sliders _Number_Juveniles, Number_Subadults_Age1, Number_Subadults_Age2 and Number_Adults_ (_to setup_). 
The NBI breed (_to breeding_) with the probability set in the slider _Repro_Rate_ 
and die (_to death_) with a certain probability per year (sliders _Mortality_Juveniles, Mortality_Subadults_Age1, Mortality_Subadults_Age2, Mortality_Adults_). 
If they do not die, they age (_to aging_) and possibly move up to the next age class. 

If individuals are added (_to supplement_), a certain number of juvenile NBI (Slider _Number_Supplements_) is added once per year. You can also set the number of years over which the animals are to be added (Slider _Supplement_Time_). 

If stochastic events occur (_to stoch_event_), they occur with a certain probability (Slider _Frequency_) once a year with a certain severity (Slider _Severity_, additional mortality). 

In addition, we carried out simulations of various scenarios with the behaviour space, which are recorded in _"to prep"_. The survival and reproduction probabilities and the duration of the simulation are specified there.

## HOW TO USE IT

  * Number of individuals
    * Number_Juveniles: Number of NBI Juveniles
    * Number_Subadults_Age1: Number of 1-year-old subadults
    * Number_Subadults_Age2: Number of 2-year-old Subadults
    * Number_Adults: Number of adults

  * Mortality
    * Mortality_Juveniles: Mortality of juveniles
    * Mortality_Subadults_Age1: Mortality of 1-year-old subadults
    * Mortality_Subadults_Age2: Mortality of 2-year-old subadults 
    * Mortality_Adults: Mortality of adults

  * Reproductive Rate
    * Repro_Rate: Reproductive rate, the number of female juveniles per female per year.

  * Supplements
    * Supplements? : Should supplements (juvenile NBI) be added?
    * Number_Supplements: How many supplements should be added annually?
    * Supplement_Time: For how many years should supplements be added annually?
  * Stochastic events
    * Stoch_events?: Should stochastic events occur?
    * Frequency: With what probability per year should the stochastic events occur?
    * Severity: How severe should these stochastic events be; i.e. how much additional mortality do they lead to?


## THINGS TO NOTICE

  * If you run the model with updates, it can become very slow and possibly crash. At least when a lot of agents are created.
  * There are still examples in the code if you want to consider the raising type or the colony. We have discarded this part for our manuscript.
  * In a second model, we took the standard deviation into account for the baseline scenario. This is not taken into account in this model.

## THINGS TO TRY

  1. You should test different mortality and reproductive values. But also leave these values the same and look at the difference when you add catastrophic stochastic events and supplements.
  2. One could also examine the development per colony or per raising type. Examples are still available in the code (but as comments)

## EXTENDING THE MODEL

  * It would be interesting to include the landscape and movement. Or, for example, to allow mortality to fluctuate throughout the year. Currently, animals only die at one point per tick/year, but of course deaths can occur throughout the year, especially during autumn or spring migration.
  * It would also be interesting to analyse the development per raising type or per colony in more detail.

## NETLOGO FEATURES

We used the Behaviour Space to test different scenarios.

## RELATED MODELS

NA

## CREDITS AND REFERENCES

  1. The model is used for the manuscript of Drenske et al. 2022: On the road to self-sustainability: Reintroduced migratory Northern Bald Ibis (_Geronticus eremita_) still need management measures for population viability, submitted to Oryx.
  2. The model is also available online on: **XXX and YYY**.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bird
false
0
Polygon -7500403 true true 135 165 90 270 120 300 180 300 210 270 165 165
Rectangle -7500403 true true 120 105 180 237
Polygon -7500403 true true 135 105 120 75 105 45 121 6 167 8 207 25 257 46 180 75 165 105
Circle -16777216 true false 128 21 42
Polygon -7500403 true true 163 116 194 92 212 86 230 86 250 90 265 98 279 111 290 126 296 143 298 158 298 166 296 183 286 204 272 219 259 227 235 240 241 223 250 207 251 192 245 180 232 168 216 162 200 162 186 166 175 173 171 180
Polygon -7500403 true true 137 116 106 92 88 86 70 86 50 90 35 98 21 111 10 126 4 143 2 158 2 166 4 183 14 204 28 219 41 227 65 240 59 223 50 207 49 192 55 180 68 168 84 162 100 162 114 166 125 173 129 180

bird side
false
0
Polygon -7500403 true true 0 120 45 90 75 90 105 120 150 120 240 135 285 120 285 135 300 150 240 150 195 165 255 195 210 195 150 210 90 195 60 180 45 135
Circle -16777216 true false 38 98 14

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

nbi
true
0
Polygon -7500403 true true 210 45 240 45 285 90 240 90 240 180 210 225 105 225 75 255 45 255 75 210 120 150 210 120 210 45
Rectangle -7500403 true true 165 210 195 285

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Baseline_Start_Pop20" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word Mortality_Juveniles Mortality_Subadults_Age1 Mortality_Subadults_Age2 Mortality_Adults Repro_Rate Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="16"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Juveniles">
      <value value="0.22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age1">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age2">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Adults">
      <value value="0.14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repro_Rate">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Baseline_Start_Pop120" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word Mortality_Juveniles Mortality_Subadults_Age1 Mortality_Subadults_Age2 Mortality_Adults Repro_Rate Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Juveniles">
      <value value="0.22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age1">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age2">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Adults">
      <value value="0.14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repro_Rate">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Baseline_and_Improvements_2020" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word Mortality_Juveniles Mortality_Subadults_Age1 Mortality_Subadults_Age2 Mortality_Adults Repro_Rate Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="37"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="18"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Juveniles">
      <value value="0.2"/>
      <value value="0.3"/>
      <value value="0.36"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age1">
      <value value="0.08"/>
      <value value="0.19"/>
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age2">
      <value value="0.14"/>
      <value value="0.24"/>
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Adults">
      <value value="0.02"/>
      <value value="0.14"/>
      <value value="0.22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repro_Rate">
      <value value="0.53"/>
      <value value="0.58"/>
      <value value="0.66"/>
      <value value="1.06"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Statquo_All_chicks_2020" repetitions="100" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000  or 
count turtles &lt; 1</exitCondition>
    <metric>(word Mortality_Juveniles Mortality_Subadults_Age1 Mortality_Subadults_Age2 Mortality_Adults Repro_Rate Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="37"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="18"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Juveniles">
      <value value="0.36"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age1">
      <value value="0.26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Subadults_Age2">
      <value value="0.31"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Mortality_Adults">
      <value value="0.22"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repro_Rate">
      <value value="1.41"/>
      <value value="3.97"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="CataS_Baseline_and_Improvements_2020" repetitions="100" runMetricsEveryStep="true">
    <setup>prep
setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000 or 
count turtles &lt; 1</exitCondition>
    <metric>(word scenario Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>Mortality_Juveniles</metric>
    <metric>Mortality_Subadults_Age1</metric>
    <metric>Mortality_Subadults_Age2</metric>
    <metric>Mortality_Adults</metric>
    <metric>Repro_Rate</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;100RR&quot;"/>
      <value value="&quot;10adu&quot;"/>
      <value value="&quot;25adu&quot;"/>
      <value value="&quot;10all&quot;"/>
      <value value="&quot;25all&quot;"/>
      <value value="&quot;10all10RR&quot;"/>
      <value value="&quot;25all25RR&quot;"/>
      <value value="&quot;Statusquo&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="37"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="18"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="15"/>
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
      <value value="0.2"/>
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Cata_all_chicks_without_Supp_2020" repetitions="100" runMetricsEveryStep="true">
    <setup>prep
setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000 or 
count turtles &lt; 1</exitCondition>
    <metric>(word scenario Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>Mortality_Juveniles</metric>
    <metric>Mortality_Subadults_Age1</metric>
    <metric>Mortality_Subadults_Age2</metric>
    <metric>Mortality_Adults</metric>
    <metric>Repro_Rate</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;All_chicks_Cata&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="37"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="18"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
      <value value="0.2"/>
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="CataS_AllChicks_2020" repetitions="100" runMetricsEveryStep="true">
    <setup>prep
setup</setup>
    <go>go</go>
    <timeLimit steps="50"/>
    <exitCondition>count turtles &gt; 5000 or 
count turtles &lt; 1</exitCondition>
    <metric>(word scenario Supplements? Number_Supplements Supplement_Time Stoch_events? Frequency Severity)</metric>
    <metric>Mortality_Juveniles</metric>
    <metric>Mortality_Subadults_Age1</metric>
    <metric>Mortality_Subadults_Age2</metric>
    <metric>Mortality_Adults</metric>
    <metric>Repro_Rate</metric>
    <metric>count turtles</metric>
    <metric>count turtles with [colony = "Burghausen"]</metric>
    <metric>count turtles with [colony = "Kuchl"]</metric>
    <metric>count turtles with [colony = "Ueberlingen"]</metric>
    <metric>count turtles with [raising = "FP"]</metric>
    <metric>count turtles with [raising = "P"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "FP"]</metric>
    <metric>count turtles with [colony = "Burghausen" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Kuchl" and raising = "P"]</metric>
    <metric>count turtles with [colony = "Ueberlingen" and raising = "P"]</metric>
    <metric>count turtles with [age = 0]</metric>
    <metric>count turtles with [age = 1]</metric>
    <metric>count turtles with [age = 2]</metric>
    <metric>count turtles with [age &gt;= 3]</metric>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;All_chicks&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Juveniles">
      <value value="37"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age1">
      <value value="11"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Subadults_Age2">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Adults">
      <value value="18"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplements?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Number_Supplements">
      <value value="15"/>
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Supplement_Time">
      <value value="4"/>
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Stoch_events?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Frequency">
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Severity">
      <value value="0.05"/>
      <value value="0.1"/>
      <value value="0.15"/>
      <value value="0.2"/>
      <value value="0.25"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
