; *** CNC Kitchen Auto Flow Pattern Generator 0.93

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
; retractionDistance = 8
; retractionSpeed = 60
; blobHeight = 10
; extrusionAmount = 200
; xSpacing = 40
; ySpacing = 30
; startFlow = 2
; flowOffset = 2
; flowSteps = 8
; startTemp = 220
; tempOffset = 10
; tempSteps = 3
; direction = 1


;####### Start Gcode
;E7 Klipper start macro
PRINT_START
M104 S200
M140 S60

; [SAFETY] Force Relative Extrusion
M83 ; set extruder to relative mode

;####### 220C
G4 S0 ; Dwell
M109 S220

;####### 2mm3/s
M117 220°C // 2mm3/s
G0 X5 Y5 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F2.49 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y5 F6000
G92 E0 ; Reset Extruder

;####### 4mm3/s
M117 220°C // 4mm3/s
G0 X5 Y35 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F4.99 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y35 F6000
G92 E0 ; Reset Extruder

;####### 6mm3/s
M117 220°C // 6mm3/s
G0 X5 Y65 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F7.48 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y65 F6000
G92 E0 ; Reset Extruder

;####### 8mm3/s
M117 220°C // 8mm3/s
G0 X5 Y95 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F9.98 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y95 F6000
G92 E0 ; Reset Extruder

;####### 10mm3/s
M117 220°C // 10mm3/s
G0 X5 Y125 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y125 F6000
G92 E0 ; Reset Extruder

;####### 12mm3/s
M117 220°C // 12mm3/s
G0 X5 Y155 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y155 F6000
G92 E0 ; Reset Extruder

;####### 14mm3/s
M117 220°C // 14mm3/s
G0 X5 Y185 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y185 F6000
G92 E0 ; Reset Extruder

;####### 16mm3/s
M117 220°C // 16mm3/s
G0 X5 Y215 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X30 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X45 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F19.96 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X5 Y215 F6000
G92 E0 ; Reset Extruder

;####### 230C
G4 S0 ; Dwell
M109 S230

;####### 2mm3/s
M117 210°C // 2mm3/s
G0 X85 Y5 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F2.49 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y5 F6000
G92 E0 ; Reset Extruder

;####### 4mm3/s
M117 210°C // 4mm3/s
G0 X85 Y35 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F4.99 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y35 F6000
G92 E0 ; Reset Extruder

;####### 6mm3/s
M117 210°C // 6mm3/s
G0 X85 Y65 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F7.48 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y65 F6000
G92 E0 ; Reset Extruder

;####### 8mm3/s
M117 210°C // 8mm3/s
G0 X85 Y95 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F9.98 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y95 F6000
G92 E0 ; Reset Extruder

;####### 10mm3/s
M117 210°C // 10mm3/s
G0 X85 Y125 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y125 F6000
G92 E0 ; Reset Extruder

;####### 12mm3/s
M117 210°C // 12mm3/s
G0 X85 Y155 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y155 F6000
G92 E0 ; Reset Extruder

;####### 14mm3/s
M117 210°C // 14mm3/s
G0 X85 Y185 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y185 F6000
G92 E0 ; Reset Extruder

;####### 16mm3/s
M117 210°C // 16mm3/s
G0 X85 Y215 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X110 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X125 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F19.96 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X85 Y215 F6000
G92 E0 ; Reset Extruder

;####### 240C
G4 S0 ; Dwell
M109 S240

;####### 2mm3/s
M117 200°C // 2mm3/s
G0 X165 Y5 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F2.49 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y5 F6000
G92 E0 ; Reset Extruder

;####### 4mm3/s
M117 200°C // 4mm3/s
G0 X165 Y35 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F4.99 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y35 F6000
G92 E0 ; Reset Extruder

;####### 6mm3/s
M117 200°C // 6mm3/s
G0 X165 Y65 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F7.48 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y65 F6000
G92 E0 ; Reset Extruder

;####### 8mm3/s
M117 200°C // 8mm3/s
G0 X165 Y95 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F9.98 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y95 F6000
G92 E0 ; Reset Extruder

;####### 10mm3/s
M117 200°C // 10mm3/s
G0 X165 Y125 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F12.47 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y125 F6000
G92 E0 ; Reset Extruder

;####### 12mm3/s
M117 200°C // 12mm3/s
G0 X165 Y155 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F14.97 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y155 F6000
G92 E0 ; Reset Extruder

;####### 14mm3/s
M117 200°C // 14mm3/s
G0 X165 Y185 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F17.46 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y185 F6000
G92 E0 ; Reset Extruder

;####### 16mm3/s
M117 200°C // 16mm3/s
G0 X165 Y215 Z15.5 F6000
G4 S20; Stabalize
G0 Z0.3 ; Drop down
G1 X190 E20 F300 ;Prime
G1 E-8 F3600; Retract
G0 X205 F6000 ; Wipe
G0 Z0.5 ; Lift
G1 E8 F3600 ; De-Retract
G1 Z10.5 E200 F19.96 ; Extrude
G1 E-8 F3600 ; Retract
G0 Z15.5; Lift
G0 X165 Y215 F6000
G92 E0 ; Reset Extruder

;####### End G-Code
;G0 X245 Y245 ; Move to Corner
;M104 S0 T0 ; Turn Off Hotend
;M140 S0 ; Turn Off Bed
;M84

;####### End Klipper Gcode
PRINT_STOP