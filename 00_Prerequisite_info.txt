## Ender 7 Machine Info (prior to Klipper install)
- Board: Creality CR-FDM-v2.4.S1_v101
  - Power input: 24v
  - Processor: ARM® Cortex®-M3 STM32F1 Microcontroller IC 32-Bit Single-Core 72MHz 512KB (512K x 8) FLASH
    - STM32F103RET6
    - 32bit
    
### Ender-7 (Marlin 1 - Command Output)
M503                                                             # Report Settings
Recv:   G21    ; Units in mm (mm)
Recv: 
Recv:   M200 S0 D1.75                                          #M200 - Set Filament Diameter
Recv:   M92 X200.00 Y200.00 Z400.00 E140.00                    #M92  - Set Axis Steps-per-unit
Recv:   M203 X500.00 Y500.00 Z10.00 E60.00                     #M203 - Set Max Feedrate
Recv:   M201 X500.00 Y500.00 Z100.00 E5000.00                  #M201 - Print Move Limits
Recv:   M204 P500.00 R1000.00 T500.00                          #M204 - Set Starting Acceleration
Recv:   M205 B20000.00 S0.00 T0.00 X8.00 Y8.00 Z0.40 E5.00     #M205 - Set Advanced Settings [B -Minimum segment time (µs)][S -Minimum feedrate for print moves (units/s)][T -Minimum feedrate for travel moves (units/s)][X -X max jerk (units/s)][Y -Y max jerk (units/s)][Z -Z max jerk (units/s)][E -E max jerk (units/s)]
Recv:   M206 X0.00 Y0.00 Z0.00                                 #M206 - Set Home Offsets
Recv:   M420 S1 Z10.00                                         #M420 - Bed Leveling State [S -Set enabled or disabled][Z -Set Z fade height (Requires ENABLE_LEVELING_FADE_HEIGHT)]
Recv:   M301 P12.50 I0.70 D60.00                               #M301 - Set Hotend PID [P -Proportional value][I -Integral value][D -Derivative value]
Recv:   M304 P327.11 I19.20 D1393.45                           #M304 - Set Bed PID
Recv:   M413 S0                                                #M413 - Power-loss Recovery
Recv:   M851 X30.00 Y27.00 Z-2.60                              #M851 - XYZ Probe Offset

### CR-FDM-v2.4.S1_v101 Pinout (hardware names)
  - [! preceding name to indicate reverse polarity] [^ preceding hardware pull-up resistor] [~ preceding hardware pull-down resistor]
[stepper_x]
step_pin: PC2
dir_pin: PB9
enable_pin: !PC3
endstop_pin: ^PA5

[stepper_y]
step_pin: PB8
dir_pin: !PB7
enable_pin: !PC3
endstop_pin: ^PA6

[stepper_z]
step_pin: PB6
dir_pin: PB5
enable_pin: !PC3
endstop_pin: ^PA7

[extruder]
step_pin: PB4
dir_pin: !PB3
enable_pin: !PC3
heater_pin: PA1
sensor_pin: PC5

[heater_bed]
heater_pin: PA15
sensor_pin: PC4

[fan]
pin: PA0

[filament_switch_sensor filament_sensor]
switch_pin: !PA4

[bltouch]
sensor_pin: ^PB1
control_pin: PB0
 
 
