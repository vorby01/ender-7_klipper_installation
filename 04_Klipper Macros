## Klipper Macros
  - Create macros.cfg
    - macros can be nested in printer.cfg but simpler to seperate file for ease of use
    
//**macros.cfg**\\
[gcode_macro PRINT_START]
gcode:
  {% set BED_TEMP = params.BED_TEMP|default(60)|float %}                # Extract bed temp from gcode as variable
  {% set EXTRUDER_TEMP = params.EXTRUDER_TEMP|default(220)|float %}     # Extract extruder temp from gcode as variable
  G90                           # Use absolute coordinates
  SET_GCODE_OFFSET Z=0.0        # Reset the g-code z offset
  M83                           # Extruder relative mode
  M107                          # Set fan off
  G28                           # Home printer axis
  M104 S150                     # preheat extruder, minimise oozing
  M190 S{BED_TEMP}              # Set and wait for bed heating
  BED_MESH_CALIBRATE            # Automatic bed leveling
  G1 Z50 F240                   # Move z_axis down to 50mm
  M109 S{EXTRUDER_TEMP}         # Set and wait for hotend heating
  #Prime Nozzle (On build plate left)
  G1 X2 Y10 F3000               # Move x,y axis
  G1 Z0.28 F240                 # Move z axis
  G92 E0                        # reset extruder distance to 0
  G1 X2.0 Y140 E10 F1500        # first pass prime
  G1 X2.3 Y140 F5000            # offset
  G92 E0                        # reset extruder distance to 0
  G1 X2.3 Y10 E10 F1200         # second pass prime
  G92 E0                        # reset extruder distance to 0

[gcode_macro PRINT_STOP]
gcode:
  G91                           # Use relative coordinates
  G1 Z10                        # Lower z axis by 10mm
  G28 X Y                       # Move gantry out of way to home
  M140 S0                       # turn off heatbed
  M104 S0                       # turn off temperature
  M107                          # turn off fan
  #M84 X Y E                    # disable motors (will require re-homing axis)
  #M84                          # disable all motors (will require re-homing axis)

[gcode_macro CANCEL_PRINT]
description: Cancel running print
rename_existing: CANCEL_PRINT_BASE
gcode:
  TURN_OFF_HEATERS
  CANCEL_PRINT_BASE
  G91                           # Use relative coordinates
  G1 Z10                        # Lower z axis by 10mm
  G90                           # Use absolute coordinates
  G28 X Y                       # Move gantry out of way to home
  #M84                          # Disable all motors (will require re-homing axis)
//**macros.cfg**\\

  - Upload macros.cfg to Klipper
    - Mainsail_os > settings > machine > config files > upload file > macros.cfg
  
  - Update printer.cfg to include macros.cfg
    - append: [include macros.cfg]
    - save and restart


### Update PrusaSlicer for use with Klipper

- PrusaSlicer Start g-code
//**start gcode**\\
;E7 Klipper start macro
M104 S0
M140 S0
PRINT_START EXTRUDER_TEMP={first_layer_temperature[0]} BED_TEMP={first_layer_bed_temperature[0]}
//**start gcode**\\

- PrusaSlicer End g-code
//**end gcode**\\
;E7 Klipper stop macro
PRINT_STOP
//**end gcode**\\

