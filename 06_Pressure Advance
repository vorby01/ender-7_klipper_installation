### Pressure Advance (advanced extrusion calibration)
  - Requires e-steps/flow-rate calibration first
  - Specific to each filament
  
  - Download Klipper pressure advance square tower
    - https://www.klipper3d.org/prints/square_tower.stl

  - Slicer settings (square_tower.stl) 
    - Zero infill
    - Coarse layer height (75% of nozzle diameter)(0.4 nozzle = 0.3 layer height)
    - Any kind of slicer dynamic acceleration is disabled
    - Use a high speed (eg,100mm/s) (prusaslicer default:40mm/s)(extruder max flow rate may need to measured first)
        
  - Prepare for test (klipper commands before starting print)
    - > SET_VELOCITY_LIMIT SQUARE_CORNER_VELOCITY=1 ACCEL=500
    - For direct drive extruder
      - > TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.005
    - For long bowden extruders
      - > TUNING_TOWER COMMAND=SET_PRESSURE_ADVANCE PARAMETER=ADVANCE START=0 FACTOR=.020

  - Print square_tower.stl
    - If corners are no longer printing well print can be cancelled

  - Measure with calipers from bottom of print to where corners look best
    - eg, height= 30mm

  - Calculate pressure advance (bowden)
    - pressure_advance = <start> + <measured_height> * <factor>
    - 0 + (30 * 0.02) = 0.6

  - Typical pressure advance values are between 0.050 and 1.000
      
  - Update printer.cfg
//**printer.cfg**\\
[extruder]
pressure_advance = 0.6
//**printer.cfg**\\
