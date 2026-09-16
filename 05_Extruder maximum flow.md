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

  | Command       | Feed rate |              |
  |---------------|-----------|--------------|
  | `G1 E50 F60`  | #1mm/s    |              |
  | `G1 E50 F120` | #2mm/s    |              |
  | `G1 E50 F180` | #3mm/s    |              |
  | `G1 E50 F240` | #4mm/s    |              |
  | `G1 E50 F300` | #5mm/s    |              |
  | `G1 E50 F360` | #6mm/s    |              |
  | `G1 E50 F420` | #7mm/s    |              |
  | `G1 E50 F480` | #8mm/s    |              |
  | `G1 E50 F540` | #9mm/s    |              |
  | `G1 E50 F600` | #10mm/s   | losing steps |

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

- gcode details:
  > - nozzle: 0.4
  > - line_width: 0.48
  > - layer_height: 0.2
  > - perimeters: 1
  > - material: PLA
  > - Temp_bed: 60
  > - Temp_nozzle: 215

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
- [https://www.cnckitchen.com/blog/extrusion-system-benchmark-tool-for-fast-prints](https://www.cnckitchen.com/blog/extrusion-system-benchmark-tool-for-fast-prints)
  - will require a milligram scale
- [https://www.printables.com/model/160335-hotened-benchmark-test-g-codes](https://www.printables.com/model/160335-hotened-benchmark-test-g-codes)
