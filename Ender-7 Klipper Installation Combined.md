# Ender-7 Klipper Installation

----------------------------------------------------------------------------------------------------

## 00_Prerequisite info

### Ender-7 Hardware Information
- Board: Creality CR-FDM-v2.4.S1_v101
  - Power input: 24v
  - Processor: ARM® Cortex®-M3 STM32F1 Microcontroller IC 32-Bit Single-Core 72MHz 512KB (512K x 8) FLASH
    - STM32F103RET6
    - 32bit
    
### Ender-7 Firmware Information (Marlin 1 - Command Output) (Prior to Klipper install)
Command for output from printer serial connection:  
`M503                                                             # Report Settings`

```
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
```

### CR-FDM-v2.4.S1_v101 Pinout (hardware names)
> [! preceding name to indicate reverse polarity]  
> [^ preceding hardware pull-up resistor]  
> [~ preceding hardware pull-down resistor]  

```
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
```

----------------------------------------------------------------------------------------------------

## 01_Install mainsailOS

### Install mainsailOS

#### Raspberry Pi Imager (Flash microSD card)
> Choose OS > Other specific-purpose OS > 3D printing > Mainsail OS

```
- hostname: mainsail
- enable ssh
- user: pi
- pwd: <password>
- configure/set wireless network settings
```

#### On mainsailOS First Boot
- Wait for file system to expand
- Log in to web interface
  - Update components from web interface
    > settings > machine > Update Manager

----------------------------------------------------------------------------------------------------

## 02_Klipper configuration and install

> Connect usb cable connected from RPi to printer for serial connection (serial console)

1. ### Connect with SSH to RPi4 running MainsailOS
   `ssh pi@<ip_address>`

2. ### Confirm printer serial COM port name (2023)
   `ls /dev/serial/by-id/*`

   > output: /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0

   > COM port name may change after software update, may require microcontroller to be reflashed
   > - `sudo dmesg -w | grep tty` Shows kernal buffer, will display device connect/disconnect messages (device unplug/plug)
   > - Identify usb serial port (ttyUSB0)

3. ### Connect to Mainsail web interface and create klipper configuration
   Create printer.cfg for Klipper (/home/pi/printer_data/config/printer.cfg)
   > Machine > Create File > printer.cfg

**printer.cfg** (minimum config with bltouch)
```
[include mainsail.cfg]

[mcu]
serial: /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0
restart_method: command
#baud: 250000

[printer]
kinematics: corexy
max_velocity: 500          # max feedrate (E7:500)(Other:300)
max_accel: 3000
max_z_velocity: 10
max_z_accel: 100

[stepper_x]
step_pin: PC2
dir_pin: PB9
enable_pin: !PC3
rotation_distance: 32
microsteps: 32
endstop_pin: ^PA5
position_endstop: 0
position_max: 250
homing_speed: 50

[stepper_y]
step_pin: PB8
dir_pin: !PB7
enable_pin: !PC3
rotation_distance: 32
microsteps: 32
endstop_pin: ^PA6
position_endstop: 250
position_max: 250
homing_speed: 50

[stepper_z]
step_pin: PB6
dir_pin: PB5
enable_pin: !PC3
rotation_distance: 8
microsteps: 16
#endstop_pin: ^PA7                            # disable to use BLTouch
#position_endstop: 3.0                        # disable to use BLTouch
endstop_pin: probe:z_virtual_endstop          # enable to use BLTouch
position_min: -3.5                            # enable to use BLTouch
position_max: 300

[extruder]
step_pin: PB4
dir_pin: !PB3
enable_pin: !PC3
microsteps: 16
rotation_distance: 23.564                    # Re-tune to suit
full_steps_per_rotation: 200
nozzle_diameter: 0.400
filament_diameter: 1.750
max_extrude_only_distance: 200.0
pressure_advance = 0                         # 0 to disable
#HOT END VARIABLES
heater_pin: PA1
sensor_type: EPCOS 100K B57560G104F
sensor_pin: PC5
#control: pid                                #(PID_CALIBRATE HEATER=extruder TARGET=200)
pid_kp = 74.327                              # updated after PID_CALIBRATE
pid_ki = 0.985                               # updated after PID_CALIBRATE
pid_kd = 1401.994                            # updated after PID_CALIBRATE
min_temp: 0
max_temp: 230

[heater_bed]
heater_pin: PA15
sensor_type: EPCOS 100K B57560G104F
sensor_pin: PC4
#control: pid                                #(PID_CALIBRATE HEATER=heater_bed TARGET=60)
pid_kp = 19.588                              # updated after PID_CALIBRATE
pid_ki = 1.005                               # updated after PID_CALIBRATE
pid_kd = 95.493                              # updated after PID_CALIBRATE
min_temp: 0
max_temp: 75

[fan]
pin: PA0          # Hotend additional fans

[filament_switch_sensor filament_sensor]
pause_on_runout: true
switch_pin: !PA4

[bltouch]                 # enable for BLTouch (requires self_test after each firmware restart)
sensor_pin: ^PB1
control_pin: PB0
z_offset: 2.550          # initial safe value, get correct value by PROBE_CALIBRATE
x_offset: -28.28
y_offset: -28.28

[safe_z_home]                       # BLTouch home x,y axis then move to centre and home z
home_xy_position: 125, 125          # Change coordinates to the center of your print bed
speed: 50
z_hop: 10                           # Move up 10mm
z_hop_speed: 5

[bed_mesh]
speed: 120
horizontal_move_z: 10       #lift z between movements
mesh_min: -25, -25          # x, y (x: 0-28.28=-28.28, -28.28+250= 221.72)
mesh_max: 190, 190
probe_count: 4
```

4. ### Create Klipper.bin and flash to microcontroller (printer)

   > ### 20230508 update, lost connection to mainboard
   > - USB serial port changed after software update
   > - `sudo dmesg -w | grep tty` Shows kernal buffer, will display device connect/disconnect messages (device unplug/plug)
   > - Locate new usb serial (ttyUSB0)
   > - update printer.cfg serial: ***/dev/ttyUSB0***

   #### Navigate to Klipper directory
   `cd ~/klipper/`

   #### Klipper configure microcontroller firmware
   `make menuconfig`
   > !PA15 required to prevent bed heater turning on automatically at printer start

   ```
   [*] Enable extra low-level configuration options
       Micro-controller Architecture (STMicroelectronics STM32) --->
       Processor model (STM32F103) --->
   [ ] Disable SWD at startup (for GigaDevice stm32f103 clones)
       Bootloader offset (28Kib bootloader) --->
       Clock Reference (8 MHz crystal) --->
       Communication interface (Serial (on USART1 PA10/PA9)) --->
   (250000) Baud rate for serial port
   (!PA15) GPIO pins to set at micro-controller startup
   ```

   #### Compile Klipper firmware for microcontroller
   Stop Klipper service:  
   `sudo service klipper stop`

   Compile firmware: (output current directory)  
   `make`
   > File output: ~/klipper/out/klipper.bin

   Start Klipper service:  
   `sudo service klipper start`

   > #### Recommended to retrive printer settings with M503 before flashing to aid in configuration after flashing Klipper
   >    Example:  
   >   `M503, M92 X200.00 Y200.00 Z400.00 E140.00, Axis Steps-per-unit (e-steps)`

5. ### Flash firmware to microcontroller
   a. Download compiled firmware (klipper.bin) from RPi to local machine for transfer to microSD card
      > WinSCP - GUI SSH File transfer client for windows
      >> download: ~/klipper/out/klipper.bin

   b. Rename klipper.bin to unique filename (must not match any previous filename)(add date)

   c. Upload klipper.bin to micro-sd card

   d. With printer off ensure usb cable is disconnected (nothing connected during flashing)

   e. Insert micro-sd card and turn printer on

   f. Wait for board to flash (wait several min) (screen will no longer display current status)

   g. Connect usb and login to mainsailOS web interface to confirm flashing is complete

### DO NOT PRINT yet still need to test and calibrate

----------------------------------------------------------------------------------------------------

## 03_Testing and calibration

### Thoroughly test printer (warning can crash printer, be ready to turn of power if somthing goes wrong)

#### Checklist  
- [ ] Individually check heated bed and hotend temps (set small values and check if temp readings are as expected)
- [ ] Check functionality of all endstops
- [ ] Check homing
- [ ] Check extruder operation(direction)
- [ ] Perform PID tuning for heated bed and hotend
- [ ] Check your extruder is able to extrude the instructed amount of filament 
  - [ ] Calibrate e-steps
  - [ ] Calibrate flow rate

### Login to MainsailOS web interface and issue commands

1. #### Test bed heater

   #### Set heater_bed temp check heat then turn off and check for cool down (safe operation)
   `SET_HEATER_TEMPERATURE HEATER=heater_bed TARGET=30`

   `SET_HEATER_TEMPERATURE HEATER=heater_bed TARGET=0`

   ### Set heater_bed temp check heat then turn off and check for cool down (safe operation)
   `SET_HEATER_TEMPERATURE HEATER=extruder TARGET=50`

   `SET_HEATER_TEMPERATURE HEATER=extruder TARGET=0`

2. #### Check endstops operation (with BLTouch)
   - Disable motors  
     `M83`
     - Manually move print head away from end stops to center
     - Manually lower print bed out of way

   - Check endstops status  
     `QUERY_ENDSTOPS`
     > output: x:open y:open z:open

   - Manually press and hold each endstop switch (X,Y) and check operation
     `QUERY_ENDSTOPS`
     > output: x:triggered y:triggered z:open

   - Test BLTouch operation (Z axis)  
     `bltouch_debug command=pin_down`
     > pin goes down, light goes off

     `bltouch_debug command=pin_up`
     > pin goes up, red light goes on

   - Test BLTouch Z endstop operation  
     `bltouch_debug command=pin_down`  
     `bltouch_debug command=touch_mode`  
     `query_probe`
     > return: probe: open

   - Slightly press and hold bltouch probe so it lights up but does not fully retract and query  
     `query_probe`
     > return: probe: triggered

     `QUERY_ENDSTOPS`
     > return: x:open y:open z:triggered

   - If probe blinks (probe state error)  
     Reset probe if fault(blinking)  
     `bltouch_debug command=reset`

     `bltouch_debug command=self_test`
     > while test runs, pin goes down and up repeatedly, red light stays on

3. #### Check Homing
   - Verify stepper motor operation (Move axis 1mm back and forth 10 times)

     `STEPPER_BUZZ STEPPER=stepper_x`

     `STEPPER_BUZZ STEPPER=stepper_y`

     `STEPPER_BUZZ STEPPER=stepper_z`

   - Verify direction and homeing(endstop) per axis
     - Home X axis  
     `G28 x`
     - Home Y axis  
     `G28 y`
     - Home Z axis (Probe should drop first then bed will start moving)  
     `G28 z`
  
4. #### Calibrate Z offset
   `probe_calibrate`
   - Adjust z-offset (Peice of paper just dragging between nozzle and bed)

     `testz=-0.1`

     `testz=+0.1`

     > When happy with adjustment enter accept command in console  
     > `accept`

   - Verify accuracy of Z offset  
     `probe_accuracy`
     - 0.0125 or better, 0.025 no worse
     > output: standard deviation of 0.002077
      
5. #### Check extruder operation (direction) (no filament)
   - Set E to relative  
     `M83`

   - Extrude 100mm  
     `G1 E100 F100`

   - Retract 100mm  
     `G1 E-100 F100`

6. #### Perform PID tuning for heated bed and hotend 
   > #### Feed in filament so hotend is not empty for test

   `PID_CALIBRATE HEATER=heater_bed TARGET=60`
   > output: PID parameters: pid_Kp=74.515 pid_Ki=1.153 pid_Kd=1204.353

   `PID_CALIBRATE HEATER=extruder TARGET=200`
   > output: PID parameters: pid_Kp=21.862 pid_Ki=1.139 pid_Kd=104.939

   - When PID tuning complete save  
     `save_config`

7. #### Calibrate Extruder (Calibrate e-steps) (Klipper: rotation_distance)
   - ##### **Method_1** Obtaining rotation_distance from steps_per_mm (e-steps)(approximation)
     - Retrieve e-steps from firmware (Marlin) before flashing microcontroller with Klipper
       `M503`
       > output: M92 X200.00 Y200.00 Z400.00 E140.00
       >  - 140 e-steps

     - Calculate rotation distance
       - rotation_distance = `<full_steps_per_rotation> * <microsteps> / <steps_per_mm>`
       > - 1.8 degree motor (full rotation = 200 steps (360/1.8=200))
       > - 16 microsteps
       > - 200 * 16 / 140 = 22.857
       - rotation_distance = 22.857mm

   - ##### **Method_2** Obtaining rotation_distance from measure and trim
     - Heat extruder to 210C with filament (PLA)
     - Mark Filament at 100mm from intake to extruder
     - Mark Filament at 120mm from intake to extruder

     - Extrude 100mm filament (low speed minimul pressure in extruder)
       - Set Extruder relative  
         `G91`
       - Extrude 100mm  
         `G1 E100 F100`

     - Measure remaining distance to mark (120mm mark to beginning of extruder)
       > Remaining Measurement = 23mm

     - actual_extrude_distance = `<initial_mark_distance> - <subsequent_mark_distance>`
       > 120 - 23 = 97mm

     - Previous e-steps
       > 140 e-steps / 100mm = 1.4 step per mm

     - Current e-steps
       - Actual length extruded = `120mm – (Length from the extruder to mark after extruding)`
       > 120mm - 23mm = 97mm

     - Accurate steps/mm = `Old steps/mm × Actual length extruded`
       > 1.4steps/mm * 97mm = 135.8steps/mm

     - New rotation_distance for Klipper
       - rotation_distance = `<full_steps_per_rotation> * <microsteps> / <steps_per_mm>`
       > 200steps * (16microsteps / 135.8steps/mm) = 23.564mm

8. #### Calibrate flow rate (specific to each filament)
   - PrusaSlicer (extrusion multiplier)
     - Create/download a flow rate calibration model (50mm solid cube) and slice

     - Slicer print settings:
       - Layer Height: 0.2mm (or set to your normal printer layer height)
       > PrusaSlicer > print settings > layers and perimeters > Layer height

       - Line Width: 0.4 (wall thickness)
       > PrusaSlicer > print settings > advanced > default extrusion width

       - Wall Count(Perimeters): 1
       > PrusaSlicer > print settings > layers and perimeters > Perimeters

       - Infill Density: Set to 0%
       - Top layers: set to 0 to make cube hollow
       > PrusaSlicer > print settings > layers and perimeters > Solid layers > Top

       - Print Speed: Set to your normal wall printing speed
       > PrusaSlicer > print settings > layers and perimeters > Perimeters (default 40mm/s)

     - Slicer filament settings
       - PrusaSlicer Generic PLA
       > Nozzle, First Layer:215C, Other Layers:215C  
       > Bed,    First Layer:60C,  Other Layers:60C

   - **Print Model with settings above**

   - Measure each wall thickness at center on print with calipers
     > measurements: 0.36, 0.4, 0.39, 0.35
     - 0.36 + 0.4 + 0.39 + 0.35 = 1.5mm
     - 1.5 / 4 = 0.375mm average wall thickness

   - Calculate flow rate
     - New flow rate (%) = `(0.4 ÷ average wall width) × 100`
     - (0.4 / 0.375) * 100 = 106.667%
     - Extrusion Multiplier: 106.667% = 1.07

   - Update PrusaSlicer Extrusion Multiplier (recommended range: 0.9-1.1)
     > Filament Settings > Filament > Extrusion multiplier = 1.07

----------------------------------------------------------------------------------------------------

## 04_Klipper macros

### Klipper Macros
- Create macros.cfg
  > macros can be nested in printer.cfg but simpler to seperate file for ease of use

**macros.cfg**
```
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
```

- Upload macros.cfg to Klipper
  > Mainsail_os > settings > machine > config files > upload file > macros.cfg

- Update printer.cfg to include macros.cfg
  - append: [include macros.cfg]
  - save and restart (apply changes)


### Update PrusaSlicer for use with Klipper

- PrusaSlicer Start g-code

**start gcode**
```
;E7 Klipper start macro
M104 S0
M140 S0
PRINT_START EXTRUDER_TEMP={first_layer_temperature[0]} BED_TEMP={first_layer_bed_temperature[0]}
```

- PrusaSlicer End g-code

**end gcode**
```
;E7 Klipper stop macro
PRINT_STOP
```

----------------------------------------------------------------------------------------------------

## 05_Extruder maximum flow

### Determine extruder maximum flow rate(mm^3/s)(maximum printing speed)

##### **Method 1** (Estimate from extruder feed rate)(no consideration for quality)
- Maximum Feed rate/Melting rate (extruder)(issue commands from mainsailOS web interface)
  - Set e to relative  
    `M83`
  - Set and wait for nozzle temp (210C)(PLA)  
    `M109 S210`

- Increase the extrusion speed until the extruder starts to lose steps then take last value  
  Start at 1mm/s extrude 50mm (F60 = 60mm/min = 1mm/s)  

  | Command       | Feed rate |
  |---------------|---------  |
  | `G1 E50 F60`  | #1mm/s    |
  | `G1 E50 F120` | #2mm/s    |
  | `G1 E50 F180` | #3mm/s    |
  | `G1 E50 F240` | #4mm/s    |
  | `G1 E50 F300` | #5mm/s    |
  | `G1 E50 F360` | #6mm/s    |
  | `G1 E50 F420` | #7mm/s    |
  | `G1 E50 F480` | #8mm/s    |
  | `G1 E50 F540` | #9mm/s    |
  | `G1 E50 F600` | #10mm/s   | losing steps

- Convert mm/min to mm/sec
  - 540 / 60 = 9
  > Max feed rate = 9mm/sec

- Determine filament cross section
  - Diameter: 1.75mm
  - Radius = 1.75 / 2 = 0.875mm
  - Cross section = pi * 0.875^2 = 2.405mm^2

- #### Approximate maximum flow rate (theoretical limit)
  - maximum_flow_rate(mm^3/sec) = `<max_extrusion_speed(mm/sec)> * <filament_cross_section(mm^2)>`
  - 9 * 2.405 = 21.645mm^3/sec
  > Max flow rate = 21.645mm^3/sec

- #### Approximate max speed (theoretical limit)
  - Recommnded line width: `1.2 * nozzle`
  - 1.2 * 0.4 = 0.48mm
  - speed(mm/sec) = `<volumetric_flow(mm^3/sec)> / <layer_height(mm)> / <line_width(mm)>`
  - 21.645 / 0.2 / 0.48 = 225.469mm/sec
  > Max speed = 225.469mm/sec

- #### Approximate max volumetric flow (theoretical limit)
  - volumetric_flow(mm^3/sec) = `<speed(mm/sec)> * <layer_height(mm)> * <line_width(mm)>`
  - 225.469 * 0.2 * 0.48 = 21.645mm^3
  > Max volume = 21.645mm^3

##### **Method 2** Print and measure for maximum flow (based on actual printed quality)
- print model 20230124_external_speed_test_2_0.2mm_PLA_MINI_23m.gcode

- gcode details (nozzle: 0.4, line_width: 0.48, layer_height: 0.2, perimeters: 1, material: PLA, Temp_bed: 60, Temp_nozzle: 215)
| Height (mm)  | Perimeter speed |
|--------------|-----------------|
| 0-0.5        | 60mm/s  |
| 0.5-5        | 80mm/s  |
| 5-10         | 100mm/s |
| 10-15        | 120mm/s |
| 15-20        | 140mm/s |
| 20-25        | 160mm/s |
| 25-30        | 180mm/s |
| 30-35        | 200mm/s |
| 35-40        | 220mm/s |
| 40-45        | 240mm/s |
| 45-50        | 250mm/s |

- Measure from base up to where under extrusion begins
  - 25mm = 160mm/s

- Calculate maximum volumetric flow rate from measurement
  - 160 * 0.2 * 0.48 = 15.36mm^3/sec

- Confirm Calculation (speed)
  - 15.36 / 0.2 / 0.48 = 160mm/sec

- #### Max filament feed rate
  - 15.36 / 2.405 = 6.387mm/sec
  > Max feed rate = 6.387mm/sec

- #### Approximate maximum flow rate
  - maximum_flow_rate(mm^3/sec) = `<max_extrusion_speed(mm/sec)> * <filament_cross_section(mm^2)>`
  - 6.387mm/sec * 2.405mm^2 = 21.645mm^3/sec
  > Max flow rate = 15.361mm^3/sec

#### For more accurate flow rate calculation CNC Kitchen
- [CNC kitchen guide](https://www.cnckitchen.com/blog/extrusion-system-benchmark-tool-for-fast-prints "https://www.cnckitchen.com/blog/extrusion-system-benchmark-tool-for-fast-prints")
  - will require a milligram scale
- [Printables model](https://www.printables.com/model/160335-hotened-benchmark-test-g-codes "https://www.printables.com/model/160335-hotened-benchmark-test-g-codes")

----------------------------------------------------------------------------------------------------

## 06_Pressure advance

### Pressure Advance (advanced extrusion calibration)
- Requires e-steps/flow-rate calibration first
- Specific to each filament

- ##### Download Klipper pressure advance square tower
  - [Klipper pressure advance model](https://www.klipper3d.org/prints/square_tower.stl "https://www.klipper3d.org/prints/square_tower.stl")

- ##### Slicer settings (square_tower.stl) 
> - Zero infill
> - Coarse layer height (75% of nozzle diameter)(0.4 nozzle = 0.3 layer height)
> - Any kind of slicer dynamic acceleration is disabled
> - Use a high speed (eg,100mm/s) (prusaslicer default:40mm/s)(extruder max flow rate may need to measured first)

- ##### Prepare for test (klipper commands before starting print)
  `SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=1 ACCEL=500`

  - For direct drive extruder  
    `TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.005`
  - For long bowden extruders  
    `TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.020`

- ##### Print square_tower.stl
  - If corners are no longer printing well print can be cancelled

  - Measure with calipers from bottom of print to where corners look best
    - eg, height= 30mm

- ##### Calculate pressure advance (bowden)
  - pressure_advance = `<start> + <measured_height> * <factor>`
  - 0 + (30 * 0.02) = 0.6

  > Typical pressure advance values are between 0.050 and 1.000

- ##### Update printer.cfg with pressure advance value

**printer.cfg**
```
[extruder]
pressure_advance = 0.6
```

----------------------------------------------------------------------------------------------------

## 07_Resonance compensation

### Resonance compensation (requires ADXL345)
- Mount ADXL345 to print head securely
  - print mounting bracket: 20230216_ADXL345_Mount.3mf (printed on prusa_mini+)

- ##### ADXL345 to RaspberryPi4 wiring

| CAT5 cable colours
|--------|
| Green  | Green-White
| Orange | Orange-White
| Blue   | Blue-White
| Brown  | Brown-White

- Recommended twisted pairing (minimum interferance) (SPI wiring)
  - GND+MISO
  - 3.3V+MOSI
  - SCLK+CS

- Raspberry Pi Wiring
| RPi pinout
|-
| Pin | GPIO    | ADXL345 | SPI  | Colour | CAT5
| 17  | 3.3v    | VCC     | VCC  | RED    | Orange
| 19  | GPIO 10 | SDA     | MOSI | YELLOW | Orange-White
| 20  | GND     | GND     |      | BLACK  | Green-White
| 21  | GPIO 9  | SDO     | MISO | GREEN  | Green
| 23  | GPIO 11 | SCL     | SCLK | ORANGE | Blue-White
| 24  | GPIO 8  | CS      | CS   | BLUE   | Blue

- RPi4 to ADXL345 wiring (CAT5 pairs)
| ADXL345 pinout
|-
| ADXL345 | Colour | CAT5 Colour
|
| GND     | BLACK  | Green-White
| SDO     | GREEN  | Green
|
| 3.3     | RED    | Orange
| SDA     | YELLOW | Orange-White
|
| SCL     | ORANGE | Blue-White
| CS      | BLUE   | Blue

- ##### Additional required software installation
  - RPi SSH (Terminal)  
    `ssh pi@<ip_address>`

  `sudo apt update`  
  `sudo apt install python3-numpy python3-matplotlib libatlas-base-dev`  
  `~/klippy-env/bin/pip install -v numpy`

- ##### Ensure SPI is enabled  
  `sudo raspi-config`
  > interfacing options > enable SPI

- ##### Enable rpi host as secondary MCU in klipper (read ADXL345)
  - install start script (run klipper_mcu before klippy process)  
    `cd ~/klipper/`  
    `sudo cp ./scripts/klipper-mcu.service /etc/systemd/system/`  
    `sudo systemctl enable klipper-mcu.service`

  - Build and flash code for raspberry pi (dir: ~/klipper/)
    - Create configuration menu (open gui)  
      `make menuconfig`

    - Choose a processor model
      > select Linux process

      > quit and save

    - Stop Klipper service  
      `sudo service klipper stop`

    - Flash Raspberry Pi as secondary mcu  
      `make flash`
      - Installing micro-controller code to /usr/local/bin/

    - Start Klipper service  
      `sudo service klipper start`

    - Confim klipper_mcu service running  
      `sudo systemctl status klipper_mcu.service`

- ##### View raspberry pi gpio pins function/status
  - Install gpiochip
    `sudo apt-get install gpiod`

  - Detect gpiochip
    `gpiodetect`

  - Detect pins
    `gpioinfo`

- ##### Add to printer.cfg (ADXL345)

**printer.cfg**
```
[mcu rpi]
serial: /tmp/klipper_host_mcu

[adxl345]
cs_pin: rpi:None

[resonance_tester]
accel_chip: adxl345
probe_points:
125, 125, 20  # an example
```

- ##### Measuring the resonances
  - Check Connection in mainsailOS  
    `ACCELEROMETER_QUERY`
    > output: accelerometer values (x, y, z): 296.082377, -1110.308913, 9346.365076

  - MEASURE_AXES_NOISE (range ~1-100) (1000+ quality issues)  
    `MEASURE_AXES_NOISE`

  - Measure adxl345 (M112 to abort) (manual resonance compensation)
    `TEST_RESONANCES AXIS=X`
    > output: Resonances data written to /tmp/resonances_x_20230217_173259.csv file

    `TEST_RESONANCES AXIS=Y`
    > output: Resonances data written to /tmp/resonances_y_20230217_173616.csv file

- ##### Process generated CSV files (SSH)

  `~/klipper/scripts/calibrate_shaper.py /tmp/resonances_x_*.csv -o /tmp/shaper_calibrate_x.png`
  > output:  
  ```
  Fitted shaper 'zv' frequency = 85.0 Hz (vibrations = 6.2%, smoothing ~= 0.028)  
  To avoid too much smoothing with 'zv', suggested max_accel <= 28200 mm/sec^2  
  Fitted shaper 'mzv' frequency = 79.0 Hz (vibrations = 0.5%, smoothing ~= 0.035)  
  To avoid too much smoothing with 'mzv', suggested max_accel <= 18400 mm/sec^2  
  Fitted shaper 'ei' frequency = 98.4 Hz (vibrations = 0.5%, smoothing ~= 0.035)  
  To avoid too much smoothing with 'ei', suggested max_accel <= 18000 mm/sec^2  
  Fitted shaper '2hump_ei' frequency = 109.8 Hz (vibrations = 0.0%, smoothing ~= 0.047)  
  To avoid too much smoothing with '2hump_ei', suggested max_accel <= 13400 mm/sec^2  
  Fitted shaper '3hump_ei' frequency = 137.2 Hz (vibrations = 0.0%, smoothing ~= 0.046)  
  To avoid too much smoothing with '3hump_ei', suggested max_accel <= 13800 mm/sec^2  
  Recommended shaper is mzv @ 79.0 Hz
  ```

  `~/klipper/scripts/calibrate_shaper.py /tmp/resonances_y_*.csv -o /tmp/shaper_calibrate_y.png`
  > output: 
  ```
  Fitted shaper 'zv' frequency = 66.6 Hz (vibrations = 10.8%, smoothing ~= 0.041)
  To avoid too much smoothing with 'zv', suggested max_accel <= 17300 mm/sec^2
  Fitted shaper 'mzv' frequency = 62.4 Hz (vibrations = 0.0%, smoothing ~= 0.052)
  To avoid too much smoothing with 'mzv', suggested max_accel <= 11500 mm/sec^2
  Fitted shaper 'ei' frequency = 75.6 Hz (vibrations = 0.3%, smoothing ~= 0.056)
  To avoid too much smoothing with 'ei', suggested max_accel <= 10600 mm/sec^2
  Fitted shaper '2hump_ei' frequency = 94.0 Hz (vibrations = 0.0%, smoothing ~= 0.062)
  To avoid too much smoothing with '2hump_ei', suggested max_accel <= 9800 mm/sec^2
  Fitted shaper '3hump_ei' frequency = 113.0 Hz (vibrations = 0.0%, smoothing ~= 0.065)
  To avoid too much smoothing with '3hump_ei', suggested max_accel <= 9300 mm/sec^2
  Recommended shaper is mzv @ 62.4 Hz
  ```

  - Processed CSV output graphs:  
    `/tmp/shaper_calibrate_x.png`  
    `/tmp/shaper_calibrate_y.png`

  - Add to printer.cfg (manual calibration settings)
**printer.cfg**
```
[input_shaper]
shaper_type_x: mzv
shaper_freq_x: 79.0
shaper_type_y: mzv
shaper_freq_y: 62.4

[printer]
max_accel: 10000           #x_max=18400, y_max=11500
```

- ##### Input Shaper auto-calibration (re-calibration)(does not update max_accel) (mainsailOS)
  `SHAPER_CALIBRATE`  
  `SAVE_CONFIG`

- ##### Resonance Compensation Test Print
  - Download model [Klipper ringing tower](https://www.klipper3d.org/prints/ringing_tower.stl)

  - PrusaSlicer settings:
    > - layer height 0.2
    > - infill and top layers set to 0
    > - use 1-2 perimeters
    > - external perimeters 80-100mm
    > - minimum layer time max 3 seconds
    > - slicer dynamic acceleration control disabled

  - MainsailOS web interface (Klipper)
    - Set square_corner_velocity: 5

    - Increase max_accel_to_decel  
      `SET_VELOCITY_LIMIT ACCEL_TO_DECEL=7000`

    - Disable pressure advance  
      `SET_PRESSURE_ADVANCE ADVANCE=0`

    - If [input_shaper] exists in printer.cfg  
      `SET_INPUT_SHAPER SHAPER_FREQ_X=0 SHAPER_FREQ_Y=0`

    - Set shaper type (deafult: MZV)  
      `SET_INPUT_SHAPER SHAPER_TYPE=MZV`

    - Execute printing variable command  
      `TUNING_TOWER COMMAND=SET_VELOCITY_LIMIT PARAMETER=ACCEL START=1500 STEP_DELTA=500 STEP_HEIGHT=5`

    - **Start print of ringing_tower**

    - Measure oscillations
      - Count number of oscillations inside measurement
        - N = oscillations
          D = distance (mm)
          V = velocity (mm/sec)

    - Calculate ringing frequency  
      `V * N / D = Hz`

----------------------------------------------------------------------------------------------------

