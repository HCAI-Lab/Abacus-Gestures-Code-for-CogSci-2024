; clear-all will refresh/reset the model's memory so for simulating learning do it manually  
(clear-all)
(defun get-tens (number)
  (* (floor (/ number 10)) 10))
(defun get-units (number)
  "Extracts the units digit from a number in the range 0-99."
  (mod number 10))
(defun random-from-set ()
  (let ((numbers '(0 10 20 30 40 50 60 70 80 90)))
    (nth (random (length numbers)) numbers)))

(defun generate-random-number ()
;   (* (random 1.0) 100))
  (random 100))

;(defun generate-random-number ()
;  (let ((number (random 100)))
;    (let ((tens (* (truncate (/ number 10)) 10))
;          (units (mod (truncate number) 10)))
;      (values number tens units))))
(define-model abacus1
;My notes:
; :esc t based on activation , nil based on matching
; :lf is for latency and default is 1.0
;   Read page 566
  
  

					;(sgp :esc t :lf 1.0 :trace-detail high :act t :EPL t)

  (sgp          
		;--------------------------------
		;PRODUCTION-COMPILATION module
		;--------------------------------
		:TT                         2                ;default: 2.0        : Threshold time
		;:PCT                         T                ;default: NIL        : Production Compilation Trace
		:EPL                         T                ;default: NIL        : Enable Production Learning
		;--------------------------------
		;DECLARATIVE module
		;--------------------------------
		:SPREADING-HOOK              NIL              ;default: NIL        : Spreading component hook
		;:MAS                         -2              ;default: NIL        : Maximum Associative Strength
		:ACTIVATION-OFFSETS          NIL              ;default: NIL        : Add additional activation equation components
		:RT                          -10            ;default: 0.0        : Retrieval Threshold
		;:CHUNK-MERGE-HOOK            T              ;default: NIL        : Hook called when a chunk is merged into dm
;		:MD                          -1.0             ;default: -1.0       : Maximum Difference
		:BLL                         0.01              ;default: NIL        : Base Level Learning
		:LF                          1.22             ;default: 1.0        : Latency Factor
		:PAS                         NIL             ;default: NIL        : Permanent Activation noise S
		;:PM                          NIL              ;default: NIL        : Depricated - use :mp as both the flag and value instead (like :bll and :mas)
		:RETRIEVAL-REQUEST-HOOK      NIL              ;default: NIL        : Retrieval notification hook
		:LE                          0.16              ;default: 1.0        : Latency Exponent
		:ANS                         0.5             ;default: NIL        : Activation Noise S
		:BL-HOOK                     NIL              ;default: NIL        : Baselevel component hook
		;:MS                          0.1              ;default: 0.0        : Maximum Similarity
		:PARTIAL-MATCHING-HOOK       NIL              ;default: NIL        : Partial matching component hook
		:SIM-HOOK                    NIL              ;default: NIL        : Similarity hook
		:RETRIEVAL-SET-HOOK          NIL              ;default: NIL        : Prospective retrievals hook
		:MP                          NIL              ;default: NIL        : Mismatch Penalty
		:RETRIEVED-CHUNK-HOOK        NIL              ;default: NIL        : Retrieval completion hook
		:DECLARATIVE-NUM-FINSTS      4                ;default: 4          : Number of declarative finst markers
		:DECLARATIVE-FINST-SPAN      3.0              ;default: 3.0        : Duration of declarative finst markers in seconds
		;:ACT                         T              ;default: NIL        : Activation Trace
		:CHUNK-ADD-HOOK              NIL              ;default: NIL        : Hook called when a chunk is added to dm
		:SJI-HOOK                    nil              ;default: NIL        : Sji hook
		;:BLC                         0.1              ;default: 0.0        : Base Level Constant
		;:FAST-MERGE                  T                ;default: T          : Whether or not to use the fast merge mechanism
		:NOISE-HOOK                  NIL              ;default: NIL        : Noise component hook
		:W-HOOK                      NIL              ;default: NIL        : Wkj hook
		;--------------------------------
		;BUFFER-HISTORY module
		;--------------------------------
		;:SAVE-BUFFER-HISTORY         NIL              ;default: NIL        : Whether or not to record the history of buffer changes.
		;--------------------------------
		;PROCEDURAL module
		;--------------------------------
		;:CST                         NIL              ;default: NIL        : Conflict Set Trace
		;:USE-TREE                    NIL              ;default: NIL        : Use a decision tree in production matching
		;:CRT                         NIL              ;default: NIL        : Conflict Resolution Trace
		;:PPM-HOOK                    NIL              ;default: NIL        : Procedural partial matching utility adjustment hook
		;:DO-NOT-HARVEST              NIL       		  ;default: NIL        : Buffers that are not strict harvested
		;:CONFLICT-SET-HOOK           NIL              ;default: NIL        : Conflict set hook
		;:RHST                        T                ;default: T          : Right Hand Side Trace
		;:VPFT                        NIL              ;default: NIL        : Variable Production Firing Time
		;:PPM                         NIL              ;default: NIL        : Procedural partial matching
		;:DAT                         0.05             ;default: 0.05       : Default Action Time
		;:LHST                        T                ;default: T          : Left Hand Side Trace
		;:CYCLE-HOOK                  NIL              ;default: NIL        : Cycle hook
		;--------------------------------
		;RETRIEVAL-HISTORY module
		;--------------------------------
		;:SAVE-DM-HISTORY             NIL              ;default: NIL        : Whether or not to record the history of all retrieval events.
		;--------------------------------
		;CENTRAL-PARAMETERS module
		;--------------------------------
		;:OL                          NIL                ;default: T          : Optimized Learning
		:ESC                         T                ;default: NIL        : Enable Subsymbolic Computations
		:ER                          T              ;default: NIL        : Enable Randomness
		;--------------------------------
		;BUFFER-TRACE module
		;--------------------------------
		;:BUFFER-TRACE                NIL              ;Farnaz;default: NIL        : Display the trace as a buffer summary instead of as an event list.
		;:SAVE-BUFFER-TRACE           T              ;default: NIL        : Whether to save the buffer summary for a run or not.
		;:TRACED-BUFFERS              T                ;default: T          : The list of buffers to be traced (all buffers if set to t).
		;:BUFFER-TRACE-COLORS         NIL              ;default: NIL        : The colors used to draw the buffer data using the graphic tracing tool.
		;:BUFFER-TRACE-HOOK           NIL              ;default: NIL        : A function to call with each buffer summary.
		;:BUFFER-TRACE-STEP           NIL              ;default: NIL        : The maximum amount of time allowed to elapse before creating a buffer summary.
		;:GRAPHIC-COLUMN-WIDTHS       NIL              ;default: NIL        : The pixel width of the columns drawn for the buffers using the graphic tracing tool.
		;--------------------------------
		;BOLD module
		;--------------------------------
		;:POINT-PREDICT               (GOAL)           ;default: (GOAL)     : List of buffers for which the point based computation should be used to compute the BOLD response.
		;:BOLD-SCALE                  0.75             ;default: 0.75       : Scale parameter for computing the BOLD response.
		;:NEG-BOLD-SCALE              1                ;default: 1          : Scale parameter for computing a negative component of the BOLD response.
		;:NEG-BOLD-EXP                15               ;default: 15         : Exponenet parameter for computing a negative component of the BOLD response.
		;:BOLD-POSITIVE               1                ;default: 1          : Factor for the positive component of the hemodynamic response curve.
		;:BOLD-INC                    1.5              ;default: 1.5        : Time increment in seconds for computing the BOLD response.
		;:BOLD-SETTLE                 40               ;default: 40         : Time window in seconds for computing the BOLD response.
		;:BOLD-NEGATIVE               0                ;default: 0          : Factor for the negative component of the hemodynamic response curve.
		;:BOLD-EXP                    6                ;default: 6          : Exponenet parameter for computing the BOLD response.
		;--------------------------------
		;RANDOM-MODULE module
		;--------------------------------
		;:SEED                        (947718053 7352) ;default: NO-DEFAULT : Current seed of the random number generator
		;:RANDOMIZE-TIME              NIL              ;default: NIL        : Allows the timing of certain actions to vary
		;--------------------------------
		;NAMING-MODULE module
		;--------------------------------
		;:DCNN                        T                ;default: T          : Dynamic chunk name normalizing
		;:DCSC-HOOK                   NIL		      ;default: NIL        : Hook called when a chunk is changed due to normalizing
		;:NCNAR                       NIL              ;default: T          : Normalize chunk names after run
		;:SHORT-COPY-NAMES            NIL              ;default: NIL        : Flag to signal how copied chunks are named
		;--------------------------------
		;TEMPORAL module
		;--------------------------------
		;:TIME-NOISE                  0.015            ;default: 0.015      : Temporal noise
		;:TIME-MULT                   1.1              ;default: 1.1        : Temporal multiplier
		;:RECORD-TICKS                T                ;default: T          : Record each time increment as a buffer event
		;:TIME-MASTER-START-INCREMENT 0.011            ;default: 0.011      : Temporal start interval
		;--------------------------------
		;UTILITY module
		;--------------------------------
		;:EGS                         NIL              ;default: 0.0        : Expected Gain S
		:UT                          NIL              ;default: NIL        : Utility Threshold
		:UTILITY-OFFSETS             NIL              ;default: NIL        : Add additional utility equation components
;		:NU                          20               ;default: 0          : default U(0) value for a newly learned production
		;:UL                          T                ;default: NIL        : Utility learning switch
		:ALPHA                       0.2              ;default: 0.2        : Production learning rate
;		:IU                          10               ;default: 0          : default U(0) value for an initial (user defined) production
		:UTILITY-HOOK                NIL              ;default: NIL        : Utility computation hook
		;--------------------------------
		;VISION module
		;--------------------------------
		;:VISUAL-ONSET-SPAN           0.5              ;default: 0.5        : Lifespan of new visual objects being marked as NEW
		;:SCENE-CHANGE-THRESHOLD      0.25             ;default: 0.25       : Proportion of visicon which must change to signal a scene change
		;:VISUAL-MOVEMENT-TOLERANCE   0.5              ;default: 0.5        : How far something can move while still being seen as the same object.
		;:VISUAL-NUM-FINSTS           4                ;default: 4          : Number of visual finsts.
		;:TEST-FEATS                  T                ;default: T          : Whether proc-display should use the features to compare items instead of just the chunk names
		;:DELETE-VISICON-CHUNKS       T                ;default: T          : Whether proc-display should delete and unintern the name of old chunks that were in the visicon
		;:VISUAL-FINST-SPAN           3.0              ;default: 3.0        : Lifespan of a visual finst
		;:VISUAL-ATTENTION-LATENCY    0.085            ;default: 0.085      : Time for a shift of visual attention
		;:AUTO-ATTEND                 NIL              ;default: NIL        : Whether visual-location requests automatically generate an attention shift
		;:OPTIMIZE-VISUAL             T                ;default: T          : 
		;--------------------------------
		;BUFFER-PARAMS module
		;--------------------------------
		;:AURAL-LOCATION-ACTIVATION   0                ;default: 0          : source spread for the AURAL-LOCATION buffer
		;:RETRIEVAL-ACTIVATION        0                ;default: 0          : source spread for the RETRIEVAL buffer
		;:IMAGINAL-ACTION-ACTIVATION  0                ;default: 0          : source spread for the IMAGINAL-ACTION buffer
		;:MANUAL-ACTIVATION           0                ;default: 0          : source spread for the MANUAL buffer
		;:AURAL-ACTIVATION            0                ;default: 0          : source spread for the AURAL buffer
		;:IMAGINAL-ACTIVATION         0                ;default: 0          : source spread for the IMAGINAL buffer
		;:PRODUCTION-ACTIVATION       0                ;default: 0          : source spread for the PRODUCTION buffer
		;:VISUAL-LOCATION-ACTIVATION  0                ;default: 0          : source spread for the VISUAL-LOCATION buffer
		;:VOCAL-ACTIVATION            0                ;default: 0          : source spread for the VOCAL buffer
		;:GA                          1.0              ;default: 1.0        : source spread for the GOAL buffer
		;:VISUAL-ACTIVATION           0                ;default: 0          : source spread for the VISUAL buffer
		;:TEMPORAL-ACTIVATION         0                ;default: 0          : source spread for the TEMPORAL buffer
		;--------------------------------
		;DEVICE module
		;--------------------------------
		;:VWT                         NIL              ;default: NIL        : Virtual Window trace controls the << ... >> outputs from virtual windows
		;:PROCESS-CURSOR              NIL              ;default: NIL        : Should there be a visicon feature for the cursor?
		;:NEEDS-MOUSE                 T                ;default: T          : Does ACT-R control the mouse?
		;:MOUSE-FITTS-COEFF           0.1              ;default: 0.1        : b coefficient in Fitts's equation for aimed movements.
		;:PIXELS-PER-INCH             72.0             ;default: 72.0       : Pixels per inch of display
		;:STABLE-LOC-NAMES            T                ;default: T          : Whether or not to sort the virtual window's subviews to guarantee the names always line up
		;:VIEWING-DISTANCE            15.0             ;default: 15.0       : Distance of the eyes from the display, in inches.
		;:SHOW-FOCUS                  NIL              ;default: NIL        : Show the focus ring on the GUI?
		;--------------------------------
		;PRODUCTION-HISTORY module
		;--------------------------------
		;:P-HISTORY-COLORS            NIL              ;default: NIL        : The colors to use for the selected, other matched, and mismatched cells respectively.
		;:SAVE-P-HISTORY              NIL              ;default: NIL        : Whether or not to record the utility and whynot history of all conflict-resolution events.
		;:DRAW-BLANK-COLUMNS          T                ;default: T          : Whether or not to draw the columns which have no matched productions.
		;--------------------------------
		;AUDIO module
		;--------------------------------
		;:TONE-RECODE-DELAY           0.285            ;default: 0.285      : Recoding delay for tone sound content.
		;:SOUND-DECAY-TIME            3.0              ;default: 3.0        : The amount of time after a sound has finished it takes for the sound to be deleted from the audicon
		;:HEAR-NEWEST-ONLY            NIL              ;default: NIL        : Whether to stuff only the newest unattended audio-event from the audicon into the aural-location buffer.
		;:TONE-DETECT-DELAY           0.05             ;default: 0.05       : Lag between sound onset and detectability for tones
		;:DIGIT-RECODE-DELAY          0.5              ;default: 0.5        : Recoding delay for digit sound content.
		;:DIGIT-DURATION              0.6              ;default: 0.6        : Default duration for digit sounds.
		;:DIGIT-DETECT-DELAY          0.3              ;default: 0.3        : Lag between onset and detectability for digits
		;--------------------------------
		;SPEECH module
		;--------------------------------
		;:SYLLABLE-RATE               0.15             ;default: 0.15       : Seconds per syllable.
		;:SUBVOCALIZE-DETECT-DELAY    0.3              ;default: 0.3        : Sound detect time for a subvocalized word.
		;:CHAR-PER-SYLLABLE           3                ;default: 3          : Characters per syllable.
		;--------------------------------
		;PRINTING-MODULE module
		;--------------------------------
		;:CMDT                        T                ;default: T          : Commands trace controls output of commands
		;:SHOW-ALL-SLOTS              NIL              ;default: NIL        : Whether or not to show unfilled extended slots when printing chunks
		;:TRACE-FILTER                NIL              ;default: NIL        : Function to limit output shown in the trace
		;:TRACE-DETAIL                HIGH             ;default: MEDIUM     : Determines which events show in the trace
		:MODEL-WARNINGS               NIL              ;default: T          : Whether to output model warnings
		:V                           T                ;default: T          : Verbose controls model output
		;:CBCT                        NIL              ;default: NIL        : Whether or not to show an event in the trace when a buffer copies a chunk
		;--------------------------------
		;IMAGINAL module
		;--------------------------------
		;:IMAGINAL-DELAY              0.2              ;default: 0.2        : Time in seconds to respond to an imaginal request
		;:VIDT                        NIL              ;default: NIL        : Variable Imaginal Delay Time
		;--------------------------------
		;MOTOR module
		;--------------------------------
		;:MIN-FITTS-TIME              0.1              ;default: 0.1        : Minimum movement time for an aimed [Fitts's] movement.
		;:CURSOR-NOISE                NIL              ;default: NIL        : Is there noise in the final cursor location.
		;:MOTOR-FEATURE-PREP-TIME     0.05             ;default: 0.05       : Time to prepare a movement feature.
		;:INCREMENTAL-MOUSE-MOVES     NIL              ;default: NIL        : Output mouse moves in stages?
		;:MOTOR-BURST-TIME            0.05             ;default: 0.05       : Minimum time for any movement.
		;:MOTOR-INITIATION-TIME       0.05             ;default: 0.05       : Time to initiate a motor movement.
		;:PECK-FITTS-COEFF            0.075            ;default: 0.075      : b coefficient in Fitts's equation for PECK movements.
		;:DEFAULT-TARGET-WIDTH        1.0              ;default: 1.0        : Effective width, in degrees visual angle, of targets with undefined widths.
		)
  
  (chunk-type number
	number
	non-dominant-index  
        non-dominant-middle 
        non-dominant-ring    
        non-dominant-little  
        dominant-index  
        dominant-middle
        dominant-ring   
        dominant-little 
        non-dominant-thumb 
        dominant-thumb)
(chunk-type air-typing start end count temp eval)


  (add-dm
 (n0 ISA number  number 0
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        non-dominant-thumb   0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        dominant-thumb  0
)
 
 (n1 ISA number number 1
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)
    
    ; Number 2: Right index and middle fingers
    (n2 ISA number number 2
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 1
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)

 
 
; Number 3: Right index, middle, and ring fingers
    (n3 ISA number number 3
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 1
        dominant-ring   1
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)

    ; Number 4: All fingers on the right hand except thumb
    (n4 ISA number number 4
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 1
        dominant-ring   1
        dominant-little 1
        non-dominant-thumb   0
        dominant-thumb  0)
    
 ; Number 5: Right thumb
    (n5 ISA number number 5
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  1)

    ; Number 6: Right thumb, right index
    (n6 ISA number number 6
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  1)

    ; Number 7: Right thumb, right index and middle
    (n7 ISA number number 7
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 1
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  1)

    ; Number 8: Right thumb, right index, middle and ring
    (n8 ISA number number 8
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 1
        dominant-ring   1
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  1)

    ; Number 9: Right thumb, all fingers on right hand
    (n9 ISA number number 9
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  1
        dominant-middle 1
        dominant-ring   1
        dominant-little 1
        non-dominant-thumb   0
        dominant-thumb  1)

    ; Number 10: Left index finger
    (n10 ISA number number 10
        non-dominant-index   1
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)

 

    ; Number 20: Left index and middle fingers
    (n20 ISA number number 20
        non-dominant-index   1
        non-dominant-middle  1
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)

 


    (n30 ISA number number 30
        non-dominant-index   1
        non-dominant-middle  1
        non-dominant-ring    1
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)
 

   

     (n40 ISA number number 40
        non-dominant-index   1
        non-dominant-middle  1
        non-dominant-ring    1
        non-dominant-little  1
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   0
        dominant-thumb  0)
 


     (n50 ISA number number 50
        non-dominant-index   0
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   1
        dominant-thumb  0)
 
 
 
 
     (n60 ISA number number 60
        non-dominant-index   1
        non-dominant-middle  0
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   1
        dominant-thumb  0)


 
  
     (n70 ISA number number 70
        non-dominant-index   1
        non-dominant-middle  1
        non-dominant-ring    0
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   1
        dominant-thumb  0)


   

 
 
      (n80 ISA number number 80
        non-dominant-index   1
        non-dominant-middle  1
        non-dominant-ring    1
        non-dominant-little  0
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   1
        dominant-thumb  0)

  
  

       (n90 ISA number number 90
        non-dominant-index   1
        non-dominant-middle  1
        non-dominant-ring    1
        non-dominant-little  1
        dominant-index  0
        dominant-middle 0
        dominant-ring   0
        dominant-little 0
        non-dominant-thumb   1
        dominant-thumb  0)


 
  
     (first-goal ISA air-typing start 0 end 100)
 
)



  (goal-focus first-goal)
; 20 production rules for 20 random numbers (i.e., gestuers)
; 
  

(p start
   =goal>
   ISA         air-typing
   start      =num
   count      nil
   temp       nil
   eval       nil
   ==>
      !output! (Start Now!)
;      !bind!   =y(random-from-set)
;      !output! (=y tens)
;      !bind!   =x(act-r-random 10)
;      !output! (=x units)
;      !bind!   =g (+ =y =x )
 ;     !output! (=g Value)
      !bind!   =f(act-r-random 100)
      !output! (=f Value)
      !bind!   =y(get-tens =f)
      !output! (=y tens)
      !bind!   =x(get-units =f)
      !output! (=x units)

      
;     !output! (=x)
 ;     !output! (=z)
;   !output! (=tens)
   =goal>
   ISA      air-typing
   count    =num
   temp     =x
   eval     =x
   +retrieval>
      ISA         number
      number      =y
;   number     =num0
      )


(p Non-dominant
   =goal>
   ISA         air-typing
   count          =num
   - end          =num
   temp           =num11
   - eval         nil
   =retrieval>
   ISA         number
   number      =num0
   non-dominant-thumb =num6
   non-dominant-index =num7
   non-dominant-middle =num8
   non-dominant-ring   =num9
   non-dominant-little =num10

   ==>
   =goal>
   ISA air-typing
   eval           nil
   !output!       (=num0 value)
   !output!       (=num6  non-dominant-thumb)
   !output!       (=num7 non-dominant-index)
   !output!       (=num8  non-dominant-middle)
   !output!       (=num9 non-dominant-ring)
   !output!       (=num10  non-dominant-little)
;   count    =z
   +retrieval>
   ISA         number
   number      =num11
    
   )


  (p Dominant
   =goal>
   ISA         air-typing
   count          =num
   - end          =num
   eval           nil
   =retrieval>
   ISA         number
   number      =num0
   dominant-little  =num1
   dominant-ring   =num2
   dominant-middle =num3
   dominant-index  =num4
   dominant-thumb  =num5

   ==>
      !bind!   =f(act-r-random 100)
 ;     !output! (=f Value)
      !bind!   =y(get-tens =f)
;      !output! (=y tens)
      !bind!   =x(get-units =f)
 ;     !output! (=x units)

;   !bind!   =y(random-from-set)
;   !bind!   =x(act-r-random 10)
   =goal>
   ISA air-typing
   temp     =x
   eval     =x
   count         =z
   !output!       (=num0 value)
   !output!       (=num1 dominant-little)
   !output!       ( =num2 dominant-ring)
   !output!       (=num3 dominant-middle)
   !output!       (=num4 dominant-index)
   !output!       (=num5 dominant-thumb)
   !bind!      =z (+ =num 1)
   !output! (=z times)

 ;  !bind!   =g (+ =y =x )
 ;  !output! (=g Value)



   +retrieval>
   ISA         number
   number      =y
   !output!  (NEXT!)
;   !bind!   =g (+ =y =x )
;   !output! (=y tens)
					;   !output! (=x units)
   !output! (=f Value)
   !output! (=y tens)
   !output! (=x units)




   )
  )



(run 1000)
