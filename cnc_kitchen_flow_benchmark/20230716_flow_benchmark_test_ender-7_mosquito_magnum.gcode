; *** CNC Kitchen Auto Flow Pattern Generator 0.93
;Adapted for klipper

;####### Settings
; Ender-7
; bedWidth = 250
; bedLength = 250
; bedMargin = 5
; filamentDiameter = 1.75
; movementSpeed = 100
; stabilizationTime = 20
; bedTemp = 60
; primeLength = 25
; primeAmount = 20
; primeSpeed = 5
; retractionDistance = 1
; retractionSpeed = 35
; blobHeight = 10
; extrusionAmount = 200
; xSpacing = 45
; ySpacing = 30
; startFlow = 10
; flowOffset = 2
; flowSteps = 8
; startTemp = 220
; tempOffset = 10
; tempSteps = 3
; direction = 1

;E7 Klipper start macro
PRINT_START
M104 S200
M140 S60
;[SAFETY] Force Relative Extrusion
M83 ; set extruder to relative mode

;####### 220C
G4 S0 ; Dwell
M109 S220

;####### 10mm3/s
M117 220°C // 10mm3/s
G0 X5 Y5 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y5 F6000
G92 E0 ; Reset Extruder

;####### 12mm3/s
M117 220°C // 12mm3/s
G0 X5 Y35 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y35 F6000
G92 E0 ; Reset Extruder

;####### 14mm3/s
M117 220°C // 14mm3/s
G0 X5 Y65 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y65 F6000
G92 E0 ; Reset Extruder

;####### 16mm3/s
M117 220°C // 16mm3/s
G0 X5 Y95 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F19.96 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y95 F6000
G92 E0 ; Reset Extruder

;####### 18mm3/s
M117 220°C // 18mm3/s
G0 X5 Y125 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F22.45 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y125 F6000
G92 E0 ; Reset Extruder

;####### 20mm3/s
M117 220°C // 20mm3/s
G0 X5 Y155 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F24.95 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y155 F6000
G92 E0 ; Reset Extruder

;####### 22mm3/s
M117 220°C // 22mm3/s
G0 X5 Y185 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F27.44 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y185 F6000
G92 E0 ; Reset Extruder

;####### 24mm3/s
M117 220°C // 24mm3/s
G0 X5 Y215 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F29.93 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X5 Y215 F6000
G92 E0 ; Reset Extruder

;####### 210C
G4 S0 ; Dwell
M109 S210

;####### 10mm3/s
M117 210°C // 10mm3/s
G0 X90 Y5 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y5 F6000
G92 E0 ; Reset Extruder

;####### 12mm3/s
M117 210°C // 12mm3/s
G0 X90 Y35 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y35 F6000
G92 E0 ; Reset Extruder

;####### 14mm3/s
M117 210°C // 14mm3/s
G0 X90 Y65 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y65 F6000
G92 E0 ; Reset Extruder

;####### 16mm3/s
M117 210°C // 16mm3/s
G0 X90 Y95 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F19.96 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y95 F6000
G92 E0 ; Reset Extruder

;####### 18mm3/s
M117 210°C // 18mm3/s
G0 X90 Y125 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F22.45 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y125 F6000
G92 E0 ; Reset Extruder

;####### 20mm3/s
M117 210°C // 20mm3/s
G0 X90 Y155 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F24.95 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y155 F6000
G92 E0 ; Reset Extruder

;####### 22mm3/s
M117 210°C // 22mm3/s
G0 X90 Y185 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F27.44 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y185 F6000
G92 E0 ; Reset Extruder

;####### 24mm3/s
M117 210°C // 24mm3/s
G0 X90 Y215 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X115 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X130 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F29.93 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X90 Y215 F6000
G92 E0 ; Reset Extruder

;####### 200C
G4 S0 ; Dwell
M109 S200

;####### 10mm3/s
M117 200°C // 10mm3/s
G0 X175 Y5 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y5 F6000
G92 E0 ; Reset Extruder

;####### 12mm3/s
M117 200°C // 12mm3/s
G0 X175 Y35 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y35 F6000
G92 E0 ; Reset Extruder

;####### 14mm3/s
M117 200°C // 14mm3/s
G0 X175 Y65 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y65 F6000
G92 E0 ; Reset Extruder

;####### 16mm3/s
M117 200°C // 16mm3/s
G0 X175 Y95 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F19.96 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y95 F6000
G92 E0 ; Reset Extruder

;####### 18mm3/s
M117 200°C // 18mm3/s
G0 X175 Y125 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F22.45 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y125 F6000
G92 E0 ; Reset Extruder

;####### 20mm3/s
M117 200°C // 20mm3/s
G0 X175 Y155 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F24.95 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y155 F6000
G92 E0 ; Reset Extruder

;####### 22mm3/s
M117 200°C // 22mm3/s
G0 X175 Y185 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F27.44 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y185 F6000
G92 E0 ; Reset Extruder

;####### 24mm3/s
M117 200°C // 24mm3/s
G0 X175 Y215 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X200 E20 F300 ;Prime
G1 E-1 F2100; Retract
G0 X215 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E1 F2100 ; De-Retract
G1 Z10.5 E200 F29.93 ; Extrude
G1 E-1 F2100 ; Retract
G0 Z15.5; Lift
G0 X175 Y215 F6000
G92 E0 ; Reset Extruder

;####### End G-Code
PRINT_STOP
