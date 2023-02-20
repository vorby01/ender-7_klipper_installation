### Resonance compensation (requires ADXL345)
  - Mount ADXL345 to print head securely
    - print mounting bracket: 20230216_ADXL345_Mount.3mf (printed on prusa_mini+)

  - ADXL345 to RaspberryPi4 wiring
    - CAT5 cable colours
      - Green       Green-White
      - Orange     Orange-White
      - Blue          Blue-White
      - Brown       Brown-White

    - Recommended twisted pairing (minimum interferance)
      - GND+MISO
      - 3.3V+MOSI
      - SCLK+CS

    - Raspberry Pi Wiring
      - Pin     GPIO          ADXL345     SPI        Colour
      - 17      3.3v          VCC                    RED
      - 19      GPIO 10       SDA         MOSI       YELLOW
      - 20      GND           GND                    BLACK
      - 21      GPIO 9        SDO         MISO       GREEN
      - 23      GPIO 11       SCL         SCLK       ORANGE
      - 24      GPIO 8        CS          CS         BLUE

    - RPi4 to ADXL345 wiring (CAT5 pairs)
      - ADXL345     Colour       CAT5 Colour
      - GND         BLACK        Green-White
      - SDO         GREEN        Green

      - 3.3         RED          Orange
      - SDA         YELLOW       Orange-White

      - SCL         ORANGE       Blue-White
      - CS          BLUE         Blue

  - Additional required software installation
    - > sudo apt update
    - > sudo apt install python3-numpy python3-matplotlib libatlas-base-dev
    - > ~/klippy-env/bin/pip install -v numpy

  - Ensure SPI is enabled 
    - > sudo raspi-config > interfacing options > enable SPI

  - Enable rpi host as secondary MCU in klipper
    - install start script (run klipper_mcu before klippy process
      - > cd ~/klipper/
      - > sudo cp ./scripts/klipper-mcu.service /etc/systemd/system/
      - > sudo systemctl enable klipper-mcu.service

  - Build and flash code for raspberry pi (dir: ~/klipper/)
    - Create configuration menu (open gui)
      - > make menuconfig
    - Choose a processor model
      - > select Linux process
      - > quit and save
    - Stop Klipper service
      - > sudo service klipper stop
    - Flash Raspberry Pi as secondary mcu
      - > make flash
        -(Installing micro-controller code to /usr/local/bin/)
    - Start Klipper service
      - > sudo service klipper start

    - Confim klipper_mcu service running
      - > sudo systemctl status klipper_mcu.service

  - View raspberry pi gpio pins function/status
    - Install gpiochip
      - > sudo apt-get install gpiod
    - Detect gpiochip
      - > gpiodetect
    - Detect pins
      - > gpioinfo

  - Add to printer.cfg (ADXL345)
//**printer.cfg**\\
[mcu rpi]
serial: /tmp/klipper_host_mcu

[adxl345]
cs_pin: rpi:None

[resonance_tester]
accel_chip: adxl345
probe_points:
125, 125, 20  # an example
//**printer.cfg**\\

  - Measuring the resonances
    - Check Connection in mainsailos
      - > ACCELEROMETER_QUERY
        - return: accelerometer values (x, y, z): 296.082377, -1110.308913, 9346.365076
    - MEASURE_AXES_NOISE (range ~1-100) (1000+ quality issues)
      - > MEASURE_AXES_NOISE
      
    - Measure adxl345 (M112 to abort) (manual resonance compensation)
      - > TEST_RESONANCES AXIS=X
        - return: Resonances data written to /tmp/resonances_x_20230217_173259.csv file
      - > TEST_RESONANCES AXIS=Y
        - return: Resonances data written to /tmp/resonances_y_20230217_173616.csv file
        
    - Process generated CSV files (SSH)
      - > ~/klipper/scripts/calibrate_shaper.py /tmp/resonances_x_*.csv -o /tmp/shaper_calibrate_x.png
        - return:  Fitted shaper 'zv' frequency = 85.0 Hz (vibrations = 6.2%, smoothing ~= 0.028)
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

      - > ~/klipper/scripts/calibrate_shaper.py /tmp/resonances_y_*.csv -o /tmp/shaper_calibrate_y.png
        - return: Fitted shaper 'zv' frequency = 66.6 Hz (vibrations = 10.8%, smoothing ~= 0.041)
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

      - Processed CSV output graphs:
        - /tmp/shaper_calibrate_x.png
        - /tmp/shaper_calibrate_y.png

      - Add to printer.cfg (manual calibration settings)
//**printer.cfg**\\
[input_shaper]
shaper_type_x: mzv
shaper_freq_x: 79.0
shaper_type_y: mzv
shaper_freq_y: 62.4

[printer]
max_accel: 10000           #x_max=18400, y_max=11500
//**printer.cfg**\\

  - Input Shaper auto-calibration (re-calibration)(does not update max_accel)
    - > SHAPER_CALIBRATE
    - > SAVE_CONFIG

  - Resonance Compensation Test Print
    - Download model https://www.klipper3d.org/prints/ringing_tower.stl
    - PrusaSlicer settings:
      - layer height 0.2
      - infill and top layers set to 0
      - use 1-2 perimeters
      - external perimeters 80-100mm
      - minimum layer time max 3 seconds
      - slicer dynamic acceleration control disabled

  - MainsailOS web interface (Klipper)
    - Set square_corner_velocity: 5
    - Increase max_accel_to_decel
      - > SET_VELOCITY_LIMIT ACCEL_TO_DECEL=7000
    - Disable pressure advance
      - > SET_PRESSURE_ADVANCE ADVANCE=0
    - If [input_shaper] exists in printer.cfg
      - > SET_INPUT_SHAPER SHAPER_FREQ_X=0 SHAPER_FREQ_Y=0
    - Set shaper type (deafult: MZV)
      - > SET_INPUT_SHAPER SHAPER_TYPE=MZV
    - Execute printing variable command
      - > TUNING_TOWER COMMAND=SET_VELOCITY_LIMIT PARAMETER=ACCEL START=1500 STEP_DELTA=500 STEP_HEIGHT=5
    - Start print of ringing_tower
    
    - Measure oscillations
      - Count number of oscillations inside measurement
        - N = oscillations
          D = distance (mm)
          V = velocity (mm/sec)
    - Calculate ringing frequency
      - V * N / D = Hz
      -
      
