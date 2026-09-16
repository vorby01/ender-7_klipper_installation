#### 08_Mosquitto_Magnum_Hotend_Upgrade.txt

Hotend Blower Fans (EFC-04D24L) 
  - Yellow = positive, Blue = negative
  - replaced stock fans due to fault on one.

Lgx Lite Extruder
Connector: JST-XH 4-pin connector
Motor gear : 10 teeth
Motor length: 20 mm
Motor Diameter: 36mm
Step Angle : 1.8 degree (200 steps per rotation)
Max Torque at : 1800 PPS
Max operating Temperature / Current : 120℃ / 750 mA
Manufacturer : LDO
Manufacturer SKU : LDO-36STH20-1004AHG(XH)
retraction speed : 35 mm/s
retraction distance (bowden) : ~5 mm (0.4 + tube length[mm] x 0.015)
retraction distance (direct drive) for rigid materials : 0.4 mm
retraction distance (direct drive) for soft materials : 3 mm


Change of stepper motor will require adjustment of Vref for extruder (Default reading Vref 1.19v)
- Formula for TMC stepper drivers is Vref = ( I * 2.5 ) / Imax
  I is the target current value measured in Amps 
  Imax is 1.77 on regular mode and 1.2 on SilentStepSticks mode
- Bondtech recommended vref of between .45 - .65

min vref (0.45 * 2.5) / 1.77 = 0.64
max vref (0.65 * 2.5) / 1.77 = 0.92
vref between 0.67v - 0.92v

(0.55 * 2.5) / 1.77 = 0.78v

##Update Klipper Config to suit Lgx Lite Extruder
e-steps value : 562 using 16 microsteps; 1124 using 32 microsteps. 
rotation_distance = full_steps_per_rotation * microsteps / steps_per_mm
rotation_distance = 200 * 16 / 562
rotation_distance = 5.7

Change extruder direction to suit Lgx-Lite Extruder

[extruder] #Driver, Creality Board (TMC2208) (Lgx-Lite Extruder)
dir_pin: PB3  #!PB3 = default direction, PB3 = reverse extruder dimension


##Update Klipper Config to suit new thermister #Slice engineering thermister(300)(ATC Semitec 104NT-4-R025H42G)

[extruder] #Driver, Creality Board (TMC2208) (Lgx-Lite Extruder)
sensor_type: ATC Semitec 104NT-4-R025H42G

Calibrate new thermister
- PID_CALIBRATE HEATER=extruder TARGET=215

Calibrate new nozzle offset
- PROBE_CALIBRATE


#### 2023_07_19 Input shaping (Resonance Compensation)
- Check connection to accelerometer in mainsailos
  -> ACCELEROMETER_QUERY
- Measure axes noise (range ~1-100) (1000+ quality issues)
  -> MEASURE_AXES_NOISE

- Measure resonance (per axis)(generates CSV files)
  -> TEST_RESONANCES AXIS=X
  -> TEST_RESONANCES AXIS=Y

- Process generated CSV files (Requires SSH login)
  -> ~/klipper/scripts/calibrate_shaper.py /tmp/resonances_x_*.csv -o /tmp/shaper_calibrate_x.png
  -> ~/klipper/scripts/calibrate_shaper.py /tmp/resonances_y_*.csv -o /tmp/shaper_calibrate_y.png

- X-axis ssh output
Fitted shaper 'mzv' frequency = 63.2 Hz (vibrations = 0.0%, smoothing ~= 0.051)
To avoid too much smoothing with 'mzv', suggested max_accel <= 11800 mm/sec^2

- Y-axis ssh output
Fitted shaper 'mzv' frequency = 45.2 Hz (vibrations = 1.3%, smoothing ~= 0.100)
To avoid too much smoothing with 'mzv', suggested max_accel <= 6000 mm/sec^2

- Update klipper printer.cfg
//**printer.cfg**\\
[input_shaper]
shaper_type_x: mzv
shaper_freq_x: 63.2
shaper_type_y: mzv
shaper_freq_y: 45.2

[printer]
max_accel: 10000           #x_max=11800, y_max=6000
//**printer.cfg**\\

- To recalibrate after adjustment (Input Shaper auto-calibration (re-calibration)(does not update max_accel))
  -> SHAPER_CALIBRATE
  -> SAVE_CONFIG


#### 2023_08_15 Pressure Advance Tuning
  - 0.4mm nozzle brass

- Slicer 
  - Set zero infill, and a coarse layer height (the layer height should be around 75% of the nozzle diameter). Make sure any "dynamic acceleration control" is disabled in the slicer.
  - Layer Height: 0.75 * 0.4 = 0.3
  - Layer Width: 1.1 * 0.4 = 0.44
  - Estimated volume: 0.44mm * 0.3mm * 100mm/s = 13.2mm^3/sec

- Klipper
  - SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=1 ACCEL=500
  - TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.005
- Start tuning tower print

- Measure print
- Calculate pressure advance value
  - pressure_advance = <start> + <measured_height> * <factor>
  0 + 30 * 0.005 = 0.15

- Update klipper printer.cfg
[extruder]
pressure_advance = 0.15


